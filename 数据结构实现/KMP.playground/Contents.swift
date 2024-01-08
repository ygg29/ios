import UIKit

var greeting = "Hello, playground"

func getNext(_ pattern: String) -> [Int] {
    let s = Array(pattern)
    var j = -1
    var next = Array(repeating: 0, count: pattern.count)
    next[0] = -1
    for i in 1..<pattern.count {
        while j != -1 && s[j+1] != s[i] {j = next[j]}
        if s[j + 1] == s[i] {j += 1}
        next[i] = j
    }
    
    return next
}

func kmp(_ text: String, _ pattern: String) -> Int{
    let t = Array(text)
    let p = Array(pattern)
    let next = getNext(pattern)
    var j = -1
    for i in 0..<text.count {
        while j != -1 && t[i] != p[j+1] { j = next[j] }
        if t[i] == p[j+1] {j += 1}
        if j+1 == pattern.count {return i - j }
    }
    return -1
}

print(kmp("hello", "ll"))
