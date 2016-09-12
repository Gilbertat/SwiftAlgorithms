//: Playground - noun: a place where people can play

/*
 Given inorder and postorder traversal of a tree, construct the binary tree.
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

// >> Construct Binary Tree from Inorder and Postorder Traversal  QuestionEditorial Solution < //

class Solution {
    func buildTree(inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        if inorder.count == 0 || postorder.count == 0 {
            return nil
        }
        
        
    }
}