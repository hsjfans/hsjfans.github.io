---
title: '679. 24 点游戏'
date: 2020-03-24 17:15:30
tags: [leetcode,algorithm]
published: true
hideInList: false
feature: 
isTop: false
---
你有 4 张写有 1 到 9 数字的牌。你需要判断是否能通过 *，/，+，-，(，) 的运算得到 24。

示例 1:
```
输入: [4, 1, 8, 7]
输出: True
解释: (8-4) * (7-1) = 24
```
示例 2:
```
输入: [1, 2, 1, 2]
输出: False
```
注意:

除法运算符 / 表示实数除法，而不是整数除法。例如 4 / (1 - 2/3) = 12 。
每个运算符对两个数进行运算。特别是我们不能用 - 作为一元运算符。例如，[1, 1, 1, 1] 作为输入时，表达式 -1 - 1 - 1 - 1 是不允许的。
你不能将数字连接在一起。例如，输入为 [1, 2, 1, 2] 时，不能写成 12 + 12 。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/24-game
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。


## Solution

穷举法，列出所有可能性，边进行边对比


## Code

```c++
class Solution {
public:

    bool solve(vector<double> nums) {
        if (nums.size() == 0) return false;
        if (nums.size() == 1) return abs(nums[0] - 24) < 1e-6;

        for (int i = 0; i < nums.size(); i++) {
            for (int j = 0; j < nums.size(); j++) {
                if (i != j) {
                    vector<double> nums2;
                    for (int k = 0; k < nums.size(); k++) if (k != i && k != j) {
                        nums2.push_back(nums[k]);
                    }
                    for (int k = 0; k < 4; k++) {
                        if (k < 2 && j > i) continue;
                        if (k == 0) nums2.push_back(nums[i] + nums[j]);
                        if (k == 1) nums2.push_back(nums[i] * nums[j]);
                        if (k == 2) nums2.push_back(nums[i] - nums[j]);
                        if (k == 3) {
                            if (nums[j] != 0) {
                                nums2.push_back(nums[i] / nums[j]);
                            } else {
                                continue;
                            }
                        }
                        if (solve(nums2)) return true;
                        nums2.erase(nums2.end()-1);
                    }
                }
            }
        }
        return false;
    }
    bool judgePoint24(vector<int>& nums) {
        vector<double> nums2;
        for(int i=0;i<nums.size();i++) nums2.push_back((double)nums[i]);
        return solve(nums2);
    }
};

```