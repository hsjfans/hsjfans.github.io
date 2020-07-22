---
title: '72. 编辑距离'
date: 2020-03-19 09:45:31
tags: [leetcode,dynamic-programming,algorithm]
published: true
hideInList: false
feature: 
isTop: false
---
给定两个单词 word1 和 word2，计算出将 word1 转换成 word2 所使用的最少操作数 。

你可以对一个单词进行如下三种操作：

插入一个字符
删除一个字符
替换一个字符
##示例 1:
```
输入: word1 = "horse", word2 = "ros"
输出: 3
解释: 
horse -> rorse (将 'h' 替换为 'r')
rorse -> rose (删除 'r')
rose -> ros (删除 'e')
```
##示例 2:
```
输入: word1 = "intention", word2 = "execution"
输出: 5
解释: 
intention -> inention (删除 't')
inention -> enention (将 'i' 替换为 'e')
enention -> exention (将 'n' 替换为 'x')
exention -> exection (将 'n' 替换为 'c')
exection -> execution (插入 'u')
```
来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/edit-distance

## Solution

`dp[i][j]` 代表 `word1[i]` 到 `word2[j] `的最小变换

1. `word1[i] == word2[j]` `i`和`j` 同时向前移动一位 即 `dp[i][j] == dp[i-1][j-1]`
2. `word1[i] ` $\neq$ `word2[j]` 此时有三种方案
     1. 替换 即令 `word1[i] = word2[j] `，有  `dp[i][j] == dp[i-1][j-1] + 1` 
     2. 删除，即删掉元素 `word1[i]`,此时有  `dp[i][j] == dp[i-1][j] + 1` 
     3. 插入，即在 `word1 i` 处插入 元素 `word2[j]` ，此时有  `dp[i][j] == dp[i][j-1] + 1`
     4. 取以上三者最小值即可 `dp[i][j] = min{dp[i-1][j-1] ,dp[i-1][j] ,dp[i][j-1] }+1`

## Code

```c++
class Solution {
public:
    int minDistance(string word1, string word2)
{
    int m = word1.size(), n =word2.size();
    int dp[m+1][n+1];
    for(int i=0;i<=m;i++) dp[i][0] = i;
    for(int i=0;i<=n;i++) dp[0][i] = i;
    for(int i=1;i<=m;i++){
        for(int j=1;j<=n;j++){
            if(word1[i-1]== word2[j-1]) dp[i][j] = dp[i-1][j-1];
            else {
                dp[i][j] = min(min(dp[i-1][j],dp[i][j-1]),dp[i-1][j-1]) + 1;
            }
        } 
    }
    return dp[m][n];
}
};
```