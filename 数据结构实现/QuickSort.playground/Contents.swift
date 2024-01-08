import UIKit

var greeting = "Hello, playground"


func quickSort(_ arr: inout [Int],_ left: Int,_ right: Int) {
    if left >= right { return }
    let pivot = arr[left]
    var i = left
    var j = right
    while i<j {
        while(i<j && arr[j]>pivot){
            j-=1 /// 从右侧找到比 pivot 小的元素
        }
        if(i<j) { /// 将找到的元素放到 i 的位置，并 i + 1
            arr[i] = arr[j]
            i+=1
        }
        while(i<j && arr[i]<pivot){
            i+=1/// 从左侧找到比 pivot 大的元素
        }
        if(i<j) {
            arr[j]=arr[i]
            j-=1
        }
    }
    arr[i] = pivot
    quickSort(&arr, 0, i-1)
    quickSort(&arr, i+1, right)

}

/// 单边递归的优化,  该算法基准元素右边使用递归排序， 左边使用迭代排序
func quickSort_v2(_ arr: inout [Int],_ l: Int,_ r: Int) {
    var left = l, right = r
    while left < right {
        let pivot = arr[left]
        var i = left
        var j = right
        while i<j {
            while(i<j && arr[j]>pivot){
                j-=1 /// 从右侧找到比 pivot 小的元素
            }
            if(i<j) { /// 将找到的元素放到 i 的位置，并 i + 1
                arr[i] = arr[j]
                i+=1
            }
            while(i<j && arr[i]<pivot){
                i+=1/// 从左侧找到比 pivot 大的元素
            }
            if(i<j) {
                arr[j]=arr[i]
                j-=1
            }
        }
        arr[i] = pivot
//        quickSort(&arr, 0, i-1)
        quickSort_v2(&arr, i+1, right)
        right = i-1
    }
    
}


var arr = [11,8,9,2,3,1,5,7,4]
quickSort(&arr, 0, 8)
print(arr)
