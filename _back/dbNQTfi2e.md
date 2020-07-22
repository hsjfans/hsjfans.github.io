---
title: '64. 最小路径和'
date: 2020-03-17 15:40:58
tags: [leetcode,dynamic-programming,algorithm]
published: true
hideInList: false
feature: 
isTop: false
---
给定一个包含非负整数的 m x n 网格，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。

说明：每次只能向下或者向右移动一步。

## 示例:
```
输入:
[
  [1,3,1],
  [1,5,1],
  [4,2,1]
]
输出: 7
解释: 因为路径 1→3→1→1→1 的总和最小。
```

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/minimum-path-sum


## Solution

动态规划，递归式也很简单

$$grid(m,n)=\begin{cases}
grid(m,n) ,\quad m=0 ~and~ n =0  \\
grid(m,n) + grid(m,n-1),\quad m=0  \\
grid(m,n) + grid(m-1,n),\quad n=0  \\
grid(m,n) + min(grid(m-1,n),grid(m,n-1)), \quad m>0 ~and~  n > 0
\end{cases}$$


## Code

```c++
class Solution {
public:
    int minPathSum(vector<vector<int>>& grid) {
        int m = grid.size(),n = grid[0].size();
        for(int i=0;i<m;i++){
            for(int j=0;j<n;j++){
                if(i==0 && j==0) continue;
                else if(i==0) grid[i][j] += grid[i][j-1];
                else if(j==0) grid[i][j] += grid[i-1][j];
                else grid[i][j] = grid[i][j] + min(grid[i-1][j],grid[i][j-1]); 
            }
        }
        return grid[m-1][n-1];
    }
};
```