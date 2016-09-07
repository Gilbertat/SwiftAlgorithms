//: Playground - noun: a place where people can play

/*
 Determine whether an integer is a palindrome. Do this without extra space.
 */

import UIKit

// >>>>>>>>>>>>>>>>>>>>>>>>> Palindrome Number <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class IsPalindrome {
    class func isPalindrome(x: Int) -> Bool {
        if x < 0 {
            return false
        }else if x == 0 {
            return true
        }else {
            var intPutInt = x
            var tempInt = 0
            
            while intPutInt > 0 {
                tempInt = tempInt * 10 + intPutInt % 10
                
                intPutInt = intPutInt / 10
            }
            
            if tempInt == x {
                return true
            }else {
                return false
            }
        }
    }
}

// >>>>>>>>>>>>>>>>>>>>>>>>> Test <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class IsPalindromeTest {
    class func isPalindrome_test() {
        NSLog("Is the %d a Palindrome Number ? %@", 121, IsPalindrome.isPalindrome(x: 121))
        
        NSLog("Is the %d a Palindrome Number ? %@", 112211, IsPalindrome.isPalindrome(x: 112211))

        NSLog("Is the %d a Palindrome Number ? %@", 1122332211,IsPalindrome.isPalindrome(x: 1122332211))
        
        NSLog("Is the %d a Palindrome Number ? %@", 1122332211,IsPalindrome.isPalindrome(x: 123456654321))

        NSLog("Is the %d a Palindrome Number ? %@", 1122332211,IsPalindrome.isPalindrome(x: 123456))

        NSLog("Is the %d a Palindrome Number ? %@", 1122332211,IsPalindrome.isPalindrome(x: 12312421531521))

        NSLog("Is the %d a Palindrome Number ? %@", 1122332211,IsPalindrome.isPalindrome(x: 1241243127658326))
    }
}

IsPalindromeTest.isPalindrome_test()
