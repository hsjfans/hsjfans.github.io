---
title: '206. 反转链表'
date: 2020-03-25 14:55:51
tags: [leetcode,一刷leetcode]
published: true
hideInList: false
feature: 
isTop: false
---
反转一个单链表。

示例:
```
输入: 1->2->3->4->5->NULL
输出: 5->4->3->2->1->NULL
```

## Solution

双指针

## Code
```c++
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    ListNode* reverseList(ListNode* head) {
        ListNode *p1 = NULL, *p2 = head;
        ListNode *p;
        while(p2){
            p = p2->next;
            p2->next = p1;
            p1 = p2;
            p2 = p;
        }
        return p1;
    }
};
```