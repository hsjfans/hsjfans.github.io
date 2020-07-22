---
title: '123. 买卖股票的最佳时机 III'
date: 2020-03-22 09:03:06
tags: [leetcode,dynamic-programming,algorithm]
published: true
hideInList: false
feature: 
isTop: false
---
给定一个数组，它的第 i 个元素是一支给定的股票在第 i 天的价格。

设计一个算法来计算你所能获取的最大利润。你最多可以完成 两笔 交易。

注意: 你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。

## 示例 1:
```
输入: [3,3,5,0,0,3,1,4]
输出: 6
```
解释: 在第 4 天（股票价格 = 0）的时候买入，在第 6 天（股票价格 = 3）的时候卖出，这笔交易所能获得利润 = 3-0 = 3 。
     随后，在第 7 天（股票价格 = 1）的时候买入，在第 8 天 （股票价格 = 4）的时候卖出，这笔交易所能获得利润 = 4-1 = 3 。
## 示例 2:
```
输入: [1,2,3,4,5]
输出: 4
```
解释: 在第 1 天（股票价格 = 1）的时候买入，在第 5 天 （股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。   
     注意你不能在第 1 天和第 2 天接连购买股票，之后再将它们卖出。   
     因为这样属于同时参与了多笔交易，你必须在再次购买前出售掉之前的股票。
## 示例 3:
```
输入: [7,6,4,3,1] 
输出: 0 
```
解释: 在这个情况下, 没有交易完成, 所以最大利润为 0。

## Solution

递归式为 

$$res = max( \sum_{j=0}^{n-1} (profits[j]+profits-reverse[j]) )$$

其中 $profits[j]$ 代表为 正向(0,j.) 能够获取的最大利润；$profits-reverse[j]$ 代表(j,n-1)能获取的最大利润

## Code
```c++
class Solution {
public:

    int maxProfit(vector<int>& prices) {
        int n = prices.size();
        if(n<=1) return 0;
        int profits[n];
        fill(profits,profits+n,0);
        int less = prices[0];
        for(int i=1;i<n;i++){
            profits[i] = max(prices[i]-less,profits[i-1]);
            less = min(less,prices[i]);
        }
        int res = profits[n-1],last,ma = prices[n-1];
        profits[n-1] = 0;
        for(int j=n-2;j>=0;j--){
            last = profits[j];
            profits[j] = max(profits[j+1],ma - prices[j]);
            ma = max(ma,prices[j]);
            res = max(res,last + profits[j]);
        }
        return res;
    }
};
```