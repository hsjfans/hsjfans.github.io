---
title: '207. 课程表'
date: 2020-04-04 08:59:11
tags: [一刷leetcode,algorithm,graph]
published: true
hideInList: false
feature: 
isTop: false
---
你这个学期必须选修 numCourse 门课程，记为 0 到 numCourse-1 。

在选修某些课程之前需要一些先修课程。 例如，想要学习课程 0 ，你需要先完成课程 1 ，我们用一个匹配来表示他们：[0,1]

给定课程总量以及它们的先决条件，请你判断是否可能完成所有课程的学习？

 

## 示例 1:
```
输入: 2, [[1,0]] 
输出: true
解释: 总共有 2 门课程。学习课程 1 之前，你需要完成课程 0。所以这是可能的。
```
## 示例 2:
```
输入: 2, [[1,0],[0,1]]
输出: false
解释: 总共有 2 门课程。学习课程 1 之前，你需要先完成​课程 0；并且学习课程 0 之前，你还应先完成课程 1。这是不可能的。
```

## 提示：

1. 输入的先决条件是由 边缘列表 表示的图形，而不是 邻接矩阵 。详情请参见图的表示法。
2. 你可以假定输入的先决条件中没有重复的边。
3. 1 <= numCourses <= 10^5

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/course-schedule
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

## Solution
1. 拓扑排序
2. DFS 判断有环

## Code

1. 拓扑排序
```c++
   class Solution {
public:
    bool canFinish(int numCourses, vector<vector<int>>& prerequisites) {
        int d[numCourses];
        fill(d,d+numCourses,0);
        vector<int> v[numCourses];
        int x,y;
        for(int i=0;i<prerequisites.size();i++){
           x = prerequisites[i][0], y = prerequisites[i][1];
           d[y] ++;
           v[x].push_back(y);
        }
        int point = -1,k = numCourses,ds = 0;
        while(k > 0){
            point = -1;
            // 找到 拓扑排序的起点
            for(int i = 0;i<numCourses;i++){
                if(d[i] == 0){
                    point = i;
                    d[i] = -1;
                    ds ++;
                    break;
                }
            }
            if(point == -1 && k > 1 ) return false;
            else if(point == -1) return true;
            // 去掉 顶点 point
            for(int i=0;i < v[point].size();i++){
                y = v[point][i];
                d[y]--;
            }
            v[point].clear();
            k--;
        }
        return ds == numCourses;
    }
}; 
```
2. DFS 判断是否有环

```c++

class Solution {
public:


    bool hasCycle(vector<vector<int>>& v, int idx,vector<int>& visited,vector<int>& localvisited){
        // 缓存
        if(visited[idx]) return false;
        localvisited[idx] = 1;
        visited[idx] = 1;
        for(int i = 0; i< v[idx].size(); i++){
            if(localvisited[v[idx][i]]) return true;
            else if(hasCycle(v,v[idx][i],visited,localvisited)) return true;
        }
        localvisited[idx] = 0;
        return false;
    }
    
    bool canFinish(int numCourses, vector<vector<int>>& prerequisites) {

        // 拓扑排序
        // 采用邻接表表示有向图
        vector<vector<int>> v;
        for(int i=0;i<numCourses;i++){
            v.push_back({});
        }
      
        for(int i =0 ; i<prerequisites.size(); i++){
            v[prerequisites[i][0]].push_back(prerequisites[i][1]);
        }
        // 是否访问过
        vector<int> visited(numCourses,0);
        vector<int> localvisited(numCourses,0);
        for(int i=0;i<numCourses;i++){
            if(hasCycle(v,i,visited,localvisited)) return false;
        }
        return true;
    }
}
```
