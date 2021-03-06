---
title: '63. 不同路径 II'
date: 2020-03-17 15:27:25
tags: [leetcode,dynamic-programming,algorithm]
published: true
hideInList: false
feature: https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/10/22/robot_maze.png
isTop: false
---
一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为“Start” ）。

机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为“Finish”）。

现在考虑网格中有障碍物。那么从左上角到右下角将会有多少条不同的路径？
![](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/10/22/robot_maze.png)
网格中的障碍物和空位置分别用 1 和 0 来表示。

说明：m 和 n 的值均不超过 100。

## 示例 1:
```
输入:
[
  [0,0,0],
  [0,1,0],
  [0,0,0]
]
输出: 2
解释:
3x3 网格的正中间有一个障碍物。
从左上角到右下角一共有 2 条不同的路径：
1. 向右 -> 向右 -> 向下 -> 向下
2. 向下 -> 向下 -> 向右 -> 向右
```
来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/unique-paths-ii

## Solution
与上一题差不多，不同的是增加了障碍物，只需要将障碍物处设置为 0 即可；
递推式为:
$$F(m,n)=\begin{cases}
0,\quad obstacleGrid[m][n] = 1\\
F(m,n-1),\quad m=1  ~and~ obstacleGrid[m][n] = 0\\
F(m-1,n),\quad n=1  ~and~ obstacleGrid[m][n] = 0\\
F(m-1,n) + F(m,n-1), \quad m>1 ~and~  n > 1
\end{cases}$$
## Code

```c++
class Solution {
public:
    int uniquePathsWithObstacles(vector<vector<int>>& obstacleGrid) {
        int m = obstacleGrid.size(),n = obstacleGrid[0].size();
        long maps[m][n];
        fill(maps[0],maps[0]+m*n,0);
        for(int i=0;i<m;i++){
            for(int j=0;j<n;j++){
                if(obstacleGrid[i][j]==1) maps[i][j] = 0;
                else{
                    if(i == 0 && j ==0) maps[i][j] = 1;
                    else if(i==0) maps[i][j] = maps[i][j-1];
                    else if(j==0) maps[i][j] = maps[i-1][j];
                    else maps[i][j] = maps[i-1][j] + maps[i][j-1];
                }
            }
        }
        return maps[m-1][n-1];
    }
};
```
