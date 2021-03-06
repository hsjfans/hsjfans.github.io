---
title: '1316. 不同的循环子字符串'
date: 2020-05-05 10:29:49
tags: [leetcode,一刷leetcode]
published: true
hideInList: false
feature: 
isTop: false
---
给你一个字符串 text ，请你返回满足下述条件的 不同 非空子字符串的数目：

可以写成某个字符串与其自身相连接的形式（即，可以写为 a + a，其中 a 是某个字符串）。
例如，abcabc 就是 abc 和它自身连接形成的。

 

## 示例 1：
```
输入：text = "abcabcabc"
输出：3
解释：3 个子字符串分别为 "abcabc"，"bcabca" 和 "cabcab" 。
```
示例 2：
```
输入：text = "leetcodeleetcode"
输出：2
解释：2 个子字符串为 "ee" 和 "leetcodeleetcode" 。
 ```

## 提示：

1. 1 <= text.length <= 2000
2. text 只包含小写英文字母。

## Solution

1. 暴力(复杂度 O(n^3) 超时)

暴力枚举所有字串，然后核对是否符合条件，使用 hash 表来排重

```c++
class Solution {
public:
    
    string check(string a){
        int n = a.size();
        if(n % 2 !=0 ) return "";
        else return a.substr(0,n/2) == a.substr(n/2,n/2) ? a : "";
    }
    
    int distinctEchoSubstrings(string text) {
        int n= text.size();
        int ans = 0;
        string res;
        map<string,bool> maps;
        for(int i=0;i<n;i++){
            for(int j=i+1;j<n;j++){
                res = check(text.substr(i,j-i+1));
                if(res.size() > 0 && !maps[res]){
                    maps[res] = true;
                    ans ++;
                } 
            }
        }
        return ans;
    }
};
```

由于字符串的比较最坏是 O(N) 因此时间复杂度过高，导致 ac 失败


2. 暴力优化 （O(n^2)

```c++
using LL = long long;

class Solution {
private:
    constexpr static int mod = (int)1e9 + 7;
    
public:
    int gethash(const vector<int>& pre, const vector<int>& mul, int l, int r) {
        return (pre[r + 1] - (LL)pre[l] * mul[r - l + 1] % mod + mod) % mod;
    }
    
    int distinctEchoSubstrings(string text) {
        int n = text.size();
        
        int base = 31;
        vector<int> pre(n + 1), mul(n + 1);
        pre[0] = 0;
        mul[0] = 1;
        for (int i = 1; i <= n; ++i) {
            pre[i] = ((LL)pre[i - 1] * base + text[i - 1]) % mod;
            mul[i] = (LL)mul[i - 1] * base % mod;
        }
        
        unordered_set<int> seen[n];
        int ans = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int l = j - i;
                if (j + l <= n) {
                    int hash_left = gethash(pre, mul, i, j - 1);
                    if (!seen[l - 1].count(hash_left) && hash_left == gethash(pre, mul, j, j + l - 1)) {
                        ++ans;
                        seen[l - 1].insert(hash_left);
                    }
                }
            }
        }
        return ans;
    }
};

```

