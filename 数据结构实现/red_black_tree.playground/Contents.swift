import UIKit



var NIL = Node.init(0, 1, nil, nil)

class Node: NSObject {
    var key: Int = 0
    var color: Int = 0// 0: red 1: black 2: double black
    var lChild: Node = NIL
    var rChild: Node = NIL

    init(_ key: Int = 0, _ color: Int = 0, _ lChi: Node? = nil, _ rChi: Node? = nil) {
        self.key = key
        self.color = color
        self.lChild = lChi == nil ? NIL : lChi!
        self.rChild = rChi == nil ? NIL : rChi!
    }
}

func left_rotate(_ root: inout Node) -> Node {
    var temp = root.rChild
    root.rChild = temp.lChild
    temp.lChild = root
    return temp
}
func right_rotate(_ root: inout Node) -> Node {
    var temp = root.lChild
    root.lChild = temp.rChild
    temp.rChild = root
    return temp
}

func has_red_child(_ root: Node) -> Bool {
    return root.lChild.color == 0 || root.rChild.color == 0
}

func insert_maintain(_ root: inout Node) -> Node {
    var flag = 0
    if root.lChild.color == 0 && has_red_child(root.lChild) {
        flag = 1 // 冲突发生在左子树
    }
    if root.rChild.color == 0 && has_red_child(root.rChild) {
        flag = 2 // 冲突发生在右子树
    }
    if flag == 0 {return root}
    /// 有冲突
    if root.lChild.color == 0 && root.rChild.color == 0 { // 左右子树是红色
        root.color = 0
        root.lChild.color = 1
        root.rChild.color = 1
        return root
    }
    if flag == 1 {// 冲突在左子树
        if root.lChild.rChild.color == 0 {
            root.lChild = left_rotate(&root.lChild)/// 小左旋
        }
        root = right_rotate(&root) // 大右旋
    } else { //冲突在右子树
        if root.rChild.lChild.color == 0 {
            root.rChild = right_rotate(&root.rChild)/// 小左旋
        }
        root = left_rotate(&root) // 大右旋
    }
    
    /// 红色上浮
    root.color = 0
    root.lChild.color = 1
    root.rChild.color = 1
    return root
    
}
func __insert(_ root: inout Node, _ key: Int) -> Node {
    if root == NIL {return getNewNode(key)}
    if key == root.key{return root}
    if key < root.key {
        root.lChild = __insert(&root.lChild, key)
    }else {
        root.rChild = __insert(&root.rChild, key)
    }
    return insert_maintain(&root)
}
func insert(_ root: inout Node, _ key: Int) -> Node {
    root = __insert(&root, key)
    root.color = 1
    return root
}

func getNewNode(_ key: Int) -> Node {
    return Node(key)
}

func erase_maintain(_ root: inout Node) -> Node {
    if root.lChild.color != 2 && root.rChild.color != 2 {
        return root
    }
    var flag = 0
    if has_red_child(root) { //兄弟节点是红色
        root.color = 0
        if root.lChild.color == 0 {
            root = right_rotate(&root)
            flag = 1
        } else {
            root = left_rotate(&root)
            flag = 2
        }
        root.color = 1
        
        if flag == 1 { // 递归到右子树调整
            root.rChild = erase_maintain(&root.rChild)
        } else {
            root.lChild = erase_maintain(&root.lChild)
            
        }
        return root
    }
    //1
    if (root.lChild.color == 1 && !has_red_child(root.lChild)) || (root.rChild.color == 1 && !has_red_child(root.rChild)) {
        root.lChild.color -= 1
        root.rChild.color -= 1
        root.color += 1
    }
    //2
    if root.lChild.color == 1 { //类型
        root.rChild.color = 1
        if root.lChild.lChild.color != 0 {
            root.lChild.color = 0
            root.lChild = left_rotate(&root.lChild)
            root.lChild.color = 1
        }
        root.lChild.color = root.color
        root = right_rotate(&root)
        
    } else {
        root.lChild.color = 1
        if root.rChild.rChild.color != 0 {
            root.rChild.color = 0
            root.rChild = right_rotate(&root.rChild)
            root.rChild.color = 1
        }
        root.rChild.color = root.color
        root = left_rotate(&root)
    }
    
    root.lChild.color = 1
    root.rChild.color = 1
    
    return root
}

func predecessor(_ root: Node) -> Node {
    var temp = root.lChild
    while temp.rChild != NIL {temp = temp.rChild}
    return temp
}

func __erase(_ root: inout Node, _ key: Int) -> Node {
    if root == NIL {return root}
    if key < root.key {
        root.lChild = __erase(&root.lChild, key)
    } else if key > root.key {
        root.rChild = __erase(&root.rChild, key)
    } else {
        if root.lChild == NIL || root.rChild == NIL {
            let temp = root.lChild == NIL ? root.rChild : root.lChild
            temp.color += root.color
            return temp
        } else {
            var temp = predecessor(root)
            root.key = temp.key
            root.lChild = __erase(&root.lChild, temp.key)
        }
    }
    return erase_maintain(&root)
}

func erase(_ root: inout Node, _ key: Int) -> Node {
    var r = __erase(&root, key)
    r.color = 1
    return r
}

func clear(_ root: Node?) {
    if root == nil {return}
    clear(root?.lChild)
    clear(root?.rChild)
}


func output(_ root: Node) {
    if root == NIL {return}
    print("\(root.color) | \(root.key), \(root.lChild.key), \(root.rChild.key)")
    output(root.lChild)
    output(root.rChild)
}

/// 测试
var root = Node(1, 0, NIL, NIL)
var arr = [1,2,3,4,5,6]
for i in arr {
    _ = insert(&root, i)
}
output(root)
erase(&root, 3)
print("_______")
output(root)
