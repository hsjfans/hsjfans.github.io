---
title: '面试题 17.15. 最长单词'
date: 2020-03-24 08:18:00
tags: [leetcode,algorithm]
published: true
hideInList: false
feature: 
isTop: false
---
给定一组单词`words`，编写一个程序，找出其中的最长单词，且该单词由这组单词中的其他单词组合而成。若有多个长度相同的结果，返回其中字典序最小的一项，若没有符合要求的单词则返回空字符串。

## 示例：
```
输入： ["cat","banana","dog","nana","walk","walker","dogwalker"]
输出： "dogwalker"
解释： "dogwalker"可由"dog"和"walker"组成。
```
提示：
```
0 <= len(words) <= 100
1 <= len(words[i]) <= 100
```
来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/longest-word-lcci


## Solution

   hashmap 与 递归
   对于一个字符串 ，由于不知道它由几部分组成，因此只能按位分割，逐段匹配。使用 hash 的作用是为了加快匹配速度
    
   
## Code

   ``` c++
  
class Solution {
public:
   
    static bool cmp(string a,string b){
        if(a.size()!=b.size()) return a.size() > b.size();
        else return a < b;
    } 

    bool isCombine(map<string,int> &maps,string str,int less,bool origin){
        if(str.size() < less) return false;
        if(maps.count(str)>0 && !origin) return true;
        for(int i=less;i<= str.size()-less;i++){
            if(maps.count(str.substr(0,i)) > 0 && isCombine(maps,str.substr(i,str.size()-i),less,false)) return true;
        }
        return false;
    }
     
    string longestWord(vector<string>& words) {
        if(words.size() < 2) return "";
        map<string,int> maps;
        int len = words.size();
        for(int i=0;i< len;i++ ) maps[words[i]] = 1;
        sort(words.begin(),words.end(),cmp);
        int less = words[len-1].size();
        for(int i= 0;i< len -1;i++){
            string word = words[i];
            if(word.size() < less *2) return "";
            if(isCombine(maps,word,less,true)){
               return word;
            }
        }
        return "";        
    }
};
   ```