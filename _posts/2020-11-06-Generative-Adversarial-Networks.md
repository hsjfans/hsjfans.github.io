# Generative Adversarial Networks

[GAN](https://arxiv.org/abs/1406.2661) 是Ian J. Goodfellow 2014年提出的一个新的生成模型。

## 3. Theory Behind GAN

> 以图像为例, x代表图片

$P_{data}(x)$ 代表实际的图形分布函数。$P_G(x;\theta)$ 代表用来拟合$P_{data}(x)$的一个分布函数,$\theta$代表对应的参数。例如，$P_G(x;\theta)$可以选择采用`GMM`(高斯混合分布),此时$\theta$就是$(\mu,\Sigma)$。通过调节$\theta$来使得$P_G{x;\theta}$尽可能的接近$P_{data}(x)$。
如何评估两种分布函数之间的相似程度呢？这里可以采用某种散度或者最大似然概率（MLE）来量化。

### 3.1  MLE Or KL-Divergence

首先，从$P_{data}(x,\theta)$内`Samples`出`m`个样本，其概率为 $P_G(x^i;\theta)$, 最大其似然概率，即：
 
$$
 \begin{align}
  L &= \prod_{i=1}^m P_G(x^i;\theta) \\
 \end{align}
$$

故，$\theta^\star = \arg\max_{\theta}L(\theta)$, 它等价于最小化
$KL(P_{data}||P_G)$

证明：

$$
  \begin{align}
  \theta^\star &= \arg\max_{\theta}L(\theta) \\
            &= \arg\max_{\theta} \int_i^m P_G(x^i;\theta) \\
            &= \arg\max_{\theta} \sum_i^m logP_G(x^i;\theta)\\
            &= \arg\max_{\theta} E_{x\sim{data}}log \frac{P_G(x;\theta)*P_{data}(x)}{P_{data}(x)} \\
            &= \arg\max_{\theta} \int_x P_{data}(x)log\frac{P_G(x;\theta)}{P_{data}(x)}dx + \int_x P_{data}(x)log P_{data}(x)dx\\
            &= \arg\max_{\theta} -KL(P_{data}||P_G(x)) \\
            &= \arg\min_{\theta} KL(P_{data}||P_G)
  \end{align}
$$

即对于生成器G，其最优 $G^\star = \arg\min Div(P_{data}||P_G)$,
由于 $P_G(x;\theta)$是未知的,因此无法直接计算 $P_{data},P_G$之间的散度。我们引入一个判别器 Discriminator，来间接的计算 $P_{data},P_G$之间的某种散度。


### 3.2 Discriminator

D 是一个分类器，它对于输入的图片来自于$P_{data}$的倾向于大高分1, 而对于由 G 生成的图片（$P_G$）打低分0。因此它的损失函数为：

$$
  \begin{align} 
   L(D) = &E_{x\sim{P_{data}}}[logD(x)] + E_{x\sim{P_{G}}}[log 1- D(x)] \\
  \end{align}
$$

对于给定的x,此时G是固定的，则要使L(D)最大，即使 $l = P_{data}(x) logD(x) +P_G(x)log(1−D(x))$最大。

令 $a = P_{data}$, $b = P_G(x)$, $D = D(x)$。 对 D求偏导数可得：

$$
\begin{align}
 \frac{dl}{dD} &= \frac{a}{D} + \frac{-b}{1-D} = 0\tag{1} \\
 D &= \frac{a}{a+b} \tag{2}\label{2} \\
\end{align}
$$

将\ref{2}带入到 L(D) 中，可得：

$$
 \begin{align}
 \max L(D) &= E_{x\sim{P_{data}}}[logD(x)] + E_{x\sim{P_{G}}}[log 1- D(x)] \\
        &= E_{x\sim{P_{data}}}[log(\frac{P_{data}}{P_{data} + P_G})] + E_{x\sim{P_{G}}}[log(\frac{P_G}{P_{data} + P_G})]\\ 
        &= E_{x\sim{P_{data}}}[log(\frac{P_{data}/2}{(P_{data} + P_G)/2})] + E_{x\sim{P_{G}}}[log(\frac{P_G/2}{(P_{data} + P_G)/2})] \\
        &= -2log2 + E_{x\sim{P_{data}}}[log(\frac{P_{data}}{(P_{data} + P_G)/2})] + E_{x\sim{P_{G}}}[log(\frac{P_G}{(P_{data} + P_G)/2})] \\
        &= -2log2 + JSD(P_{data}||P_G) \\    
\end{align}
$$

故$\max L(D)$，等同于 
$JSD(P_{data}||P_G)$

因此，$G^\star = \arg \min \max_{D} L(D)$, $D^\star = \arg\max_{D}L(D)$
