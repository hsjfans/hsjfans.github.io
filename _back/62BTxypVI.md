---
title: '1021 Deepest Root (25分)'
date: 2020-03-08 10:53:14
tags: [algorithm,pat]
published: true
hideInList: false
feature: http://images6.fanpop.com/image/photos/40600000/Spongebob-spongebob-squarepants-40625703-1920-1080.jpg
isTop: false
---
A graph which is connected and acyclic can be considered a tree. The height of the tree depends on the selected root. Now you are supposed to find the root that results in a highest tree. Such a root is called the deepest root.

### Input Specification:

Each input file contains one test case. For each case, the first line contains a positive integer N (<=10000) which is the number of nodes, and hence the nodes are numbered from 1 to N. Then N-1 lines follow, each describes an edge by given the two adjacent nodes’ numbers.

### Output Specification:

For each test case, print each of the deepest roots in a line. If such a root is not unique, print them in increasing order of their numbers. In case that the given graph is not a tree, print “Error: K components” where K is the number of connected components in the graph.

### Sample Input 1:
5
1 2
1 3
1 4
2 5
### Sample Output 1:
3
4
5
### Sample Input 2:
5
1 3
1 4
2 5
3 4
### Sample Output 2:
Error: 2 components

### Solution

本题很关键的一个点是： 有 n 个顶点，但是只有 n-1 条边。由于构成一个连通图的无向图要求，n个顶点最少有n个边，因此本题可以看作为求 一个图的连通分量数目 以及 图的遍历。 对于图的遍历，可以采用 DFS 或者 BFS，求图的连通分量个数，可以采用并查集或者整合到图的遍历过程中

### Code

```c++

#include<iostream>
#include<queue>
#include<vector>
using namespace std;


void dfs_1021(vector<int> *graph,int *visited,int node,int height,int &maxheight,vector<int> &res){

    visited[node] = 1;
    if(height > maxheight){
        maxheight = height;
        res.clear();
        res.push_back(node);
    } else if(height == maxheight)
        res.push_back(node);
    for(int i=0;i<graph[node].size();i++){
        if( !visited[graph[node][i]] )
            dfs_1021(graph,visited,graph[node][i],height+1,maxheight,res);
        
    }

}


void pat_1021()
{
  int n,i;
  cin >> n;
  // 采用邻接表的来存储无向图
  vector<int> graph[n+1];
  int x,y,visited[n+1];
  // 标记为未访问过
  fill(visited,visited+n+1,0);
  for(i= 0;i<n-1;i++){
      cin >> x >> y;
      graph[x].push_back(y);
      graph[y].push_back(x);
  }
  vector<int> res;
  int maxheight  = 0;
  int k =0;
  for(int j=1;j<=n;j++){
      if(visited[j]==0){
          dfs_1021(graph,visited,j,1,maxheight,res);
          k++;
      }
  }
  if(k>1) printf("Error: %d components\n",k);
  else {
      int nodes[n+1],node = res[0];
      fill(nodes,nodes+n+1,0);
      for(i =0;i<res.size();i++)
          nodes[res[i]]++;
     
     if(n>1){
       res.clear();
       fill(visited,visited+n+1,0);
       maxheight = 0;
       dfs_1021(graph,visited,node,1,maxheight,res);
       for(i =0;i<res.size();i++)
           nodes[res[i]]++;
      }
      for(i=1;i<=n;i++){
          if(nodes[i] > 0) cout << i << endl;
      }
  }


  

}

int main()
{
    pat_1021();
    return 0;
}
```