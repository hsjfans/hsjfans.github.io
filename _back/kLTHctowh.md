---
title: '1099 Build A Binary Search Tree (30分)'
date: 2020-03-12 10:16:21
tags: [tree,pat,algorithm]
published: true
hideInList: false
feature: https://img.500px.me/photo/711129d6f418b959018c4c7bfb8462968/1ac4cfa0024a487581be1981fbf08c5b.jpg!p5
isTop: false
---
A Binary Search Tree (BST) is recursively defined as a binary tree which has the following properties:

The left subtree of a node contains only nodes with keys less than the node’s key.
The right subtree of a node contains only nodes with keys greater than or equal to the node’s key.
Both the left and right subtrees must also be binary search trees.
Given the structure of a binary tree and a sequence of distinct integer keys, there is only one way to fill these keys into the tree so that the resulting tree satisfies the definition of a BST. You are supposed to output the level order traversal sequence of that tree. The sample is illustrated by Figure 1 and 2.
![](https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200312101859.png)

##  Input Specification:

Each input file contains one test case. For each case, the first line gives a positive integer N (<=100) which is the total number of nodes in the tree. The next N lines each contains the left and the right children of a node in the format “left_index right_index”, provided that the nodes are numbered from 0 to N-1, and 0 is always the root. If one child is missing, then -1 will represent the NULL child pointer. Finally N distinct integer keys are given in the last line.

## Output Specification:

For each test case, print in one line the level order traversal sequence of that tree. All the numbers must be separated by a space, with no extra space at the end of the line.

## Sample 
### Input:
```
9
1 6
2 3
-1 -1
-1 4
5 -1
-1 -1
7 -1
-1 8
-1 -1
73 45 11 58 82 25 67 38 42
```
### Output:
58 25 82 11 38 67 45 73 42


## Solution

BST树，有一个特点：它的中序序列是一个有序序列，这道题的关键就是抓住这个特点。
步骤也很清晰

1. 构建树 (看清题干，可以选择一个结构体数组来存储树的各个节点)
2. 数据排序，从小到大排序
3. 构建树的中序序列（可以选择递归或者采用非递归遍历），这一步主要是找到树的节点与数据的对应关系
4. 树的层序遍历，遍历的同时打印节点值即可

## Code

```c++
#include<iostream>
#include<queue>
#include<algorithm>
#include<vector>
using namespace std;


struct TreeNode
{
    int parent, left, right;
};

TreeNode nodes[100];
vector<int> orders;

void inorders(int parent)
{
    if (parent != -1)
    {
        TreeNode node = nodes[parent];
        inorders(node.left);
        orders.push_back(node.parent);
        inorders(node.right);
    }
}

void pat_1099()
{
    int n, parent = 0, i, j;
    cin >> n;
    // 构建树
    for(i=0;i<n;i++){
        cin >> nodes[i].left >> nodes[i].right;
        nodes[i].parent = i;
    }
    // 中序序列
    inorders(parent);
    int nums[n], maps[n];
    // 建立起 中序序列与其索引之间的关系
    for (i = 0; i < orders.size(); i++)
        maps[orders[i]] = i;
    for (i = 0; i < n; i++)
        scanf("%d", &nums[i]);
    // 中序序列为有序序列
    sort(nums, nums + n);
    queue<TreeNode> q;
    q.push(nodes[0]);
    int size = 1;
    // 层序遍历，打印结果
    while (!q.empty())
    {
        size = q.size();
        for (j = 0; j < size; j++)
        {
            TreeNode node = q.front();
            q.pop();
            if (node.parent != 0)
                cout << " ";
            cout << nums[maps[node.parent]];
            if (node.left != -1)
                q.push(nodes[node.left]);
            if (node.right != -1)
                q.push(nodes[node.right]);
        }
    }
}

int main()
{
    pat_1099();
    return 0;
}


```