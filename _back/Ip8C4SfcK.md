---
title: '1030 Travel Plan (30分)'
date: 2020-03-10 14:34:31
tags: [graph,pat,algorithm]
published: true
hideInList: false
feature: https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200310122256.png
isTop: false
---
A traveler's map gives the distances between cities along the highways, together with the cost of each highway. Now you are supposed to write a program to help a traveler to decide the shortest path between his/her starting city and the destination. If such a shortest path is not unique, you are supposed to output the one with the minimum cost, which is guaranteed to be unique.

## Input Specification:
Each input file contains one test case. Each case starts with a line containing 4 positive integers N, M, S, and D, where N (≤500) is the number of cities (and hence the cities are numbered from 0 to N−1); M is the number of highways; S and D are the starting and the destination cities, respectively. Then M lines follow, each provides the information of a highway, in the format:

``` 
City1 City2 Distance Cost 
```

where the numbers are all integers no more than 500, and are separated by a space.

## Output Specification:
For each test case, print in one line the cities along the shortest path from the starting point to the destination, followed by the total distance and the total cost of the path. The numbers must be separated by a space and there must be no extra space at the end of output.

## Sample 
### Input:
```
4 5 0 3
0 1 1 20
1 3 2 30
0 3 4 10
0 2 2 20
2 3 1 20
```
      
    
### Output:
```
0 2 3 3 40
```


## Solution

最短路径问题，修改 Dijkstra 算法，记录下其 权重、代价以及 前路径即可

## Code

```c++
#include<iostream>

using namespace std;

void pat_1030(){
    int n,m,s,d;
    int max = 0x7fffffff;
    cin >> n >> m >> s >> d;
    // 距离,成本，路径以及是否访问过
    int distance[n],costs[n],paths[n],visited[n];
    int v[n][n],c[n][n];
    fill(v[0],v[0]+n*n,0);
    fill(distance,distance+n,max);
    fill(costs,costs+n,max);
    fill(visited,visited+n,0);
    fill(paths,paths+n,s);
    int i,x,y,dis,cost;
    for(i=0;i<m;i++){
        cin >> x >> y >> dis >> cost;
        v[x][y] = dis;
        v[y][x] = dis;
        c[x][y] = cost;
        c[y][x] = cost;
    }

    // 最短路径问题
    int visit =0,cur = s,min_id=s,min;
    visited[cur] = 1;
    costs[cur] = 0;
    distance[cur] = 0;
    while(visit<n && cur!=d){
        min = max;
        for(int k=0;k<n;k++){
            // 存在路径
            if(v[cur][k] > 0 && !visited[k]){
                dis = v[cur][k] + distance[cur];
                cost = c[cur][k] + costs[cur];
                if(dis < distance[k] ){
                    distance[k] = dis;
                    paths[k] = cur;
                    costs[k] = cost;
                } else if(dis == distance[k]){
                    if(cost < costs[k]) {
                        costs[k] = cost;
                        paths[k] = cur;
                    }
                }
            }
            if(!visited[k] && distance[k] < min ){
                min = distance[k];
                min_id = k;
            }

        }

        cur = min_id;
        visited[cur] = 1;
        visit++;
    }

    int target = d;
    string res = to_string(d)+" ";
    while(d!=paths[d]){
        res = to_string(paths[d]) + " " + res;
        d = paths[d];
    }
    cout << res << distance[target] << " " << costs[target];
}

int main(){
    pat_1030();
    return 0;
}
```