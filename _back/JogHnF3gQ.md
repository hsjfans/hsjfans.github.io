---
title: '820. 单词的压缩编码'
date: 2020-03-28 10:51:23
tags: []
published: true
hideInList: false
feature: 
isTop: false
---
给定一个单词列表，我们将这个列表编码成一个索引字符串 S 与一个索引列表 A。

例如，如果这个列表是 ["time", "me", "bell"]，我们就可以将其表示为 S = "time#bell#" 和 indexes = [0, 2, 5]。

对于每一个索引，我们可以通过从字符串 S 中索引的位置开始读取字符串，直到 "#" 结束，来恢复我们之前的单词列表。

那么成功对给定单词列表进行编码的最小字符串长度是多少呢？


## 示例：
```
输入: words = ["time", "me", "bell"]
输出: 10
说明: S = "time#bell#" ， indexes = [0, 2, 5] 。
```

提示：

1. 1 <= words.length <= 2000
2. 1 <= words[i].length <= 7
3. 每个单词都是小写字母 。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/short-encoding-of-words
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。


## Solution

采用字典树，字符串反向存储

```
       root
     /      \
  e           L
  |            |
 m           L
  |            |
  i           e
  |            |
  t           b

```



## Code
```c++
class Node{
   public:
   char c;
   map<char,Node> next;
   int index;
   bool leaf;
   Node(char c){this->c = c;};
   Node(){};
};

class Solution {
public:
        
    // 插入
    void insert(Node *root,string word){
        int len = word.size();
        Node *p = root;
        int index = 0;
        for(int i = len-1;i>=0;i--){
            if(p->next.count(word[i]) == 0){
                Node node = Node(word[i]);
                node.index = len - i;
                p->next[word[i]] = node;
            }
            p->leaf = false;
            p = &(p->next[word[i]]);
        }
        if(p->next.size() == 0 )  p->leaf = true;
    }
   

     // 层序遍历
    int getSum(Node *root){
        int sum = 0;
        queue<Node *> q;
        q.push(root);
        while(!q.empty()){
            Node *node = q.front();
            if(node->leaf){
                sum += (node->index+1);
            }
            q.pop();
            for(auto &it:node->next){
                q.push(&(it.second));
            }
        }
        return sum;
    }

    int minimumLengthEncoding(vector<string>& words) {
        if(words.size()==1) return words[0].size()+1;
        Node *root = new Node();
        int res = 0;
        for(int i=0;i<words.size();i++){
            insert(root,words[i]);
        }
        return getSum(root);
    }
};

```