import UIKit



/// 树状数组
class FenwickTree {

    init(_ n: Int) {
        arr = Array(repeating: 0, count: n+1)
        self.n = n
    }

    func add(_ ind: Int, _ x: Int) {
        var i = ind
        while i <= n {
            arr[i] += x
            i += lowbit(i)
        }
    }

    func query(_ ind: Int) -> Int {
        var sum = 0
        var i = ind
        while i > 0 {
            sum += arr[i]
            i-=lowbit(i)
        }
        return sum
    }

    func lowbit(_ x: Int) -> Int{
        return x & (-x)
    }

    var arr: [Int]
    var n = 0
}
