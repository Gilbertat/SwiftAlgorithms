//: Playground - noun: a place where people can play

/*
 Implement regular expression matching with support for '.' and '*'.
 
 '.' Matches any single character.
 '*' Matches zero or more of the preceding element.
 
 The matching should cover the entire input string (not partial).
 
 The function prototype should be:
 bool isMatch(const char *s, const char *p)
 
 Some examples:
 isMatch("aa","a") → false
 isMatch("aa","aa") → true
 isMatch("aaa","aa") → false
 isMatch("aa", "a*") → true
 isMatch("aa", ".*") → true
 isMatch("ab", ".*") → true
 isMatch("aab", "c*a*b") → true
 */

import UIKit

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Extension <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

private extension String {
    subscript (index: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: index)]
    }
    
    subscript (range: Range<Int>) -> String {
        return self[self.characters.index(self.startIndex, offsetBy: range.lowerBound) ..< self.characters.index(self.startIndex, offsetBy: range.upperBound)]
    }
}

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Regular Expression Matching <<<<<<<<<<<<<<<<<<<<<<<<<< //

class IsMatch {
    // recursive (递归)
    class func isMatch_re(s: String, _ p: String) -> Bool {
        if p.isEmpty {
            return s.isEmpty
        }
        
        if p.characters.count > 1 && p[1] == "*" {
            return isMatch_re(s: s, p[2 ..< p.characters.count]) || !s.isEmpty && (s[0] == p[0] || p[0] == ".") && isMatch_re(s: s[1 ..< s.characters.count], p)
        } else {
            return !s.isEmpty && (s[0] == p[0] || p[0] == ".") && isMatch_re(s: s[1 ..< s.characters.count], p[1 ..< p.characters.count])
        }
    }
}

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Test <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class IsMatchTest {
    class func isMatch_re_test() {
        NSLog("isMatch(%@, %@) → %@", "aa", "a", IsMatch.isMatch_re(s: ".", ".**"))
    }
}

IsMatchTest.isMatch_re_test()
