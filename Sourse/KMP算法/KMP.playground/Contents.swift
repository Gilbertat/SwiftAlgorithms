//: ## KMP 算法的 Swift 实现

import  Foundation


let textStr = "BBCEABCDABEABCDABCDABDE"
let patternStr = "ABCDABD"

/**
 字符串匹配的暴力算法
 - parameter TextStr:    原始的文本字符串,主串
 - parameter patternStr: 要匹配的模式字符串，模式串
 
 - returns: 正确匹配返回模式串的位置，匹配错误返回 -1
 */
func violenceMatch(TextStr: String, patternStr: String) -> Int {
    var indexI = TextStr.startIndex
    var indexJ = patternStr.startIndex
    
    while (indexI < TextStr.endIndex && indexJ < patternStr.endIndex) {
        if TextStr[indexI] == patternStr[indexJ] {
            if indexJ == patternStr.index(before: patternStr.endIndex) {
                // 如果匹配到最后一个字符，则匹配成功，返回当前的indexI - indexJ 的位置
                return TextStr.distance(from: indexJ, to: indexI)
            }
            //如果当前字符串匹配成功，则同时向后移动一位
            indexI = TextStr.index(indexI, offsetBy: 1)
            indexJ = patternStr.index(indexJ, offsetBy: 1)
        }else {
            //如果匹配失败，则 TextStr 要回退到上次匹配开始的位置，同时 patternStr 的 index 置0
            let distance = TextStr.distance(from: indexJ, to: indexI) + 1
            indexI = TextStr.index(patternStr.startIndex, offsetBy: distance)
            indexJ = patternStr.startIndex
        }
        
    }
    return -1
}


print(violenceMatch(TextStr: textStr, patternStr: patternStr))



// KMP 算法
/*
 当失配时，不移动i，而是利用之前的匹配信息以及子串相同前缀后缀的信息来继续匹配，如果存在相同的前缀后缀，
 相当于直接跳到后缀的地方开始匹配。
 比如...ABCDABE...若子串为ABCDABD，当匹配到 E 和 D 时，匹配失败，这时候不要回退i，可以发现 ABCDAB 和 ABCDAB 匹配时，
 子串向右移动时，必然匹配失败（相当于两个相同的子串错开），但是什么时候可以匹配成功并开始重新匹配呢？发现其中有相同的前缀AB和后缀AB，所以现在可以
 直接让子串的前缀和原始串的后缀对齐，然后继续开始匹配。
 
 */

// 递归求解 next 数组
func recurGetNext(patternStr: String, count: Int) -> [Int] {
    var next = [Int]()
    if count == 1 {
        return [-1]
    }//注意 count 是字符串的长度不是下标
    next = recurGetNext(patternStr: patternStr, count: count - 1)
    var k: Int = next[count - 2] //注意长度是 count-1 ，则最后一个字符的下标是 count-2
    while k != -1 {
        if patternStr[patternStr.index(patternStr.startIndex, offsetBy: count - 2)] == patternStr[patternStr.index(patternStr.startIndex, offsetBy: k)] {
            break
        }
        k = next[k]
    }
    next.append(k+1)
    return next
}

recurGetNext(patternStr: patternStr, count: patternStr.characters.count)

func getNext(patternStr: String) -> [Int] {
    let count = patternStr.characters.count
    var k = -1
    var next = Array(repeating: -1, count: count)
    for var j in stride(from: 0, to: count - 1, by: 1) {
        while (k != -1 && patternStr[patternStr.index(patternStr.startIndex, offsetBy: j)] != patternStr[patternStr.index(patternStr.startIndex, offsetBy: k)]) {
            k = next[k]
        }
        k += 1
        j += 1
        next[j] = k
    }
    return next
    
}

getNext(patternStr: patternStr)



func getNextOpt(patternStr: String) -> [Int] {
    let count = patternStr.characters.count
    var k = -1
    var next = Array(repeating: -1, count: count)
    for var j in stride(from: 0, to: count - 1, by: 1) {
        while (k != -1 && patternStr[patternStr.index(patternStr.startIndex, offsetBy: j)] != patternStr[patternStr.index(patternStr.startIndex, offsetBy: k)]) {
            k = next[k]
        }
        k += 1
        j += 1
        if patternStr[patternStr.index(patternStr.startIndex, offsetBy: j)] != patternStr[patternStr.index(patternStr.startIndex, offsetBy: k)] {
            next[j] = k
        } else {
            next[j] = next[k]
        }
    }
    return next
}

getNextOpt(patternStr: patternStr)



/**
 字符串匹配的 KMP 算法
 - parameter TextStr:    原始的文本字符串,主串
 - parameter patternStr: 要匹配的模式字符串，模式串
 
 - returns: 正确匹配返回模式串的位置，匹配错误返回 -1
 */
func KMPMatch(TextStr: String, patternStr: String) -> Int {
    var indexI = TextStr.startIndex
    var indexJ = patternStr.startIndex
    var j = 0
    let next = getNextOpt(patternStr: patternStr)
    
    while (indexI < TextStr.endIndex && indexJ < patternStr.endIndex) {
        if j == -1 || TextStr[indexI] == patternStr[indexJ] {
            j += 1
            if indexJ == patternStr.index(before: patternStr.endIndex) {
                // 如果匹配到最后一个字符，则匹配成功，返回当前的indexI - indexJ 的位置
                return TextStr.distance(from: indexJ, to: indexI)
            }
            //如果当前字符串匹配成功，则同时向后移动一位
            indexI = TextStr.index(indexI, offsetBy: 1)
            indexJ = patternStr.index(indexJ, offsetBy: 1)
        }else {
            //如果匹配失败，则 TextStr 的 indexI 保持不变，同时 patternStr 的 indexJ 跳到 next[j] 的位置
            //如果next[j] = -1 ,直接跳到 P 的开头
            let distance = TextStr.distance(from: patternStr.startIndex, to: indexJ)
            j = next[distance]
            if j == -1 {
                indexJ = patternStr.startIndex
            } else {
                indexJ = patternStr.index(patternStr.startIndex, offsetBy: j)
            }
        }
        
    }
    return -1
}

print("文本串T为 " + textStr)
print("模式串P为 " + patternStr)

let index = KMPMatch(TextStr: textStr, patternStr: patternStr)

if index > -1 {
    print("模式串P第一次匹配成功的位置为 \(index)")
}else {
    print("匹配失败")
}






