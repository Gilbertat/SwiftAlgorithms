
/*
 Given a string, find the length of the longest substring without repeating characters.
 
 Examples:
 
 Given "abcabcbb", the answer is "abc", which the length is 3.
 
 Given "bbbbb", the answer is "b", with the length of 1.
 
 Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
 
 Subscribe to see which companies asked this question
 */

import UIKit

// >>>>>>>>>>>>>> Longest Substring Without Repeating Characters <<<<<<<<<<<<<<<<<<<<<<< //

class LengthOfLongestSubstring {
    class func lengthOfLongestSubstring(s: String) -> (Int) {
        var byteArr = Array<String>()
        
        var resultInt = 0
        
        for byteOfS in s.characters {
            
            let newValue = String(byteOfS)
            
            while byteArr.contains(newValue) {
                resultInt = max(resultInt, byteArr.count)
                
                byteArr.remove(at: 0)
            }
            
            byteArr.append(newValue)
        }
        return resultInt
    }
}

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Test <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class LengthOfLongestSubstringTest {
    class func lengthOfLongestSubstringTest_0() {
        NSLog("The length of the longest substring without repeating characters is %d",LengthOfLongestSubstring.lengthOfLongestSubstring(s: "abcabcbb"))
    }
    
    class func lengthOfLongestSubstringTest_1() {
        NSLog("The length of the longest substring without repeating characters is %d",LengthOfLongestSubstring.lengthOfLongestSubstring(s: "bbbbb"))
    }
    
    class func lengthOfLongestSubstringTest_2() {
        NSLog("The length of the longest substring without repeating characters is %d",LengthOfLongestSubstring.lengthOfLongestSubstring(s: "pwwkew"))
    }
}

LengthOfLongestSubstringTest.lengthOfLongestSubstringTest_1()
