---
layout: post
title: '1115 Counting Nodes in a BST (30分)'
date: 2020-03-12 12:08:11
tags: [pat,algorithm,tree]
published: true
hideInList: false
feature: https://img.500px.me/photo/711129d6f418b959018c4c7bfb8462968/0beba5ad01634302b8b9001069fc2abd.jpg!p5
isTop: false
---
A Binary Search Tree (BST) is recursively defined as a binary tree which has the following properties:

- The left subtree of a node contains only nodes with keys less than or equal to the node's key.
- The right subtree of a node contains only nodes with keys greater than the node's key.
- Both the left and right subtrees must also be binary search trees.
  
Insert a sequence of numbers into an initially empty binary search tree. Then you are supposed to count the total number of nodes in the lowest 2 levels of the resulting tree.

## Input Specification:
Each input file contains one test case. For each case, the first line gives a positive integer N (≤1000) which is the size of the input sequence. Then given in the next line are the N integers in [−1000,1000] which are supposed to be inserted into an initially empty binary search tree.

## Output Specification:
For each case, print in one line the numbers of nodes in the lowest 2 levels of the resulting tree in the format:
```
n1 + n2 = n
```
      
    
where n1 is the number of nodes in the lowest level, n2 is that of the level above, and n is the sum.

## Sample 
### Input:
```
9
25 30 42 16 20 20 35 -5 28
```
      
    
### Output:
```
2 + 4 = 6
```

## Solution

先建立BST, 建树的同时可以记录节点的层数即最大层数，最后遍历一遍即可

注意：看清题干，本题 ```The left subtree of a node contains only nodes with keys less than or equal to the node's key.``` ， 找了半个小时，才发现

代码就很简单了

## Code

```c++
#include<iostream>

using namespace std;

struct BinaryNode
{
    int left, right, data, level;
};

void pat_1115()
{
    int n,val,i;
    cin >> n;
    BinaryNode nodes[n];
    for (i = 0; i < n; i++)
    {
        cin >> val;
        nodes[i] = {-1,-1,val,0};
    }
    int root = 0, cur, maxLevel = 0;
    for (i = 1; i < n; i++)
    {
        root = 0;
        while (root != -1)
        {
            if (nodes[root].data >= nodes[i].data)
            {
                cur = nodes[root].left;
                if (cur == -1)
                {
                    nodes[root].left = i;
                    nodes[i].level = nodes[root].level + 1;
                }
            }
            else
            {
                cur = nodes[root].right;
                if (cur == -1)
                {
                    nodes[root].right = i;
                    nodes[i].level = nodes[root].level + 1;
                }
            }
            maxLevel = max(maxLevel, nodes[i].level);
            root = cur;
        }
    }

    int prelevel = 0, curlevel = 0;
    for (i = 0; i < n; i++)
    {
        if (nodes[i].level == maxLevel)
            curlevel++;
        else if (nodes[i].level == maxLevel - 1)
            prelevel++;
    }
    printf("%d + %d = %d\n", curlevel, prelevel, curlevel + prelevel);
}

int main()
{
    pat_1115();
    return 0;
}

```
