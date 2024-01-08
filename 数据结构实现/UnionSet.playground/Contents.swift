import UIKit

/// 解决集合的联通问题
struct UnionSet {
    init(_ n: Int) {
        fa = Array(0..<n)
        size = Array.init(repeating: 1, count: n)
    }
    
    func merge(_ a: Int, _ b: Int) {
        if find(a) == find(b) { return }
        
        let cnta = size[find(a)]
        let cntb = size[find(b)]
        if cnta >= cntb {
            size[find(a)] += size[find(b)]
            fa[find(b)] = fa[find(a)]
        } else {
            size[find(b)] += size[find(a)]
            fa[find(a)] = fa[find(b)]
        }
        print("merge \(fa) - \(size)")
    }
    
    /// 查找该点所在集合的父节点
    func find(_ x: Int) -> Int {
        if fa[x] == x {
            return x
        }
        /// 剪枝操作
        /// 每次查询时，直接将所查询的节点挂到其父节点下，提高查询效率
        var fax = find(fa[x])
        fa[x] = fax
//        print("find \(fa) - \(size)")
        return fax
    }
    
    private var fa = [Int]() /// 记录改点所在集合父节点的下标
    private var size = [Int]() /// 若该点是父节点的话，表示该父节点集合总数
    
}

let union = UnionSet(10)

union.merge(0, 1)
union.merge(1, 2)

union.merge(7, 9)
union.merge(8, 9)

union.merge(4, 5)
union.merge(5, 6)

union.merge(1,7)
union.merge(9, 6)

let arr = [1,2]
var a1 = [3,5]
a1.append(contentsOf: arr)

//union.find(9)
//union.find(0)
//union.find(1)
//union.find(3)
//
//union.find(7)
