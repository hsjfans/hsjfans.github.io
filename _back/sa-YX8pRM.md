---
title: '62. 不同路径'
date: 2020-03-17 14:39:45
tags: [leetcode,dynamic-programming,algorithm]
published: true
hideInList: false
feature: https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/10/22/robot_maze.png
isTop: false
---
一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为“Start” ）。

机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为“Finish”）。

问总共有多少条不同的路径？

![](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/10/22/robot_maze.png)

例如，上图是一个7 x 3 的网格。有多少可能的路径？

 

## 示例 1:
```
输入: m = 3, n = 2
输出: 3
解释:
从左上角开始，总共有 3 条路径可以到达右下角。
1. 向右 -> 向右 -> 向下
2. 向右 -> 向下 -> 向右
3. 向下 -> 向右 -> 向右
```
## 示例 2:
```
输入: m = 7, n = 3
输出: 28
```
来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/unique-paths


## Solution

动态规划问，递推公式为

$$F(m,n)=\begin{cases}
1,\quad m=1  ~or~  n=1\\
F(m-1,n) + F(m,n-1), \quad m>1 ~and~  n > 1
\end{cases}$$

## Code

```c++
class Solution {
public:
  
    
    int uniquePaths(int m, int n) {
        int maps[m+1][n+1];
        fill(maps[0],maps[0]+(m+1)*(n+1),0);
        for(int i=1;i<=m;i++){
            for(int j=1;j<=n;j++){
                if(i==1 || j==1) maps[i][j] = 1;
                else{
                    maps[i][j] = maps[i-1][j] + maps[i][j-1];
               }
            }
        }
        return maps[m][n];
    }
};

```