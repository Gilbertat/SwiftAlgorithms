//: Playground - noun: a place where people can play

/*
 Given a binary tree, find its minimum depth.
 The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node.
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

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Minimum Depth of Binary Tree <<<<<<<<<<<<<<<<<<<<<<<<< //

class MinDepth {
    class func minDepth(root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        var resultInt = 0
        
        if root?.left != nil || root?.right != nil {
            resultInt += min(minDepth(root: root?.left), minDepth(root: root?.right))
        } else {
            resultInt = 1
        }
        
        return resultInt
    }
}

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Test <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class MinDepthTest {
    class func minDepth_test() {
        let treeNode : TreeNode = TreeNode.init(10)
        treeNode.left = TreeNode.init(2)
        
        NSLog("The tree's depth is %d", MinDepth.minDepth(root: treeNode))
    }
}

MinDepthTest.minDepth_test()

