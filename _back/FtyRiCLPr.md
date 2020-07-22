---
title: '1040 Longest Symmetric String (25分)'
date: 2020-03-10 13:36:30
tags: [pat,algorithm]
published: true
hideInList: false
feature: https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200310122256.png
isTop: false
---
Given a string, you are supposed to output the length of the longest symmetric sub-string. For example, given Is PAT&TAP symmetric?, the longest symmetric sub-string is s PAT&TAP s, hence you must output 11.

## Input Specification:
Each input file contains one test case which gives a non-empty string of length no more than 1000.

## Output Specification:
For each test case, simply print the maximum length in a line.

## Sample
### Input:
``` Is PAT&TAP symmetric? ```

      
    
### Output:
``` 11 ```

## Solution

假设回文串在 `i`,`j` 之间，所有的 `i`,`j` 组合有 $C_2^n$，其中大约有一半的重复( i>j 与 i < j)。因此第一种可以考虑暴力求解法，穷举所有的组合，然后判断是非为回文字符串即可，此时的时间复杂度为 $O(N^3)$ 。

然后，进一步分析会发现，其实存在很多重复的子问题，如 对于下标为`i`,`j`的字符串它依赖于`i+1`,`j-1`。因此符合动态规划的思想，即从底向上并且对子问题进行记录。它的规划式为

$$ LSS(i,j) = LSS(i+1,j-1) \And (A[i] == A[j]); $$

这里有一个问题点，计算 `LSS(i,j)` 要用到 `LSS(i+1,j-1) `，因此计算时不能采用 i,j 这样遍历，而是以 j-i 的长度为依据进行遍历，先计算为`1`,`2`的情况，在计算其它情况。
 
## Code

### 暴力
```c++
#include<iostream>
#include<cmath>
using namespace std;

bool isSymmetric(string str,int i,int j){
    while(i<j){
        if(str[i++]!=str[j--]) return false;
    }
    return true;
}

// 暴力求解 o(n^3)
void pat_1040(){
    
    string str;
    getline(cin,str);
    int i=0,l=str.size()-1,j=l,res = 0;
    for(;i<=l;i++){
        for(j=i;j<=l;j++){
            if(isSymmetric(str,i,j)){
                res = max(res,j-i+1);
            }
        }
    }
    cout << res;
}

int main(){
    pat_1040();
    return 0;
}
```

### 动态规划
```c++
#include<iostream>
#include<cmath>
using namespace std;


void pat_1040(){
    
    string str;
    getline(cin,str);
    int i=0,l=str.size()-1,j=l,res = 1;
    bool is[l+1][l+1];
    fill(is[0],is[0]+(l+1)*(l+1),false);
    // 标记 长度为1 和 2
    for(i=0;i<=l;i++){
        is[i][i] = true;
        if(i+1<=l && str[i+1] == str[i]){
            is[i][i+1] = true;
            res = 2;
        }
    }
    j = 3 ;
    while(j<=l+1){
        for(i=0;i + j -1<=l;i++){
            int k = i+j-1;
            if(str[i] == str[k] && is[i+1][k-1] ){
                res = j;
                is[i][k] = true;
            }
        }
        j++;
    }

    cout << res;

}

int main(){
    pat_1040();
    return 0;
}

```