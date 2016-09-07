//: Playground - noun: a place where people can play

import UIKit

/*
You are given two linked lists representing two non-negative numbers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 0 -> 8
*/
 
// >>>>>>>>>>>>>>>>>>>>> Definition for singly-linked list. <<<<<<<<<<<<<<<<<<<<<<<<< //

public class ListNode {
    public var val: Int
    public var next: ListNode?
    
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> AddTwoNumbers <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class AddTwoNumbers {
    class func addTwoNumbers_0 (l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {
            return l2
        }else if l2 == nil {
            return l1
        }
        
        var resultListNode : ListNode?
        var tempResultNode : ListNode?
        var carry : Int = 0
        var l1Copy = l1
        var l2Copy = l2
        
        while (l1Copy?.next != nil && l2Copy?.next != nil) {
            if tempResultNode == nil {
                resultListNode = ListNode.init(((l1Copy?.val)! + (l2Copy?.val)!) % 10)
                
                tempResultNode = resultListNode
            }else {
                tempResultNode = pushListNodeInto(resultListNode: tempResultNode!, val: ((l1Copy?.val)! + (l2Copy?.val)! + carry) % 10)
            }
            
            carry = ((l1Copy?.val)! + (l2Copy?.val)!) / 10
            l1Copy = l1Copy?.next
            l2Copy = l2Copy?.next
        }
        
        tempResultNode = pushListNodeInto(resultListNode: tempResultNode!, val: ((l1Copy?.val)! + (l2Copy?.val)! + carry) % 10)
        
        l1Copy = l1Copy?.next
        l2Copy = l2Copy?.next

        if (l1Copy != nil) {
            tempResultNode?.next  = l1Copy
        }else {
            tempResultNode?.next  = l2Copy
        }
        
        return resultListNode
    }
    
    class func pushListNodeInto (resultListNode: ListNode, val: Int) -> ListNode {
        let tempListNode = ListNode.init(val)
        
        resultListNode.next = tempListNode
        
        return tempListNode
    }
}

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Test <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class AddTwoNumbersTest {
    class func addTwoNumbersTest_0() {
    
        let listNode_1 = ListNode.init(2)
        let listNode_2 = ListNode.init(4)
        let listNode_3 = ListNode.init(3)
        
        listNode_1.next = listNode_2
        listNode_2.next = listNode_3
        
        NSLog("Input:  %@", listNodePrinter(l: listNode_1))
        
        let listNode_4 = ListNode.init(5)
        let listNode_5 = ListNode.init(6)
        let listNode_6 = ListNode.init(4)
        
        listNode_4.next = listNode_5
        listNode_5.next = listNode_6
        
        NSLog("Input:  %@", listNodePrinter(l: listNode_4))

        let resultListNode = AddTwoNumbers.addTwoNumbers_0(l1: listNode_1, listNode_4)
        
        NSLog("Output: %@", listNodePrinter(l: resultListNode))
    }
    
    class func listNodePrinter(l: ListNode?) -> String {
        var string = String()
        
        var lCopy = l
        
        while (lCopy?.val != nil) {
            
            if string.isEmpty {
                string = String(lCopy?.val)
            }else {
                string = string.appending(" -> " + String(lCopy?.val))
            }
            
            lCopy = lCopy?.next
        }
        
        return string
    }
}

AddTwoNumbersTest.addTwoNumbersTest_0()

