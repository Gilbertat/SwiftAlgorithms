//: Playground - noun: a place where people can play

/*
 Given a string S, find the longest palindromic substring in S. You may assume that the maximum length of S is 1000, and there exists one unique longest palindromic substring.
 */

import UIKit

// >>>>>>>>>>>>>>>>>>>>>  Longest Palindromic Substring <<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

//Matrix (二维数组)
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Int]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0, count: rows * columns)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Int {
        get {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            
            grid[(row * columns) + column] = newValue
        }
    }
}

class LongestPalindrome {
    // DP (动态规划法)
    class func longestPalindrome_dp(s: String) -> String {
        if s.isEmpty {
            return ""
        }else if s.characters.count == 1 {
            return s
        }
        
        var charactersArr = Array<Character>()
        var starIndex = 0, endInedx = 0
        var resultString = String()
        for character in s.characters {
            charactersArr.append(character)
        }
 
        var table = Matrix.init(rows: 1001, columns: 1001)
        
        for i in stride(from: s.characters.count - 1, to: 0, by: -1) {
            for j in i ..< s.characters.count {
                if (charactersArr[i] == charactersArr[j]) && (j - i <= 2 || table[i + 1, j - 1] == 1) {
                    table[i, j] = 1
                    
                    if endInedx - starIndex < j - i {
                        starIndex = i; endInedx  = j
                    }
                }
            }
        }
        
        for i in starIndex ... endInedx {
            resultString.append(charactersArr[i])
        }
        
        return resultString
    }
    
    //Manacher's Algorithm (马拉车算法)
    class func longestPalindrome_ma(s: String) -> String {
        var charactersArr = Array<Character>()
        var resultString = String()
        var maxPoint = 0
        
        charactersArr.append("$")
        for character in s.characters {
            charactersArr.append("#")
            charactersArr.append(character)
        }
        charactersArr.append("#")
        charactersArr.append("%")
        
        var rightMax = 0, middlePoint = 0
        var lenArr = Array.init(repeating: 1, count: charactersArr.count)
        
        for i in 1 ..< 2 * s.characters.count + 2 {
            if rightMax > i {
                lenArr[i] = min(rightMax - i, lenArr[2 * middlePoint - i])
            }
            
            while charactersArr[i - lenArr[i]] == charactersArr[i + lenArr[i]] {
                lenArr[i] += 1
            }
           
            if lenArr[i] + i > rightMax {
                middlePoint = i
                
                rightMax = lenArr[i] + i
            }
            
            if lenArr[i] > lenArr[maxPoint] {
                maxPoint = i
            }
        }
        
        for i in stride(from: maxPoint - (lenArr[maxPoint] - 2), to: maxPoint + (lenArr[maxPoint] - 1), by: 2) {
            resultString.append(charactersArr[i])
        }
        
        return resultString
    }
}

// >>>>>>>>>>>>>>>>>>>>>  Test <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //
class LongestPalindromeTest {
    class func longestPalindrome_dp_test() {
        NSLog("The longest palindromic substring is %@", LongestPalindrome.longestPalindrome_dp(s: "asdfghjkllkjhgfds"))
    }
    class func longestPalindrome_ma_test() {
        NSLog("The longest palindromic substring is %@", LongestPalindrome.longestPalindrome_ma(s: "qwertyuioppoiuytrew"))
    }
}

LongestPalindromeTest.longestPalindrome_ma_test()
