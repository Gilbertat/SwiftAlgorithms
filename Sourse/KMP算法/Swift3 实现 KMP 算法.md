# Swift3 实现 KMP 算法

## 引出

什么是字符串匹配？
> 字符串匹配是计算机科学中最古老、研究最广泛的问题之一。字符串匹配问题就是在一个大的字符串 T 中搜索某个字符串 P 的所有出现位置。其中，T 称为文本，P 称为模式，T 和 P 都定义在同一个字母表上。

什么是 KMP 算法？
> KMP 算法是一种改进的字符串匹配算法，由 D.E.Knuth，J.H.Morris 和 V.R.Pratt 同时发现，因此人们称它为克努特--莫里斯--普拉特操作（简称 KMP 算法）。KMP 算法的关键是利用匹配失败后的信息，尽量减少模式串与主串的匹配次数以达到快速匹配的目的。

下面从暴力匹配算法讲起一步步分析 KMP 算法的流程步骤，并用最新的 Swift3 来实现 KMP 算法。

## 字符串匹配的暴力算法

我们要解决的问题是从一个文本串 T 中寻找模式串 P 的位置，看到此问题第一印象就是把模式串 P 中的字符依次与文本串 T 中的字符比对，直到 P 中的所有字符都与 T 中某一段字符匹配成功，则成功找到了 P 在 T 中位置。

采用此思路，假如文本串 T 匹配到 i 位置，模式串 P 匹配到 j 位置，则

- 如果 `T[i] == P[j]` 则匹配成功,然后 `i++, j++`继续匹配下一个字符
- 如果 `T[i] != P[j]` 则匹配失败，此时 文本串 T 的标记 `i` 要回退到此次比对最开始的位置然后加1，模式串 P 的标记 `j` 要置0，开始下一次对子串的比对。即 `i = i - j + 1 , j = 0`。

暴力匹配算法的 Swift3 实现

```swift
/**
 字符串匹配的暴力算法
 - parameter TextStr:    原始的文本字符串,主串
 - parameter patternStr: 要匹配的模式字符串，模式串
 
 - returns: 正确匹配返回模式串的位置，匹配错误返回 -1
 */
func violenceMatch(TextStr: String, patternStr: String) -> Int {
    var indexI = TextStr.startIndex
    var indexJ = patternStr.startIndex
    
    while (indexI < TextStr.endIndex && indexJ < patternStr.endIndex) {
        if TextStr[indexI] == patternStr[indexJ] {
            if indexJ == patternStr.index(before: patternStr.endIndex) {
                // 如果匹配到最后一个字符，则匹配成功，返回当前的indexI - indexJ 的位置
                return TextStr.distance(from: indexJ, to: indexI)
            }
            //如果当前字符串匹配成功，则同时向后移动一位
            indexI = TextStr.index(indexI, offsetBy: 1)
            indexJ = patternStr.index(indexJ, offsetBy: 1)
        }else {
            //如果匹配失败，则 TextStr 要回退到上次匹配开始的位置，同时 patternStr 的 index 置0
            let distance = TextStr.distance(from: indexJ, to: indexI) + 1
            indexI = TextStr.index(patternStr.startIndex, offsetBy: distance)
            indexJ = patternStr.startIndex
        }
        
    }
    return -1
}
```

举例说明，给定文本串 T 为 `BBCEABCDABEABCDABCDABDE`和模式串 P 为 `ABCDABD`，匹配 T 中是否含有 P 以及确定 P 的位置。暴力匹配的流程如下图所示。

1. 当匹配成功时，如 `T[4] == P[0]`,然后`i++, j++`继续匹配下一个字符;
![fig01](http://oaej5i484.bkt.clouddn.com/Snip20160920_1.png)
2. 当匹配失败时，如 `T[10] != P[6]`,此时`i` 要回退到此次比对最开始的位置然后加 1 即 `i = i - j + 1`，`j` 要置0
![fig02](http://oaej5i484.bkt.clouddn.com/Snip20160920_3.png)
![fig03](http://oaej5i484.bkt.clouddn.com/Snip20160920_4.png)
3. 开始下一次匹配，不断循环。


当 `T[10]` 与 `P[6]` 匹配失配后，需要回退到 `T[5]` 与 `P[0]` 重新开始新一轮的子串匹配。可以发现，此时必然匹配失败。Why？仔细观察，由下图可以看出对于匹配成功的那一段字符串 `ABCDAB`,回退相当于将 P 依次向右移动，两个对齐的字符串慢慢错开，此时必然导致匹配失败。暴力匹配算法没有利用到这一有效的信息，导致对于大量的数据尤其当最后才能匹配成功时的处理效率低下。而 KMP 算法正是利用了之前匹配成功的信息来减少循环匹配的次数，匹配失败时，不要回退文本串 T 的标记 `i`, 而是通过移动模式串 P 的标记 `j` 来重新开始下一次的匹配。
![fig04](http://oaej5i484.bkt.clouddn.com/Snip20160920_5.png)

## KMP 算法

### KMP 算法流程

由上面的分析，我们发现问题的关键在于什么时候开始下一轮的匹配即模式串要移动到什么位置，也就是 `j` 从哪个值开始下一轮匹配。同样从上图可以看出 `ABCDAB` 有相同的前缀和后缀 `AB`,当 P 的前缀与 T 的后缀对齐时，相当于开始了下一轮匹配且下一轮匹配已经成功匹配了两个字符，然后继续往下匹配，当匹配成功的字符串不存在相同的前缀后缀的时候，则完全移动 P 到匹配失败的位置开始下一轮的匹配。


从上面的分析我们发现，要利用前面的信息把模式串 P 移动到正确的位置来开始新一轮的匹配。移动的位数与匹配成功的字符串（即模式串的子串）有密切的联系，如果匹配成功的字符串中没有相同的前缀后缀，此时移动的位数等于匹配成功字符串的长度；而当匹配成功的字符串中有相同的前缀和后缀的时候，此时就要考虑相同前后缀的影响，此时移动的位数等于匹配成功的字符串的长度减去最大相同前后缀（有可能不止一组）。可以得出一个结论：
`匹配失败 P 向右移动的位数 = 已匹配成功的字符串长度 - 已匹配成功的字符串的最大前缀后缀公共长度`

由下图可以看出，当 `i = 10 j = 6` 的位置匹配失败时，已匹配成功的字符串 `ABCDAB`长度为6，已匹配成功的字符串的最大前缀后缀 `AB` 的长度为2,可以算出 P 向右移动的位数 `6 - 2 = 4`。
![fig05](http://oaej5i484.bkt.clouddn.com/Snip20160920_6.png)

为了利用前面匹配成功的信息而引入了一个函数，叫做失配函数，其实就是一个数组 `next[j]`,数组中保存的就是已匹配成功的字符串的最大前缀后缀的公共长度。

下面直接给出 KMP 算法的算法流程，假如文本串 T 匹配到 i 位置，模式串 P 匹配到 j 位置，则：

- 如果 `T[i] == P[j]` 则匹配成功,然后 `i++, j++`继续匹配下一个字符
- 如果 `T[i] != P[j]` 则匹配失败，此时不在回退 `i`，保持 `i` 不变，然后令 `j = next[j]`。意味着模式串 P 相对于文本串 T 向右移动了 `j - next[j]` 位
- 如此循环直到结束

`next[j]` 中各个数值表示当前字符之前的字符串中，有多大长度的相同的前缀后缀。可以看出，当匹配失败的时候，该字符对应的 `next[j]` 值会指示在下一轮的匹配中，模式串 P 应该移动到哪个位置，即向右移动 `j - next[j]` 位，也就是由 `j` 直接跳到 `next[j]` 对应的位置。如果 `next[j] = -1`,则直接跳到模式串 P 的开头。

字符串匹配的 KMP 算法用 Swift3 来实现如下：

```swift
/**
 字符串匹配的 KMP 算法
 - parameter TextStr:    原始的文本字符串,主串
 - parameter patternStr: 要匹配的模式字符串，模式串
 
 - returns: 正确匹配返回模式串的位置，匹配错误返回 -1
 */
func KMPMatch(TextStr: String, patternStr: String) -> Int {
    var indexI = TextStr.startIndex
    var indexJ = patternStr.startIndex
    var j = 0
    let next = getNext(patternStr: patternStr)
    
    while (indexI < TextStr.endIndex && indexJ < patternStr.endIndex) {
        if j == -1 || TextStr[indexI] == patternStr[indexJ] {
            j += 1
            if indexJ == patternStr.index(before: patternStr.endIndex) {
                // 如果匹配到最后一个字符，则匹配成功，返回当前的indexI - indexJ 的位置
                return TextStr.distance(from: indexJ, to: indexI)
            }
            //如果当前字符串匹配成功，则同时向后移动一位
            indexI = TextStr.index(indexI, offsetBy: 1)
            indexJ = patternStr.index(indexJ, offsetBy: 1)
        }else {
            //如果匹配失败，则 TextStr 的 indexI 保持不变，同时 patternStr 的 indexJ 跳到 next[j] 的位置
            //如果next[j] = -1 ,直接跳到 P 的开头
            let distance = TextStr.distance(from: patternStr.startIndex, to: indexJ)
            j = next[distance]
            if j == -1 {
                indexJ = patternStr.startIndex
            } else {
              indexJ = patternStr.index(patternStr.startIndex, offsetBy: j)
            }
        }
        
    }
    return -1
}
```

### 失配函数 next 的计算方法

#### 求解 next 数组的步骤

第1步：寻找前缀后缀的最长公共元素的长度

对于 P = p0 p1 ... pj-1 pj，寻找模式串P中长度最大且相等的前缀和后缀。如果存在 p0 p1 ... pk-1 pk = pj- k pj-k+1 ... pj-1 pj，那么在包含pj的模式串中有最大长度为k+1的相同前缀后缀。

![](http://oaej5i484.bkt.clouddn.com/Snip20160920_7.png)

第2步：求出 next 数组

根据上面的分析，next 数组中每个值对应的是除当前字符以外的其他字符串的最长的相同的前缀后缀，为了后续的计算方便，将第一步的求得值整体右移一位，然后将数组的第一个数赋值为 -1，这样就得到了 next 数组。

![](http://oaej5i484.bkt.clouddn.com/Snip20160920_8.png)

比如对于字符串 `abab`,第 4 个字符串之前的字符串 `aba` 中有长度为 1 的相同前缀后缀 `a`，所以 `b` 对应的 next 的值为 1。

#### 如何用程序求解 next 数组

根据上面的步骤，我们可以采用穷举的方法来计算 next 数组，即把字符串每个子串的所有的前缀后缀列出来，然后找到最长的公共元素长度，将这个数组整体右移一位然后第一个数置为 -1，就得到 next 数组，但是如何通过程序来得到 next 数组呢？

1. 如果对于值 k，已知有 p0 p1, ..., pk-1 = pj-k pj-k+1, ..., pj-1，相当于next[j] = k，若已知 next[0]、next[1] ... next[j],如何求出 next[j+1]呢？
2. 此时分两种情况：
	- 当 `p[k] == p[j]` 时候，可以看出 `next[j+1] = next[j] + 1 = k + 1` 

	![](http://oaej5i484.bkt.clouddn.com/Snip20160920_9.png)
	
	- 当 `p[k] != p[j]` 时候，如果 `p[next[k]] == p[j]`，则 `next[j] = next[k] + 1`，否则继续递归前缀索引 `k = next[k]`,重复此过程。相当于如果 `p[j+1]` 之前不存在长度为 k+1 的前缀满足条件，那么是否存在一个长度更小的前缀 p0 p1, …, pt-1 pt” 等于长度更小的后缀 “pj-t pj-t+1, …, pj-1 pj” ,相当于利用已知的 next 数组来进行 P 串前缀和后缀的匹配。

	![](http://oaej5i484.bkt.clouddn.com/Snip20160920_10.png)
	
此处重点说明**为何循环递归前缀的索引 `k = next[k]`，就能找到长度更短的相同的前缀后缀？**当计算 next 数组的值时候，其实也是在进行主串和模式串的匹配过程，只不过此时主串和模式串分别是前缀和后缀的字符串。当前缀 `p0 pk-1 pk ` 去匹配后缀 `后缀pj-k pj-1 pj`，如果 `p[k] != p[j]`,根据 KMP 算法的思想，下一步要移动前缀（也就是 KMP 算法中的 P 串）的位置，即令 `j = next[k]`，也就是用 `p[next[k]]` 去跟 pj 匹配，如果仍然不相等，则继续移动前缀的位置 `p[next[next[k]]]`，直到找到长度更短的相同的前缀后缀。如图所示：

  ![](http://oaej5i484.bkt.clouddn.com/Snip20160920_11.png)

根据上面的求解步骤给出计算 next 数组的两种方法：

**直接递归的方法**

```swift
func recurGetNext(patternStr: String, count: Int) -> [Int] {
    var next = [Int]()
    if count == 1 {
        return [-1]
    }//注意 count 是字符串的长度不是下标
    next = recurGetNext(patternStr: patternStr, count: count - 1)
    var k: Int = next[count - 2] //注意长度是 count-1 ，则最后一个字符的下标是 count-2
    while k != -1 {
        if patternStr[patternStr.index(patternStr.startIndex, offsetBy: count - 2)] == patternStr[patternStr.index(patternStr.startIndex, offsetBy: k)] {
            break
        }
        k = next[k]
    }
    next.append(k+1)
    return next
}
```

**递归展开的计算方法**

```swift
func getNext(patternStr: String) -> [Int] {
    let count = patternStr.characters.count
    var k = -1
    var next = Array(repeating: -1, count: count)
    for var j in stride(from: 0, to: count - 1, by: 1) {
        while (k != -1 && patternStr[patternStr.index(patternStr.startIndex, offsetBy: j)] != patternStr[patternStr.index(patternStr.startIndex, offsetBy: k)]) {
            k = next[k]
        }
        k += 1
        j += 1
        next[j] = k
    }
    return next
}
```


### 求解 next 数组的进一步优化

上面将 KMP 算法流程以及 next 数组的求解步骤梳理了一遍，基本可以解决字符串匹配的问题。从暴力匹配算法过渡到 KMP 算法，我们利用了已经匹配的信息进行了算法的优化，那么求解 next 数组是否存在类似的一种优化呢？答案是肯定的，在利用 next 数组的过程中，也存在一种类似的必然匹配失败的情况。看图：

![](http://oaej5i484.bkt.clouddn.com/Snip20160920_12.png)

当 `T[3] != P[3]` 匹配失败后，根据 `next[3] = 1`，可以得到下一轮匹配开始时 `j = 1`，此时因为 `P[1] = P[3] = P[next[3]]` 所以必然匹配失败即 `T[3] != P[1]`。因为 `P[j] = P[next[j]]` 的存在，导致了必然匹配失败的情况，根据这一先验信息，如果出现了 `P[j] = P[next[j]]`,需要再次递归，令 `next[j] = next[next[j]]`。

改进的求解 next 数组的 Swift3 实现如下：

```swift
func getNextOpt(patternStr: String) -> [Int] {
    let count = patternStr.characters.count
    var k = -1
    var next = Array(repeating: -1, count: count)
    for var j in stride(from: 0, to: count - 1, by: 1) {
        while (k != -1 && patternStr[patternStr.index(patternStr.startIndex, offsetBy: j)] != patternStr[patternStr.index(patternStr.startIndex, offsetBy: k)]) {
            k = next[k]
        }
        k += 1
        j += 1
        if patternStr[patternStr.index(patternStr.startIndex, offsetBy: j)] != patternStr[patternStr.index(patternStr.startIndex, offsetBy: k)] {
            next[j] = k
        } else {
            next[j] = next[k]
        }
    }
    return next
}

```








