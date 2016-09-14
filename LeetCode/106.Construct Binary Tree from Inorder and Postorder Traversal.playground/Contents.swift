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

class BuildTree {
    class func buildTree(inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        if inorder.count == 0 || postorder.count == 0 {
            return nil
        }
        
        let tree = TreeNode.init(postorder.last!)
        
        if inorder.count == 1 && postorder.count == 1 {
            return tree
        } else {
            let index = inorder.index(of: postorder.last!)!
            
             tree.left = buildTree(inorder: Array(inorder[0 ..< index]), Array(postorder[0 ..< index]))
            
             tree.right = buildTree(inorder: Array(inorder[index + 1 ..< inorder.count]), Array(postorder[index ..< postorder.count - 1]))
            
            return tree
        }
    }
}

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Test <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< //

class BuildTreeTest {
    class func buildTree_test() {
        BuildTree.buildTree(inorder: [4, 2, 5, 1, 6, 3, 7], [4, 5, 2, 6, 7, 3, 1])
    }
}

BuildTreeTest.buildTree_test()

