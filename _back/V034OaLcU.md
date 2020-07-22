---
title: '1123 Is It a Complete AVL Tree (30分)'
date: 2020-03-12 21:39:22
tags: [tree,pat,algorithm]
published: true
hideInList: false
feature: https://img.500px.me/8afd2c4a37964b16a25bf17a87be975a.jpg!p5
isTop: false
---
An AVL tree is a self-balancing binary search tree. In an AVL tree, the heights of the two child subtrees of any node differ by at most one; if at any time they differ by more than one, rebalancing is done to restore this property. Figures 1-4 illustrate the rotation rules.

![](https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200312214902.png)

Now given a sequence of insertions, you are supposed to output the level-order traversal sequence of the resulting AVL tree, and to tell if it is a complete binary tree.

## Input Specification:
Each input file contains one test case. For each case, the first line contains a positive integer N (≤ 20). Then N distinct integer keys are given in the next line. All the numbers in a line are separated by a space.

## Output Specification:
For each test case, insert the keys one by one into an initially empty AVL tree. Then first print in a line the level-order traversal sequence of the resulting AVL tree. All the numbers in a line must be separated by a space, and there must be no extra space at the end of the line. Then in the next line, print YES if the tree is complete, or NO if not.

## Sample 
### Input 1:
```
5
88 70 61 63 65
```
      
    
### Output 1:
```
70 63 88 61 65
YES
```
    
##Sample
### Input 2:
```
8
88 70 61 96 120 90 65 68
```
      
    
### Output 2:
```
88 65 96 61 70 90 120 68
NO
```

## Solution
主要分两步:
1. 建立avl树 (过程参见 [AvlTree](/post/GIR7K7_Hd/))
2. 进行层序遍历，遍历过程中判断是否为完全二叉树
3. 完全二叉树的定义为 最多有一个只有一个叶子的节点
## Code

```c++
#include <iostream>
#include<cmath>
#include <queue>
using namespace std;
 

struct avl_node
{
    struct avl_node *left, *right;
    int data, height;
};
typedef struct avl_node *AvlTree, *AvlNode;

int height(AvlNode k)
{
    return k ? k->height : -1;
}

// lr 旋转
AvlNode left_right_rotate(AvlNode k2)
{
    AvlNode k1 = k2->left;
    k2->left = k1->right;
    k1->right = k2;

    k2->height = max(height(k2->left), height(k2->right)) + 1;
    k1->height = max(height(k1->left), height(k1->right)) + 1;
    return k1;
}

// rl 旋转
AvlNode right_left_rotate(AvlNode k1)
{
    AvlNode k2 = k1->right;
    k1->right = k2->left;
    k2->left = k1;

    k1->height = max(height(k1->left), height(k1->right)) + 1;
    k2->height = max(height(k2->left), height(k2->right)) + 1;
    return k2;
}

// ll 旋转
AvlNode left_left_rotate(AvlNode k3)
{
    k3->left = right_left_rotate(k3->left);
    return left_right_rotate(k3);
}

// rr 旋转
AvlNode right_right_rotate(AvlNode k1)
{
    k1->right = left_right_rotate(k1->right);
    return right_left_rotate(k1);
}

AvlNode insert(AvlNode t, int val)
{
    if (!t)
    {
        t = new avl_node();
        t->data = val;
        t->height = 0;
        t->left = t->right = nullptr;
        return t;
    }
    // self-check
    if (t->data > val)
    {
        t->left = insert(t->left, val);
        if (height(t->left) - height(t->right) == 2)
        {
            // lr 旋转
            if (t->left->data > val)
                t = left_right_rotate(t);
            else
                t = left_left_rotate(t);
        }
    }
    else
    {
        t->right = insert(t->right, val);
        if (height(t->right) - height(t->left) == 2)
        {
            // rl 旋转
            if (t->right->data < val)
                t = right_left_rotate(t);
            else
                t = right_right_rotate(t);
        }
    }
    t->height = max(height(t->left), height(t->right)) + 1;
    return t;
}

bool level_loop(AvlNode tree)
{
    queue<AvlNode> q;
    q.push(tree);
    int flag = 1;
    bool complete = true, leaf = false, falg = true;
    while (!q.empty())
    {
        AvlNode node = q.front();
        q.pop();
        if (!flag)
            cout << " ";
        else
            flag = false;
        cout << node->data;
        if (node->left)
            q.push(node->left);
        if (node->right)
            q.push(node->right);
        if (!node->left && node->right)
            complete = false;
        if (leaf && (node->left || node->right))
            complete = false;
        if (!node->left || !node->right)
            leaf = true;
    }
    cout << endl;
    return complete;
}

void pat_1123()
{

    int n, i, val;
    cin >> n;
    AvlTree root = nullptr;
    for (i = 0; i < n; i++)
    {
        cin >> val;
        root = insert(root, val);
    }
    bool complete = level_loop(root);
    if (complete)
        cout << "YES";
    else
        cout << "NO";
}

int main()
{
    pat_1123();
    return 0;
}

```