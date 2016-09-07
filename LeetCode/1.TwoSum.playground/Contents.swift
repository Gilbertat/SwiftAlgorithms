//: Playground - noun: a place where people can play

import UIKit
import XCTest

/*
 Given an array of integers, return indices of the two numbers such that they add up to a specific target.
 
 You may assume that each input would have exactly one solution.
 
 Example:
 Given nums = [2, 7, 11, 15], target = 9,
 
 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].
 */

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Two Sum <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class TwoSum {
    class func twoSum_0(nums: [Int], _ target: Int) -> [Int] {
        for num_left in nums {
            for num_right in nums {
                if num_left + num_right == target {
                    return [min(nums.index(of: num_left)!, nums.index(of: num_right)!),max(nums.index(of: num_left)!, nums.index(of: num_right)!)]
                }
            }
        }
        NSLog("Can't Find any matched array ! ")
        return []
    }
    
    class func twoSum_1(nums: [Int], _ target: Int) -> [Int] {
        for (i, num_left) in nums.enumerated() {
            for j in i + 1 ..< nums.count {
                let num_right = nums[j]
                if num_left + num_right == target {
                    return [min(nums.index(of: num_left)!, nums.index(of: num_right)!),max(nums.index(of: num_left)!, nums.index(of: num_right)!)]
                }
            }
        }
        NSLog("Can't Find any matched array ! ")
        return []
    }
    
    class func twoSum_2(nums: [Int], _ target: Int) -> [Int] {
        var dic = [Int: Int]()
        
        for num in nums {
            if (dic[target - num] != nil) {
                return [min(dic[target - num]!, nums.index(of: num)!),max(dic[target - num]!, nums.index(of: num)!)]
            }else {
                dic[num] = nums.index(of: num)!
            }
        }
        NSLog("Can't Find any matched array ! ")
        return []
    }
}

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Test <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class TwoSumTest {
    let case0 = [1, 3, 5, 9] //8 > [1, 2]
    let case1 = [1, 22, 333, 4444, 55555] //4466 > [1, 3]
    let case2 = [1, 33, 555, 7777, 99999, 111111] //111112 > [0, 5]
    let case3 = [1, 222, 3333, 44444, 55555, 666666, 7777777, 88888888, 999999999] //223 > [0, 1]
    
    func twoSum_0_test() {
        let result0 = TwoSum.twoSum_0(nums: self.case0, 8)
        let result1 = TwoSum.twoSum_0(nums: self.case1, 4466)
        let result2 = TwoSum.twoSum_0(nums: self.case2, 111112)
        let result3 = TwoSum.twoSum_0(nums: self.case3, 223)
        
        print(result0)
        print(result1)
        print(result2)
        print(result3)
    }
    
    func twoSum_1_test() {
        let result0 = TwoSum.twoSum_1(nums: self.case0, 8)
        let result1 = TwoSum.twoSum_1(nums: self.case1, 4466)
        let result2 = TwoSum.twoSum_1(nums: self.case2, 111112)
        let result3 = TwoSum.twoSum_1(nums: self.case3, 223)
        
        print(result0)
        print(result1)
        print(result2)
        print(result3)
    }
    
    func twoSum_2_test() {
        let result0 = TwoSum.twoSum_2(nums: self.case0, 8)
        let result1 = TwoSum.twoSum_2(nums: self.case1, 4466)
        let result2 = TwoSum.twoSum_2(nums: self.case2, 111112)
        let result3 = TwoSum.twoSum_2(nums: self.case3, 223)
        
        print(result0)
        print(result1)
        print(result2)
        print(result3)
    }
}

let twoSumTest = TwoSumTest()

twoSumTest.twoSum_2_test()
