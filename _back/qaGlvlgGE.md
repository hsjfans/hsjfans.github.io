---
title: '322. 零钱兑换'
date: 2020-04-07 10:40:32
tags: []
published: true
hideInList: false
feature: 
isTop: false
---
给定不同面额的硬币 coins 和一个总金额 amount。编写一个函数来计算可以凑成总金额所需的最少的硬币个数。如果没有任何一种硬币组合能组成总金额，返回 -1。

## 示例 1:
```
输入: coins = [1, 2, 5], amount = 11
输出: 3 
解释: 11 = 5 + 5 + 1
```
## 示例 2:
```
输入: coins = [2], amount = 3
输出: -1
```
说明:
你可以认为每种硬币的数量是无限的。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/coin-change
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。


## Solution

动态规划

## Code
```c++
class Solution {
public:
    int coinChange(vector<int>& coins, int amount) {
        int dp[amount+1];
        fill(dp,dp+amount+1,0);
        int c; 
        for(int i=1;i<=amount;i++){
            c = -1;
            for(int j=0;j<coins.size();j++){
                if(i >= coins[j]){
                   if((c==-1 || (c > dp[i-coins[j]])) && dp[i-coins[j]] >= 0) c = dp[i-coins[j]];
                }
            }
            dp[i] = c!=-1 ? c+1:-1;
        }
        return dp[amount] >= 0 ?dp[amount]:-1;
    }
};
```