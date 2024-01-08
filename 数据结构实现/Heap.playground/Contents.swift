import UIKit



/**
 堆、是一种完全二叉树
 具体实现可以用数组方式
 性质：
    对于元素 x，其所在位置下标为 i （注：i 从 0 开始）
    则其左孩子下标为 2i+1， 右孩子下标为 2i+2
    其父节点下标为 (i-1)/2
 */

class Heap {
    /// 堆 中元素数量
    var cnt: Int {return arr.count}
    /// 堆顶元素
    var top: Int? {return arr.first}
    /// 堆中元素
    var items: [Int] {return arr}
    
    func push(_ x: Int) {
        // 插入元素到队尾
        arr.append(x)
        // 将元素向上调整
        var ind = arr.count - 1
        var faInd = getFa(ind)
        while (ind >= 0 && faInd >= 0 && self.compare(arr[ind], arr[faInd]) == true) {
            arr.swapAt(ind, faInd)
            ind = faInd
            faInd = getFa(ind)
        }
    }
    
    func pop() -> Int? {
        guard arr.count > 0 else {return nil}
        
        /// 将堆顶元素移动到队尾，并弹出元素， 此时原来队尾较小元素在堆顶位置
        arr.swapAt(0, arr.count - 1)
        let top = arr.removeLast()
        /// 将堆顶元素执行向下调整,
        var ind = 0
        var leftChildInd = 2*ind+1
        var rightChildInd = 2*ind+2
        while(leftChildInd <= cnt-1) { /// 判断是否有子节点
            /// temp 指向一个循环内，一个三元组的最大值
            /// 找到最大值
            var temp = ind
            if self.compare(arr[leftChildInd], arr[temp]) {
                temp = leftChildInd
            }
            if rightChildInd <= cnt-1 && self.compare(arr[rightChildInd], arr[temp]){
                temp = rightChildInd
            }
            if temp == ind{ break }
            
            arr.swapAt(temp, ind)
            ind = temp
            leftChildInd = 2*ind+1
            rightChildInd = 2*ind+2
        }
        return top
    }
    
    init(isBigTop: Bool = true) {
        self.isBigTop = isBigTop
    }
    
    /// 大顶\小顶堆
    /// 堆的实现方式 数组保存
    private var arr = [Int]()
    private var isBigTop = true
    ///获取 i 位置的父节点下标
    private func getFa(_ i: Int) -> Int { return (i-1)/2 }
    
    private func compare(_ crt: Int, _ item: Int) -> Bool {
        return isBigTop ? crt>item : crt<item
    }
}

var h1 = Heap.init(isBigTop: false)

h1.push(2)
h1.push(5)
h1.push(1)
h1.push(3)
h1.push(8)
h1.push(10)
h1.push(7)
h1.push(4)
h1.push(11)
var d = ["asd": 123]
//d.keys

var arr1 = [1,2,3]
var a: [Int] = Array(arr1[0...2])

//print(h1.pop()!)
//print(h1.pop()!)
//print(h1.pop()!)
//print(h1.pop()!)
//print(h1.pop()!)
//print(h1.pop()!)
//print(h1.pop()!)
//print(h1.pop()!)
//print(h1.pop()!)
//print(h1.pop())


/// 堆排序
var arr: [Int] = [2,5,1,3,8,10,7,4,3,7,5]

func heapSort(_ arr: inout [Int]) {
    
    /// 1.构建大顶堆
    for i in stride(from: 0, to: arr.count, by: 1) {
        /// ind: 需要调整元素所在的位置， 该位置以前是已经构建好的堆
        var ind = i
        var faInd = (ind - 1) / 2
        while (ind >= 0 && faInd >= 0 && arr[ind] > arr[faInd]) {
            arr.swapAt(ind, faInd)
            ind = faInd
            faInd = (ind - 1) / 2
        }
    }

    /// 2. 将队首元素移动到队尾， 并重建最大堆
    for i in stride(from: arr.count - 1, through: 0 , by: -1) {
        if i <= 0 { return }
        arr.swapAt(0, i)
        /// 3. 将堆顶元素执行向下调整,
        var ind = 0
        while(2*ind+1 <= i-1) { /// 判断是否有子节点
            /// temp 指向一个循环内，一个三元组的最大值
            /// 找到最大值
            var temp = ind
            if arr[2*ind+1] > arr[temp] {
                temp = 2*ind+1
            }
            if 2*ind+2 <= i-1 && arr[2*ind+2] > arr[temp] {
                temp = 2*ind+2
            }
            if temp == ind{ break }
            
            arr.swapAt(temp, ind)
            ind = temp
        }
    }
}

heapSort(&arr)

print(arr)




