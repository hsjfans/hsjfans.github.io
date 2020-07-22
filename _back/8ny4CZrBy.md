---
title: '1090 Highest Price in Supply Chain (25分)'
date: 2020-03-10 11:45:51
tags: [pat,algorithm,graph]
published: true
hideInList: false
feature: https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200311014013.png
isTop: false
---

A supply chain is a network of retailers（零售商）, distributors（经销商）, and suppliers（供应商）-- everyone involved in moving a product from supplier to customer.

Starting from one root supplier, everyone on the chain buys products from one's supplier in a price P and sell or distribute them in a price that is r% higher than P. It is assumed that each member in the supply chain has exactly one supplier except the root supplier, and there is no supply cycle.

Now given a supply chain, you are supposed to tell the highest price we can expect from some retailers.

## Input Specification:
Each input file contains one test case. For each case, The first line contains three positive numbers: ($N ≤ 10^5$), the total number of the members in the supply chain (and hence they are numbered from 0 to N−1); P, the price given by the root supplier; and r, the percentage rate of price increment for each distributor or retailer. Then the next line contains N numbers, each number $S_i$ is the index of the supplier for the i-th member. $S_root$ for the root supplier is defined to be −1. All the numbers in a line are separated by a space.

## Output Specification:
For each test case, print in one line the highest price we can expect from some retailers, accurate up to 2 decimal places, and the number of retailers that sell at the highest price. There must be one space between the two numbers. It is guaranteed that the price will not exceed $$10^10$$.

## Sample
### Input:
```
9 1.80 1.00
1 5 4 4 -1 4 5 3 6
```

### Output:
```
1.85 2
```
## Solution
例子可以抽象为如下所示的一颗树

```
        4
    /   |   \
 2     3    5
     /     /   \
  7      6       1
        /        /
      8         0 

<- height = 4, number = 2 ->
```

供应链是一个有向无环图，可以抽象为一棵树。本题主要是为了求树的高度以及最后一层树的节点数，采用层序遍历（BFS）即可。注意一点是，float 的表示范围无法到达 $$10^10$$，故需采用 double 类型

## Code

```c++
#include<iostream>
#include<cmath>
#include<vector>
#include<queue>
using namespace std;

void pat_1090(){

    // n the total number of the numbers in the supply chain
    int n;
    // p is the original price 
    // r is the up rate in every convery
    double p,r;
    cin >> n >> p >> r;
    
    // 拓扑图(无环，有向图)，采用树来模拟
    vector<int> tree[n+1];
    // 构建树
    int i,parent,root;
    for(int i=0;i<n;i++){
        cin >> parent;
        if(parent == -1) root = i;
        else tree[parent].push_back(i);
    } 
    
    int size ,height = 0,node;

    // 采用树的层序遍历。即类似于图的 BFS 来寻找最长路径
    queue<int> q;
    q.push(root);
    while(!q.empty()){
        size = q.size();
        height ++;
        for(i=0;i< size;i++){
            node = q.front();
            q.pop();
            // 这里由于是有向无环图，每个节点只访问一次，故无需标记
            for(int j=0;j<tree[node].size();j++){
                q.push(tree[node][j]);
            }
        }
    }
    r = 1+0.01*r;
    double res = pow(r,height-1) * p;
    printf("%.2lf %d\n",res,size);
    

}

int main(){
    pat_1090();
    return 0;
}
```