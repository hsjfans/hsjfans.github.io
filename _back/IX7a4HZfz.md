---
title: '952. 按公因数计算最大组件大小'
date: 2020-05-05 15:02:46
tags: [一刷leetcode,algorithm,并查集]
published: false
hideInList: false
feature: https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/12/01/ex3.png
isTop: false
---
给定一个由不同正整数的组成的非空数组 A，考虑下面的图：

有 A.length 个节点，按从 A[0] 到 A[A.length - 1] 标记；
只有当 A[i] 和 A[j] 共用一个大于 1 的公因数时，A[i] 和 A[j] 之间才有一条边。
返回图中最大连通组件的大小。

 
![](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/12/01/ex3.png)
## 示例 1：
```
输入：[4,6,15,35]
输出：4
```
## 示例 2：
```
输入：[20,50,9,63]
输出：2
```
## 示例 3：
```
输入：[2,3,6,7,4,12,21,39]
输出：8
```
 

## 提示：

1. 1 <= A.length <= 20000
2. 1 <= A[i] <= 100000


## Solution

1.  DFS/BFS ( 超时)
  ```c++
  class Solution {
public:
    
    int gcd(int a,int b){
        if(b != 0) return gcd(b,a%b);
        else return a;
    }
    
    
    
    void dfs(map<int,vector<int>>& v,int start,map<int,int>& visited){
        visited[start] = 1;
        for(int i=0;i<v[start].size();i++){
            if(!visited[v[start][i]]) dfs(v,v[start][i],visited);
        }
    }
    
    int largestComponentSize(vector<int>& A) {
        
        int n = A.size();
        map<int,vector<int>> v;
        for(int i=0;i<n;i++){
            for(int j=i+1;j<n;j++){
                if(gcd(A[i],A[j]) > 1){
                    // 采用邻接表存储
                    v[i].push_back(j);
                    v[j].push_back(i);
                }
            }
        }
        
        // 找连通图的大小, 可以是 dfs 或者 bfs，这里使用 bfs
        // 是否访问过,
        int cur = 0,ans = 0;
        map<int,int> visited;
        
        for(int i=0;i<n;i++){
            // 剪枝
            if(n - i < ans) break;
            if(!visited[i]) {
                dfs(v,i,visited);
                ans = max(ans,(int)(visited.size()) - cur);
                cur = visited.size();
            }
        }
        return ans;
    }
};
  ```
2.  并查集

