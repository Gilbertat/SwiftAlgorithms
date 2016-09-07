//: Playground - noun: a place where people can play

/*
 Implement atoi to convert a string to an integer.
 
 Hint: Carefully consider all possible input cases. If you want a challenge, please do not see below and ask yourself what are the possible input cases.
 
 Notes: It is intended for this problem to be specified vaguely (ie, no given input specs). You are responsible to gather all the input requirements up front.
 */

import UIKit

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> String to Integer (atoi) <<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class MyAtoi {
    class func myAtoi(str: String) -> Int {
        if str.characters.count == 0 {
            return 0
        }
        
        var resultInt = 0
        var sign = 1
        
        for character in str.characters {
            if character == " " {
                continue
            }
            
            if character == "+" {
                continue
            }
            
            if character == "-" {
                sign = -1
                
                continue
            }
            
            guard let intValue = Int(String(character)) else {
                continue
            }
            
            if resultInt * 10 >= (Int.max - intValue) {
                if sign == -1 {
                    return Int.min
                }else {
                    return Int.min
                }
            }
            
            resultInt = resultInt * 10 + intValue
            
        }
        
        return sign * resultInt
    }
}

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Test <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class MyAtoiTest {
    class func myAtoi_test() {
        NSLog("The converted interger is %d", MyAtoi.myAtoi(str: "3247721"))
    }
}

MyAtoiTest.myAtoi_test()
