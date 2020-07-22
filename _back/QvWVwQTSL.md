---
title: '1154 Vertex Coloring (25分)'
date: 2020-03-13 14:26:26
tags: [graph,pat,algorithm]
published: true
hideInList: false
feature: https://img.500px.me/4ffc55681e6643f7968b7b3ce57213a9.jpg!p5
isTop: false
---
A proper vertex coloring is a labeling of the graph's vertices with colors such that no two vertices sharing the same edge have the same color. A coloring using at most k colors is called a (proper) k-coloring.

Now you are supposed to tell if a given coloring is a proper k-coloring.

## Input Specification:
Each input file contains one test case. For each case, the first line gives two positive integers N and M (both no more than $10^4$), being the total numbers of vertices and edges, respectively. Then M lines follow, each describes an edge by giving the indices (from 0 to N−1) of the two ends of the edge.

After the graph, a positive integer K (≤ 100) is given, which is the number of colorings you are supposed to check. Then K lines follow, each contains N colors which are represented by non-negative integers in the range of int. The i-th color is the color of the i-th vertex.

## Output Specification:
For each coloring, print in a line k-coloring if it is a proper k-coloring for some positive k, or No if not.

## Sample 
### Input:
```
10 11
8 7
6 8
4 5
8 4
8 1
1 2
1 4
9 8
9 1
1 0
2 4
4
0 1 0 1 4 1 0 1 3 0
0 1 0 1 4 1 0 1 0 0
8 1 0 1 4 1 0 5 3 0
1 2 3 4 5 6 7 8 8 9
```
      
    
### Output:
```
4-coloring
No
6-coloring
No
```


## Solution

实际上考察的是图的遍历，这里采用的是无向图的邻接表的存法，BFS (类似于)

## Code
```c++
#include<iostream>
#include<map>
#include<vector>
using namespace std;
 

void pat_1154()
{

    int n, m;
    cin >> n >> m;
    int i, v1, v2, visited[n];
    vector<int> vertices[n];
    for (i = 0; i < m; i++)
    {
        cin >> v1 >> v2;
        vertices[v1].push_back(v2);
        vertices[v2].push_back(v1);
    }
    int k;
    cin >> k;
    for (int j = 0; j < k; j++)
    {
        int color = 0, colors[n], num = 0;
        map<int, int> maps;
        fill(visited, visited + n, 0);
        for (i = 0; i < n; i++)
        {
            cin >> color;
            if (maps.count(color) == 0)
            {
                num++;
                maps[color] = 1;
            }
            colors[i] = color;
        }
        bool ok = true;
        for (i = 0; i < n; i++)
        {
            if (!visited[i])
            {
                for (int k = 0; k < vertices[i].size(); k++)
                {
                    if (!visited[vertices[i][k]])
                    {
                        if (colors[i] == colors[vertices[i][k]])
                        {
                            ok = false;
                            break;
                        }
                    }
                }
                visited[i] = 1;
            }
        }
        if (ok)
            printf("%d-coloring\n", num);
        else
            cout << "No" << endl;
    }
}

int main()
{
    pat_1154();
    return 0;
}


```
