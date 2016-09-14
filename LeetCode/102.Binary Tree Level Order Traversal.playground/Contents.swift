//: Playground - noun: a place where people can play

/*
 Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).
 
 For example:
 Given binary tree [3,9,20,null,null,15,7],
 3
 / \
 9  20
 /  \
 15   7
 return its level order traversal as:
 [
 [3],
 [9,20],
 [15,7]
 ]
 */

import UIKit

// >>>>>>>>>>>>>>>>>>>>>>>> TreeNode <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// >>>>>>>>>>>>>>>>>>>>>>>> Maximum Depth of Binary Tree <<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class MaxDepth {
    class func maxDepth(root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        var resultInt = 0
        
        if root?.left != nil || root?.right != nil {
            resultInt += max(maxDepth(root: root?.left), maxDepth(root: root?.right))
        } else {
            resultInt = 1
        }
        
        return resultInt
    }
}

// >>>>>>>>>>>>>>> Binary Tree Level Order Traversal <<<<<<<<<<<<<<<<<<<<<<<<<< //

class LevelOrder {
    class func levelOrder(root: TreeNode?) -> [[Int]] {
        var resultArr = Array<Array<Int>>()

        func levelOrder(root: TreeNode?, index: Int) {
            if root?.val != nil {
                
                if resultArr.count <= index {
                    resultArr.append(Array.init())
                }
                
                resultArr[index].append((root?.val)!)
                
                levelOrder(root: root?.left, index: index + 1)
                levelOrder(root: root?.right, index: index + 1)
            }
        }
        levelOrder(root: root, index: 0)
      
        return resultArr
    }
}

// >>>>>>>>>>>>>>> Test <<<<<<<<<<<<<<<<<<<<<<<<<< //

class LevelOrderTest {
    class func levelOrder_test () {
        let tree = TreeNode.init(12)
        
        tree.left = TreeNode.init(123)
        
        tree.right = TreeNode.init(32148372648)
        
        tree.right?.right = TreeNode.init(1)
        
        tree.left?.left = TreeNode.init(3421343)
        
        LevelOrder.levelOrder(root: tree)
    }
}

LevelOrderTest.levelOrder_test()