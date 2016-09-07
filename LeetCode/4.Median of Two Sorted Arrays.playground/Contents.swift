//: Playground - noun: a place where people can play

/*
 There are two sorted arrays nums1 and nums2 of size m and n respectively.
 
 Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).
 
 Example 1:
 nums1 = [1, 3]
 nums2 = [2]
 
 The median is 2.0
 Example 2:
 nums1 = [1, 2]
 nums2 = [3, 4]
 
 The median is (2 + 3)/2 = 2.5
 */

import UIKit

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Median of Two Sorted Arrays <<<<<<<<<<<<<<<<<<<<<<<< //

class FindMedianSortedArrays {
    class func findMedianSortedArrays(nums1: [Int], _ nums2: [Int]) -> Double {
        var nums1Copy = nums1
        var nums2Copy = nums2
        var middleLeft = 0
        var middleRight = 0
        var indexLeft = 0
        var indexRight = 0
        
        nums1Copy.append(Int(INT_MAX))
        nums2Copy.append(Int(INT_MAX))
        
        for _ in 0 ... (nums1.count + nums2.count) / 2 {
            middleLeft = middleRight
            
            if nums1Copy[indexLeft] > nums2Copy[indexRight] {
                middleRight = nums2Copy[indexRight]
                
                indexRight += 1
            }else {
                middleRight = nums1Copy[indexLeft]
                
                indexLeft += 1
            }
        }
        
        if (nums1.count + nums2.count) % 2 == 0 {
            return (Double(middleLeft) + Double(middleRight)) / 2
        }else {
            return Double(middleRight)
        }
    }
}

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Test <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class FindMedianSortedArraysTest {
    class func findMedianSortedArraysTest_0() {
        let nums1 = [1, 3]
        let nums2 = [2]
        
        let resultDouble = FindMedianSortedArrays.findMedianSortedArrays(nums1: nums1, nums2)
        
        NSLog("The median is %f", resultDouble)
    }
    
    class func findMedianSortedArraysTest_1() {
        let nums1 = [1, 2]
        let nums2 = [3, 4]
        
        let resultDouble = FindMedianSortedArrays.findMedianSortedArrays(nums1: nums1, nums2)
        
        NSLog("The median is %f", resultDouble)
    }
}

FindMedianSortedArraysTest.findMedianSortedArraysTest_0()
