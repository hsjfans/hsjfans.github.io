---
title: '1162. 地图分析'
date: 2020-03-29 10:18:44
tags: [bfs,graph,一刷leetcode,leetcode]
published: true
hideInList: false
feature: https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200329101903.png
isTop: false
---
你现在手里有一份大小为 N x N 的『地图』（网格） grid，上面的每个『区域』（单元格）都用 0 和 1 标记好了。其中 0 代表海洋，1 代表陆地，你知道距离陆地区域最远的海洋区域是是哪一个吗？请返回该海洋区域到离它最近的陆地区域的距离。

我们这里说的距离是『曼哈顿距离』（ Manhattan Distance）：(x0, y0) 和 (x1, y1) 这两个区域之间的距离是 |x0 - x1| + |y0 - y1| 。

如果我们的地图上只有陆地或者海洋，请返回 -1。

### 示例 1：
![](https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200329101903.png)
```
输入：[[1,0,1],[0,0,0],[1,0,1]]
输出：2
解释： 
海洋区域 (1, 1) 和所有陆地区域之间的距离都达到最大，最大距离为 2。
```
### 示例 2：
![](https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200329101915.png)

```
输入：[[1,0,0],[0,0,0],[0,0,0]]
输出：4
解释： 
海洋区域 (2, 2) 和所有陆地区域之间的距离都达到最大，最大距离为 4。
```

### 提示：

1. 1 <= grid.length == grid[0].length <= 100
2. grid[i][j] 不是 0 就是 1

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/as-far-from-land-as-possible
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

## Solution

多源 BFS ,从陆地出发，进行 bfs 遍历，记录其层数即可



## Code

```c++
class Solution {
public:
    int maxDistance(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        queue<vector<int>> q;
        int visited[100][100]  = {0};
        int num = 0;
        // 找到所有的 陆地
        for(int i=0;i<m;i++){
            for(int j=0;j<n;j++){
               if(grid[i][j]){num++;q.push({i,j});visited[i][j] = 1;}
            }
        }
        if(num ==0 || num == m*n) return -1;
        vector<int> dot;
        int x,y, dx[4] = {1,-1,0,0},dy[4] = {0,0,1,-1};
        int res = -1,size,i,j;
        while(!q.empty()){
            size = q.size();
            for(i=0;i<size;i++){
                dot = q.front();
                q.pop();
                for(j=0;j<4;j++){
                x = dx[j] + dot[0];
                y = dy[j] + dot[1];
                // 找到尚未访问过的海洋节点
                if(x >=0 && x< m && y>=0 && y< n && !visited[x][y]){
                    q.push({x,y});
                    visited[x][y] = 1;
                }
              }
            }
            // 距离 + 1
            res ++;
        }
        return res;

    }
};
```

