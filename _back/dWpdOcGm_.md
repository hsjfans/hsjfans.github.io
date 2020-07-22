---
title: '208. 实现 Trie (前缀树)'
date: 2020-03-24 09:39:18
tags: [leetcode,datastructure,tree,algorithm]
published: true
hideInList: false
feature: 
isTop: false
---
实现一个 `Trie` (前缀树)，包含 `insert`,` search`, 和 `startsWith` 这三个操作。

示例:
```
Trie trie = new Trie();

trie.insert("apple");
trie.search("apple");   // 返回 true
trie.search("app");     // 返回 false
trie.startsWith("app"); // 返回 true
trie.insert("app");   
trie.search("app");     // 返回 true
```
说明:

你可以假设所有的输入都是由小写字母 `a-z `构成的。
保证所有输入均为非空字符串。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/implement-trie-prefix-tree
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

## Code

```c++
class Node
{
public:
    char c;
    map<char, Node> next;
    int end;
    Node(char c)
    {
        this->c = c;
        this->end = 0;
    }
    Node(){};
};

class Trie
{
public:
    Node root;

    /** Initialize your data structure here. */
    Trie()
    {
        root = Node();
    }

    /** Inserts a word into the trie. */
    void insert(string word)
    {
        Node *p = &root;
        for(char c:word){
            if(p->next.find(c) == p->next.end()){
                p->next[c] = Node(c);
            }
            p = &(p->next[c]);
        }
        p->end = 1;
    }

    /** Returns if the word is in the trie. */
    bool search(string word)
    {
        Node *p = &root;
        for(char c:word){
            if(p->next.find(c) == p->next.end()) return false;
            p = &(p->next[c]);
        }
        return p->end == 1;
    }

    /** Returns if there is any word in the trie that starts with the given prefix. */
    bool startsWith(string prefix)
    {
        Node *p = &root;
        for(char c:prefix){
             if(p->next.find(c) == p->next.end()) return false;
             p = &(p->next[c]);
        }
        return true;
    }
};
/**
 * Your Trie object will be instantiated and called as such:
 * Trie* obj = new Trie();
 * obj->insert(word);
 * bool param_2 = obj->search(word);
 * bool param_3 = obj->startsWith(prefix);
 */
```