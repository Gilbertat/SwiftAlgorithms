//: Playground - noun: a place where people can play

/*
 Reverse digits of an integer.
 
 Example1: x = 123, return 321
 Example2: x = -123, return -321
 */

import UIKit

// >>>>>>>>>>>>>>>>>>>>>>>>>>>> Reverse Integer <<<<<<<<<<<<<<<<<<<<<<<<<< //
class Reverse {
    class func reverse(x: Int) -> Int {
        var outPutInt = 0
        var inPutInt = x
        
        while inPutInt != 0 {
            outPutInt = outPutInt * 10 + inPutInt % 10
            
            inPutInt = inPutInt / 10
            
            if outPutInt > Int(Int32.max)  || outPutInt < Int(Int32.min) {
                return 0
            }
        }
        
        return outPutInt
    }
}

// >>>>>>>>>>>>>>>>>>>>>>>>>>>> Test <<<<<<<<<<<<<<<<<<<<<<<<<< //
class ReverseTest {
    class func reverse_test() {
        NSLog("The reversed interger is %d", Reverse.reverse(x: 213721))
    }
}

ReverseTest.reverse_test()