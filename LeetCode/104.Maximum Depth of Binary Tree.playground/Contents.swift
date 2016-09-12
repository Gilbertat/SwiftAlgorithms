//: Playground - noun: a place where people can play

/*
 Given a binary tree, find its maximum depth.
 
 The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.
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

// >>>>>>>>>>>>>>>>>>>>>>>> Test <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class MaxDepthTest {
    class func maxDepth_test() {
        let treeNode : TreeNode = TreeNode.init(10)
        treeNode.left = TreeNode.init(2)
        
        NSLog("The tree's depth is %d", MaxDepth.maxDepth(root: treeNode))
    }
}

MaxDepthTest.maxDepth_test()


