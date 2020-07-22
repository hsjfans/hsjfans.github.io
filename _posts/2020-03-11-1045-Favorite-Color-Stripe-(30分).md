---
layout: post
title: '1045 Favorite Color Stripe (30分)'
date: 2020-03-11 12:09:18
tags: [pat,algorithm,dynamic,dynamic-programming]
published: true
hideInList: false
feature: https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200311122703.png
isTop: false
---
Eva is trying to make her own color stripe out of a given one. She would like to keep only her favorite colors in her favorite order by cutting off those unwanted pieces and sewing the remaining parts together to form her favorite color stripe.

It is said that a normal human eye can distinguish about less than 200 different colors, so Eva's favorite colors are limited. However the original stripe could be very long, and Eva would like to have the remaining favorite stripe with the maximum length. So she needs your help to find her the best result.

Note that the solution might not be unique, but you only have to tell her the maximum length. For example, given a stripe of colors {2 2 4 1 5 5 6 3 1 1 5 6}. If Eva's favorite colors are given in her favorite order as {2 3 1 5 6}, then she has 4 possible best solutions {2 2 1 1 1 5 6}, {2 2 1 5 5 5 6}, {2 2 1 5 5 6 6}, and {2 2 3 1 1 5 6}.

## Input Specification:
Each input file contains one test case. For each case, the first line contains a positive integer N (≤200) which is the total number of colors involved (and hence the colors are numbered from 1 to N). Then the next line starts with a positive integer M (≤200) followed by M Eva's favorite color numbers given in her favorite order. Finally the third line starts with a positive integer L (≤$10^4$ ) which is the length of the given stripe, followed by L colors on the stripe. All the numbers in a line a separated by a space.

## Output Specification:
For each test case, simply print in a line the maximum length of Eva's favorite stripe.

## Sample 
### Input:
```
6
5 2 3 1 5 6
12 2 2 4 1 5 5 6 3 1 1 5 6

```      
    
### Output:
```
7
```

## Solution

题目意思为要求出能够留下的喜欢条纹的最大长度，约束主要是喜欢序列的顺序，即必须按照顺序进行保留。对于目标序列 `2 3 1 5 6`，如果`3` 已经保留，后面的条纹如果出现的`2`则被抛弃掉（优先级一次递减的感觉）。而且，结果的同一种条纹可以连续出现，条纹种类可以不完全都有。

对于每个最优子结构都有 （F(n) 为当前颜色为`n`的最大长度）

```latex
F(2) = F(2) + 1 // max(F(2),F(0))+1 
F(3) = max(F(2),F(3)) +1
...
```
由此可以得到递推公式:

$$ F(n) = max(F(n),F(n-1)) +1 $$

这里需要 F(n-1)，F(n) 类似于 F(3) ,F(2)  ，因此需要保留 目标条纹之间的位置关系，这个可以使用 map 实现，也可以使用 空间换时间的 数组实现 （其实也是 map 的思想）

## Code

```c++

#include<iostream>
#include<cmath>
using namespace std;

void pat_1045(){
    int n,m,l,color;
    cin >> n;
    int i,wanted[n+1],indexes[n+1];
    wanted[0] = 0;
    fill(indexes,indexes+n+1,0);
    cin >> m;
    for(i=1;i<= m;i++){
      cin >> color;
      indexes[color] = i;
      wanted[i] = color;
    }
    cin >> l;
    int nums[l+1];
    for(i=1;i<=l;i++ )
        cin >> nums[i];
    int res[n+1];
    fill(res,res+n+1,0);
    int max_re = 0;
    for(i=1;i<=l;i++){
        if(indexes[nums[i]]>0)
        {
            res[nums[i]] = max(res[nums[i]],res[wanted[indexes[nums[i]]-1]]) + 1;
            max_re = max(max_re,res[nums[i]]);
        }
    }
    cout << max_re;
}

int main(){
    pat_1045();
    return 0;
}

```
