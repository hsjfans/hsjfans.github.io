---
title: '面试题 04.01. 节点间通路'
date: 2020-04-04 15:09:44
tags: []
published: true
hideInList: false
feature: 
isTop: false
---
节点间通路。给定有向图，设计一个算法，找出两个节点之间是否存在一条路径。

## 示例1:
```
 输入：n = 3, graph = [[0, 1], [0, 2], [1, 2], [1, 2]], start = 0, target = 2
 输出：true
```
示例2:
```
 输入：n = 5, graph = [[0, 1], [0, 2], [0, 4], [0, 4], [0, 1], [1, 3], [1, 4], [1, 3], [2, 3], [3, 4]], start = 0, target = 4
 输出 true
```
提示：

1. 节点数量n在[0, 1e5]范围内。
2. 节点编号大于等于 0 小于 n。
3. 图中可能存在自环和平行边。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/route-between-nodes-lcci
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

## Solution

1. DFS
2. BFS


## Code
1. DFS
```c++

class Solution {
public:
    bool findWhetherExistsPath(int n, vector<vector<int>>& graph, int start, int target) {
        vector<int> visited(n,0);
        vector<int> v[n];
        for(int i=0;i<graph.size();i++){
            v[graph[i][0]].push_back(graph[i][1]);
        }
        stack<int> s;
        s.push(start);
        visited[start] = 1;
        int k, flag;
        while(!s.empty()){
            k = s.top(); flag = 0;
            if(k == target) return true;
            for(int j=0;j<v[k].size();j++){
                if(visited[v[k][j]] == 0){
                    s.push(v[k][j]);
                    flag = 1;
                    visited[v[k][j]] = 1;
                    break;
                }
            }
            if(!flag) s.pop();
        }
        return false;

    }
};

```


2. BFS
```c++
class Solution {
public:
    bool findWhetherExistsPath(int n, vector<vector<int>>& graph, int start, int target) {
        vector<int> visited(n,0);
        vector<int> v[n];
        for(int i=0;i<graph.size();i++){
            v[graph[i][0]].push_back(graph[i][1]);
        }
        queue<int> q;
        q.push(start);
        visited[start] = 1;
        int k;
        while(!q.empty()){
            k = q.front();
            if(k == target) return true;
            q.pop();
            for(auto t : v[k]){
                if(visited[t]==0){
                    visited[t] = 1;
                    q.push(t);
                }
            }
        }
        return false;

    }
};

```