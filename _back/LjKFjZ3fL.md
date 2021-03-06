---
title: '677. 键值映射'
date: 2020-05-07 10:10:35
tags: [一刷leetcode,dfs,datastructure,tree,algorithm]
published: true
hideInList: false
feature: 
isTop: false
---
实现一个 MapSum 类里的两个方法，insert 和 sum。

对于方法 insert，你将得到一对（字符串，整数）的键值对。字符串表示键，整数表示值。如果键已经存在，那么原来的键值对将被替代成新的键值对。

对于方法 sum，你将得到一个表示前缀的字符串，你需要返回所有以该前缀开头的键的值的总和。

## 示例 1:
```
输入: insert("apple", 3), 输出: Null
输入: sum("ap"), 输出: 3
输入: insert("app", 2), 输出: Null
输入: sum("ap"), 输出: 5
```
来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/map-sum-pairs
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。


## Solution

字典树结构

```c++
//字典树节点
class Node{

    public:
       char data;
       int val;
       bool leaf;
       map<char,Node> next;

       Node(char c){
           data = c;
           leaf = false;
       }

       Node(){};

};

class MapSum {
public:
    
    Node root;

    /** Initialize your data structure here. */
    MapSum() {
        root = Node();
    }
    
    void insert(string key, int val) {
        Node *trie = &root;
        int i =0,n = key.size();
        char c;
        while(i < n){
            c = key[i];
            if(!trie->next.count(c)){
                trie->next[c] = Node(c);
            }
            trie = &trie->next[c];
            i++;
        }
        trie->val = val;
        trie->leaf = true;
    }
   
    // 递归求和
    int trave(Node *trie){
        int ans = 0;
        if(trie->leaf) {ans += trie->val;}
        for(auto &p:trie->next){
            Node *t = &(p.second);
            ans += trave(t);
        } 
        return ans;
    }
    
    int sum(string prefix) {
        Node *trie = &root;
        int ans = 0;
        int i =0, n = prefix.size();
        char c;
        while( i < n){
            c = prefix[i];
            if(!trie->next.count(c)) return 0;
            trie = &trie->next[c];
            i++;
        }
        return trave(trie);
        
    }
};

/**
 * Your MapSum object will be instantiated and called as such:
 * MapSum* obj = new MapSum();
 * obj->insert(key,val);
 * int param_2 = obj->sum(prefix);
 */
```
