---
title: '1306. 跳跃游戏 III'
date: 2020-04-04 18:12:47
tags: []
published: true
hideInList: false
feature: 
isTop: false
---
这里有一个非负整数数组 arr，你最开始位于该数组的起始下标 start 处。当你位于下标 i 处时，你可以跳到 i + arr[i] 或者 i - arr[i]。

请你判断自己是否能够跳到对应元素值为 0 的 任意 下标处。

注意，不管是什么情况下，你都无法跳到数组之外。

 

## 示例 1：
```
输入：arr = [4,2,3,0,3,1,2], start = 5
输出：true
解释：
到达值为 0 的下标 3 有以下可能方案： 
下标 5 -> 下标 4 -> 下标 1 -> 下标 3 
下标 5 -> 下标 6 -> 下标 4 -> 下标 1 -> 下标 3 
```
## 示例 2：
```
输入：arr = [4,2,3,0,3,1,2], start = 0
输出：true 
解释：
到达值为 0 的下标 3 有以下可能方案： 
下标 0 -> 下标 4 -> 下标 1 -> 下标 3
```
## 示例 3：
```
输入：arr = [3,0,2,1,2], start = 2
输出：false
解释：无法到达值为 0 的下标 1 处。 
```

## 提示：

1. 1 <= arr.length <= 5 * 10^4
2. 0 <= arr[i] < arr.length
3. 0 <= start < arr.length

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/jump-game-iii
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

## Solution

BFS

## Code

```c++

class Solution {
public:

    bool canReach(vector<int>& arr, int start) {

        int n = arr.size(), visited[n];
        fill(visited,visited+n,0);
        queue<int> q;
        q.push(start);
        visited[start] = 1;
        int t,left,right;
        while(!q.empty()){
            t = q.front();
            q.pop();
            if(arr[t] == 0) return true;
            left = t+arr[t];
            right = t-arr[t];
            if(left >=0 && left < n && !visited[left]){
                q.push(left);
                visited[left] = 1;
            }
            if(right >=0 && right < n && !visited[right]){
                q.push(right);
                visited[right] = 1;
            }
        }
        return false;
    }
};
```