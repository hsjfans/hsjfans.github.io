---
title: '51. N皇后'
date: 2020-05-08 13:40:40
tags: [一刷leetcode,algorithm]
published: true
hideInList: false
feature: https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/10/12/8-queens.png
isTop: false
---
n 皇后问题研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能相互攻击。


![](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/10/12/8-queens.png)

上图为 8 皇后问题的一种解法。

给定一个整数 n，返回所有不同的 n 皇后问题的解决方案。

每一种解法包含一个明确的 n 皇后问题的棋子放置方案，该方案中 'Q' 和 '.' 分别代表了皇后和空位。

## 示例:

输入: 4
```
输出: [
 [".Q..",  // 解法 1
  "...Q",
  "Q...",
  "..Q."],

 ["..Q.",  // 解法 2
  "Q...",
  "...Q",
  ".Q.."]
]
```
解释: 4 皇后问题存在两个不同的解法。
 

提示：

皇后，是国际象棋中的棋子，意味着国王的妻子。皇后只做一件事，那就是“吃子”。当她遇见可以吃的棋子时，就迅速冲上去吃掉棋子。当然，她横、竖、斜都可走一或七步，可进可退。（引用自 百度百科 - 皇后 ）

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/n-queens
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。


## Solution

暴力枚举，首先 对于 n*n 的 n 皇后问题，肯定不会出现同一列和同一行存在两个棋子的机会，因此 每个棋子肯定为独占一行或者一列。可以一行一行的进行填充，知道不会出现冲突，其时间复杂度为 O(n!)

```c++

class Solution {
public:

   vector<vector<string>> ans;
   
    void traceback(vector<string> &checked,int x,int n){
        if( x == n ) {
            ans.push_back(checked);
            return;
        }
        for(int i=0;i<n;i++){
            if(!check(checked,n,x,i)){
                continue;
            }
            checked[x][i]  = 'Q';
            traceback(checked,x+1,n);
            checked[x][i] = '.';
        }
    }

    bool check(vector<string> &checked,int n,int x, int y){
        // 核查其作用域上是否有棋子，有的话就返回false
        for(int i=0;i<n;i++){
            // 纵向
           if(checked[i][y] == 'Q') return false;
        }
        // 斜线 、、、
        for(int i=x-1,j=y-1;i>=0 && j >=0;i--,j--){
            if(checked[i][j] == 'Q') return false;
        }
        // 斜线 、、、
        for(int i=x-1,j=y+1;i>=0 && j < n;i--,j++){
            if(checked[i][j] == 'Q') return false;
        }
        return true;
    }

    vector<vector<string>> solveNQueens(int n) {
        
        // -1空 0 代表不能放置 1 代表已经放置的
        vector<string> checked(n,string(n,'.'));
        traceback(checked,0,n);
        return ans;
    }
};
```