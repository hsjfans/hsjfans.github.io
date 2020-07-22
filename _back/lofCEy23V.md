---
title: '1092 To Buy or Not to Buy (20分)'
date: 2020-05-02 08:58:38
tags: []
published: true
hideInList: false
feature: https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200502085856.png
isTop: false
---
Eva would like to make a string of beads with her favorite colors so she went to a small shop to buy some beads. There were many colorful strings of beads. However the owner of the shop would only sell the strings in whole pieces. Hence Eva must check whether a string in the shop contains all the beads she needs. She now comes to you for help: if the answer is Yes, please tell her the number of extra beads she has to buy; or if the answer is No, please tell her the number of beads missing from the string.

For the sake of simplicity, let's use the characters in the ranges [0-9], [a-z], and [A-Z] to represent the colors. For example, the 3rd string in Figure 1 is the one that Eva would like to make. Then the 1st string is okay since it contains all the necessary beads with 8 extra ones; yet the 2nd one is not since there is no black bead and one less red bead.

![figbuy.jpg](https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200502085856.png)

Figure 1

## Input Specification:
Each input file contains one test case. Each case gives in two lines the strings of no more than 1000 beads which belong to the shop owner and Eva, respectively.

## Output Specification:
For each test case, print your answer in one line. If the answer is Yes, then also output the number of extra beads Eva has to buy; or if the answer is No, then also output the number of beads missing from the string. There must be exactly 1 space between the answer and the number.

## Sample Input 1:
```
ppRYYGrrYBR2258
YrR8RrY
```
      
    
## Sample Output 1:
```
Yes 8
```
      
    
## Sample Input 2:
```
ppRYYGrrYB225
YrR8RrY
```
      
    
## Sample Output 2:
```
No 2
```


## Solution

题目比较简单，只要分别统计各字符的数量，然后判断是否符合需求即可。


## Code

```c++
#include <iostream>
#include <map>

using namespace std;

map<char,int> getCount(string s1){
  map<char,int> count;
  for(char c : s1){
    count[c]++;
  }
  return count;
}

void pat_1092(){
  string s1,s2;
  cin >> s1 >> s2;
  
  map<char,int> count1 = getCount(s1);
  map<char,int> count2 = getCount(s2);
  
  int res = 0;
  
  for(auto &p : count2){
      if(count1[p.first] < p.second){
        res += (p.second - count1[p.first]);
      }
  }
  
  if(res > 0) printf("No %d\n",res);
  else printf("Yes %d\n",(int)(s1.size() - s2.size()));;
  
}

int main(){
  pat_1092();
  return 0;
}

```