---
title: '99. 恢复二叉搜索树'
date: 2020-03-24 11:42:09
tags: [leetcode,tree,algorithm]
published: true
hideInList: false
feature: 
isTop: false
---
二叉搜索树中的两个节点被错误地交换。

请在不改变其结构的情况下，恢复这棵树。

## 示例 1:
```
输入: [1,3,null,null,2]

   1
  /
 3
  \
   2

输出: [3,1,null,null,2]

   3
  /
 1
  \
   2
```
## 示例 2:
```
输入: [3,1,4,null,null,2]

  3
 / \
1   4
   /
  2

输出: [2,1,4,null,null,3]

  2
 / \
1   4
   /
  3
```
 ## 进阶:

使用 O(n) 空间复杂度的解法很容易实现。
你能想出一个只使用常数空间的解决方案吗？

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/recover-binary-search-tree
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

## O(n) 算法
### Solution
获取中序遍历序列，然后再排序，再遍历一次重新写入到原二叉树中
### Code
```c++
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
   
    void loop(TreeNode *root,vector<int> &nums){
        if(root){
            loop(root->left,nums);
            nums.push_back(root->val);
            loop(root->right,nums);
        }
    }
    
    void recover(TreeNode *root,vector<int> &nums){
        stack<TreeNode*> s;
        int idx = 0;
        while(root ||!s.empty()){
            while(root){
                s.push(root);
                root = root->left;
            }
            root = s.top();
            s.pop();
            root->val = nums[idx++];
            root = root->right;
        }
    }

    void recoverTree(TreeNode* root) {
        vector<int> nums;
        TreeNode *p = root,*head = root;
        loop(p,nums);
        sort(nums.begin(),nums.end());
        recover(head,nums);
    }
};
```


## O(1) 算法

## Solution
遍历的同时，找到这两个问题节点，将其值交换即可
## Code
```c++
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
   
    void recoverTree(TreeNode* root) {
        TreeNode *p = root;
        stack<TreeNode*> s;
        TreeNode *first = NULL, *prev = NULL, *second = NULL;
        bool invalid = false;
        while(p ||!s.empty()){
            while(p){
                s.push(p);
                p = p->left;
            }
            p = s.top();
            s.pop();
            if(prev && (prev->val > p->val)){
                if(first == NULL) first = prev;
                second = p;
            }
            prev = p;
            p = p->right;
        }
        
        int tmp = second->val;
        second->val = first->val;
        first->val = tmp;
    }

};
```