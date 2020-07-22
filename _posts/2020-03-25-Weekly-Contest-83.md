---
layout: post
title: 'Weekly Contest 83'
date: 2020-03-25 12:11:07
tags: [一刷leetcode,leetcode]
published: true
hideInList: false
feature: 
isTop: false
---
## 830. 较大分组的位置

在一个由小写字母构成的字符串 S 中，包含由一些连续的相同字符所构成的分组。

例如，在字符串 S = "abbxxxxzyy" 中，就含有 "a", "bb", "xxxx", "z" 和 "yy" 这样的一些分组。

我们称所有包含大于或等于三个连续字符的分组为较大分组。找到每一个较大分组的起始和终止位置。

最终结果按照字典顺序输出。

示例 1:
```
输入: "abbxxxxzzy"
输出: [[3,6]]
解释: "xxxx" 是一个起始于 3 且终止于 6 的较大分组。
```
示例 2:
```
输入: "abc"
输出: []
解释: "a","b" 和 "c" 均不是符合要求的较大分组。
```
示例 3:
```
输入: "abcdddeeeeaabbbcd"
输出: [[3,5],[6,9],[12,14]]
```
说明:  1 <= S.length <= 1000

### Solution
 
 这道题比较简单，只需要向后找即可,当字符变化时，判断其长度是否符合要求

 ### Code
 ```c++
class Solution {
public:
    vector<vector<int>> largeGroupPositions(string S) {
        vector<vector<int>> result;
        if(S.size()<3) return result;
        int num = 1,prev = 0;
        for(int i=1;i<S.size();i++){
            if(S[prev] == S[i]){
                num ++;
            }
            if(S[prev] != S[i] || i == S.size()-1){
                if(num >=3 ) {
                    vector<int> re{prev,prev+num-1};
                    result.push_back(re);
                }
                prev = i;
                num = 1;
            }
        }
      
        return result;
    }
};
 ```


 ## 831. 隐藏个人信息
 给你一条个人信息 string S，它可能是一个邮箱地址，也可能是一个电话号码。

我们将隐藏它的隐私信息，通过如下规则:

 

<u>1. 电子邮箱</u>

定义名称 <name> 是长度大于等于 2 （length ≥ 2），并且只包含小写字母 a-z 和大写字母 A-Z 的字符串。

电子邮箱地址由名称 <name> 开头，紧接着是符号 <font face="Menlo, Monaco, Consolas, Courier New, monospace">'@'</font>，后面接着一个名称 <name>，再接着一个点号 '.'，然后是一个名称 <name>。

电子邮箱地址确定为有效的，并且格式是 "name1@name2.name3"。

为了隐藏电子邮箱，所有的名称 <name> 必须被转换成小写的，并且第一个名称 <name> 的第一个字母和最后一个字母的中间的所有字母由 5 个 '*' 代替。

 

<u>2. 电话号码</u>

电话号码是一串包括数字 0-9，以及 {'+', '-', '(', ')', ' '} 这几个字符的字符串。你可以假设电话号码包含 10 到 13 个数字。

电话号码的最后 10 个数字组成本地号码，在这之前的数字组成国际号码。注意，国际号码是可选的。我们只暴露最后 4 个数字并隐藏所有其他数字。

本地号码是有格式的，并且如 "***-***-1111" 这样显示，这里的 1 表示暴露的数字。

为了隐藏有国际号码的电话号码，像 "+111 111 111 1111"，我们以 "+***-***-***-1111" 的格式来显示。在本地号码前面的 '+' 号和第一个 '-' 号仅当电话号码中包含国际号码时存在。例如，一个 12 位的电话号码应当以 "+**-" 开头进行显示。

注意：像 "("，")"，" " 这样的不相干的字符以及不符合上述格式的额外的减号或者加号都应当被删除。

最后，将提供的信息正确隐藏后返回。
 
### 示例 1：
```
输入: "LeetCode@LeetCode.com"
输出: "l*****e@leetcode.com"
解释： 
所有的名称转换成小写, 第一个名称的第一个字符和最后一个字符中间由 5 个星号代替。
因此，"leetcode" -> "l*****e"。
```
### 示例 2：
```
输入: "AB@qq.com"
输出: "a*****b@qq.com"
解释: 
第一个名称"ab"的第一个字符和最后一个字符的中间必须有 5 个星号
因此，"ab" -> "a*****b"。
```
### 示例 3：
```
输入: "1(234)567-890"
输出: "***-***-7890"
解释: 
10 个数字的电话号码，那意味着所有的数字都是本地号码。
```
### 示例 4：
```
输入: "86-(10)12345678"
输出: "+**-***-***-5678"
解释: 
12 位数字，2 个数字是国际号码另外 10 个数字是本地号码 。
 ```

**注意:**

1. S.length <= 40。
2. 邮箱的长度至少是 8。
3. 电话号码的长度至少是 10。


### Solution

根据规则也即可

### Code

```c++
class Solution {
public:
    
    char upToLow(char c){
        if(c>='A' && c <= 'Z') return (char)(c^0x20);
        else return c;
    }
    
    string hiddenEmail(string s){
        string res;
        bool has = false;
        for(int i =0;i<s.size();i++){
            if(s[i] == '@'){
                res = (char)upToLow(s[0]);
                res += "*****";
                res = res + (char)upToLow(s[i-1]);
                res += "@"; 
                has = true;
            }
            else if(has){
                res = res + upToLow(s[i]) ;
            }
        }
        return res;
    }
    
    string hiddenPhone(string s){
        int num  = 0;
        string res;
        for(int i=s.size()-1;i>=0;i--){
            if(s[i] >='0' && s[i]<='9'){
                num ++;
                if(num <= 4 )  res = s[i]+res;
         
            }
        }
        
        int k = (num-4)/3;
        int t = num - 3*k -4;
        for(int i=0;i<k;i++){
            res = "***-"+res;
        }
        if(t == 0 && num > 10) {
            res = "+"+res;
        }else if(t == 1) res = "+*-"+res;
        else if(t==2) res = "+**-"+res;
        
        return res;
     
    }
    
    string maskPII(string S) {
        if((S[0] >='A' && S[0] <='Z') || (S[0]>='a' && S[0]<='z')) return hiddenEmail(S);
        else return hiddenPhone(S);
    }
};
```

## 829. 连续整数求和

给定一个正整数 N，试求有多少组连续正整数满足所有数字之和为 N?

示例 1:
```
输入: 5
输出: 2
解释: 5 = 5 = 2 + 3，共有两组连续整数([5],[2,3])求和后为 5。
```
示例 2:
```
输入: 9
输出: 3
解释: 9 = 9 = 4 + 5 = 2 + 3 + 4
```
示例 3:
```
输入: 15
输出: 4
解释: 15 = 15 = 8 + 7 = 4 + 5 + 6 = 1 + 2 + 3 + 4 + 5
```
说明: 1 <= N <= 10 ^ 9

### Solution

这是一道数学题目，没啥技巧的

首先，连续数字可以由 2，3，4，5... k 个连续数字组成，但是 k 有要求

例如对于 输入 15 ， k 必须要  
$$ (15/k - (k-1)/2) ...   15/k-1 、 15/k、 15/k +1 ... 即 (15/k - (k-1)/2)  >=1 $$

因此对于任意的整数 n，则有 $k*k+k<= 2*n$

而对于满足要求的 k 值，
1. 当 $n/k == 0  && k %2 !=0$ 时，肯定满足条件
2. 当 $n/k!=0$时，计算 sum 值即可

### Code

```c++
class Solution {
public:
    int consecutiveNumbersSum(int N) {
      
        int i=2,num = 1;
        int sum = 0,a;
        
        while(i*i + i <= 2*N){
            if(N%i == 0 && i%2 != 0) num ++; 
            else if(N%i != 0){
              a = N/i;
              sum = i * (a - (i-1)/2) + (i-1)*i/2;
              if(sum == N) num++;
            }  
            i++;
        }
        return num;
    }
};
```

## 828. 统计子串中的唯一字符

我们定义了一个函数 countUniqueChars(s) 来统计字符串 s 中的唯一字符，并返回唯一字符的个数。

例如：s = "LEETCODE" ，则其中 "L", "T","C","O","D" 都是唯一字符，因为它们只出现一次，所以 countUniqueChars(s) = 5 。

本题将会给你一个字符串 s ，我们需要返回 countUniqueChars(t) 的总和，其中 t 是 s 的子字符串。注意，某些子字符串可能是重复的，但你统计时也必须算上这些重复的子字符串（也就是说，你必须统计 s 的所有子字符串中的唯一字符）。

由于答案可能非常大，请将结果 mod 10 ^ 9 + 7 后再返回。

示例 1：
```
输入: "ABC"
输出: 10
解释: 所有可能的子串为："A","B","C","AB","BC" 和 "ABC"。
     其中，每一个子串都由独特字符构成。
     所以其长度总和为：1 + 1 + 1 + 2 + 2 + 3 = 10
```
示例 2：
```
输入: "ABA"
输出: 8
解释: 除了 countUniqueChars("ABA") = 1 之外，其余与示例 1 相同。
```
示例 3：
```
输入：s = "LEETCODE"
输出：92
```
提示：

1. 0 <= s.length <= 10^4
2. s 只包含大写英文字符


### Solution

 暴力(用了 hash 和 dp 优化),穷举所有的字串，然后 就 `GG`了
![](https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200325122840.png)


```c++

class Solution {
public:
    
    int uniqueLetterString(string s) {
        
        int num = 0;
        for(int i=0;i<s.size();i++){
            int prev = 0,cur = 0, maps[26] = {0};
            for(int j=i;j<s.size();j++){
                maps[s[j]-'A']++;
                if(maps[s[j]-'A'] == 1) cur++;
                else if(maps[s[j]-'A'] == 2) cur = prev-1;
                else cur = prev;
                num += cur;
                prev = cur;
            }
        }
        return num % 1000000007;
    }
};
```

#### 再深入研究一下

两个以上的重复字符就没有作用了，这是一个关键点

```c++
class Solution {
public:
    int uniqueLetterString(string s) {
        
        map<int,vector<int>> maps;
        for(int i =0;i<s.size();i++){
            maps[s[i]-'A'].push_back(i);
        }
        int ans = 0,prev,next;
        for(auto &p:maps){
            for(int j=0;j<p.second.size();j++){
                prev = j==0?-1:p.second[j-1];
                next = j== p.second.size()-1?s.size():p.second[j+1];
                ans += (p.second[j]-prev)*(next - p.second[j]);
            }
        }
        return ans%1000000007;
    }
};
```



来源：力扣（LeetCode）
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。


