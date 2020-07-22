---
title: ' Theory behind GAN'
date: 2020-06-15 12:56:39
tags: [machine-learning,gan,李宏毅,deep-learning]
published: true
hideInList: false
feature: https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200707095609.gif
isTop: false
---

## Generation

Target: find data distribution $P_{data}(x)$.
*x 是一个图片 ( a high-dimensional vector)*

### Before GAN

**Target**：使用一个分布 $P_G(x,\theta)$ 去拟合分布$P_{data}(x)$（固定的），使两者越接近越好. 例如$P_G(x,\theta)$可以是 `gaussian mixture model`,此时 $\theta$为 `means` and `variances` of this model

- Given a data distribution $P_{data}(x)$ (We can sample from it)
    > $P_{data}(x)$ 未知，但是可以 sample from it. (就是从已有的`database`中`sample`出来一些)
- We have a data distribution $P_G(x;\theta)$ parameterized by $\theta$
    > We want to find $\theta$ such that $P_G$ close to $P_{data}$
- Sample {$x^1,x^2...,x^m$} from $P_{data}(x)$ and compute $P_G(x^i;\theta)$
- Find $\theta^*$ maximizing the Object Function

**Object Function**：`Maximum Likelihood Estimation` (最大似然估计)

$$
\begin{aligned}
F(\theta) &= \prod_{x=1}^{m} P_G(x^i;\theta)\tag{1} 
\end{aligned}
$$


要使 $F(\theta)$ 达到最大，即求 $\theta^*$ 使$F(\theta)$取得最值

$$\begin{aligned}
 \theta^* &= \arg\mathop{\max}\limits_{\theta}F(\theta) \tag{2} \\
          &= \arg\mathop{\max}\limits_{\theta}\sum_{x=1}^mlog(P_G(x^i;\theta)) \\
          &\approx \color{red}\arg\mathop{\max}\limits_{\theta}E_x\sim_{P_{data}(x)}(log(P_G(x;\theta)))\\
          &= \color{red}\arg\mathop{\max}\limits_{\theta} (\int_x P_{data}(x)log(P_G(x;\theta))dx - \int_x P_{data}(x)log(P_{data}(x))dx) \\
          &= \arg\mathop{\max}\limits_{\theta}\int_xP_{data}(x)log(P_G(x;\theta)/P_{data}(x))dx \\
          &= \arg\mathop{\min}\limits_{\theta} KL Div(P_{data}||P_G)

\end{aligned}$$



即： Maximum Likelihood Estimation $\approx$ KL Divergence

因此 对于 `Generator` 的目的就是 $G^* = \arg\mathop{\min}\limits_{G}Div(P_G,P_{data})$,即使 $P_G 和 P_{data}$ 之间的散度最小。


#### 这里存在一个问题: How to define general $P_G(x)$ ?
  对于 $P_G(x)$分布(更加 general distribution),它可能无法进行计算(如 `Nerual Network`),即 $logP_G(x;\theta)$无法计算.

## Using GAN


### GAN 是如何处理这个问题的呢？ (Generator)

GAN 采用了一个 `NN` 来拟合 $P_G(x)$，即 Generator 是一个 network, 使用它来定义分布 $P_G$

> To learn the generator's distribution $P_G$,we define a prior on input noise variables $P_z(z)$, then represent a mapping to data space as $G(z;\theta_g)$,where G is a differentiable function represented by a multilayer perceptron with parameters $\theta_g$.
> 

![](https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200615092048.png)

> prior distribution $P_z(z) 一般可以选取任意分布，如 Gussian Mixture Distribution$

根据上面可知，它的 Object Function (loss) 是某种 `Divergence`, 即 $Div(P_G,P_{data})$,
而且目的为是这种散度最小，即 $G^* = \arg\mathop{\min}\limits_G Div({P_G,P_{data}})$.
关键就是**如何计算这种 Divergence？**

### How to Compute Divergence (Discriminator) ?

对于 $P_G$或者$P_{data}$ 因为是未知的，我们无法计算，但是可以 Sample from them.

> We alse define a second multilayer perceptron $D(x;\theta_d)$ that outputs a single scalar. D(x) represents the probability that x came from the data rather that $P_g$. We train D to maximize the probability of assigning the correct label to both training examples and samples from G.


![](https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200615094212.png)

#### Object Function For D  
When train `D`, `G`is fixed:
   $$\begin{aligned}
     V(G,D) &= E_x \sim_{P_{data}(x)}[log(D(x))] + E_z \sim_{P_z(z)}[log(1-D(G(z)))]  \\
       & = E_x \sim_{P_{data}(x)}[log(D(x))] + E_x \sim_{P_G(x)}[log(1-D(x))]  \tag{3}
   \end{aligned}
   $$
  
即 

   $$D^* = \arg\mathop{\max}\limits_DV(D,G) \tag{4}$$

#### 式(3)如何解释呢？

1. 当 x 从 $P_data(x)$ sample 出来的时，那就使 `scalar`(D(x)) 越大越好（因为它是真实的）
2. 当 x 从 $P_G(x)$ sample 出来时，`saclar`(D(x))越小越好，即`1-D(x)` 越大越好（因为它是Generator出来的的）

上面我们讲到，generator的目的使 $P_G$ 和 $P_{data}$ 的某种 Divergence 越小越好,其实对于式(3)它就等同于某种 Divergence


#### 证明 V(G,D) 等同于 JS-Divergence


1. fixed G, 求解 $D^*$
  $$
    \begin{aligned}
    D^* &= \arg\mathop{\max}\limits_DV(D,G) \\
        &= \arg\mathop{\max}\limits_D[\int_xP_{data}(x)log(D(x))dx + \int_xP_G(x)log(1-D(x))dx ]\\
        &= \arg\mathop{\max}\limits_D\int_x[P_{data}(x)log(D(x)) + P_G(x)log(1-D(x))]dx \tag{5}
    \end{aligned}
  $$



2. Given x, $D^*$使 $P_{data}(x)log(D(x)) + P_G(x)log(1-D(x))$ maximum
   简化为 $L(D) = alogD + blog(1-D)$ 
   
   Assumed: $a = P_{data}(x)$ and  $b = P_G(x)$ 

   $$\begin{aligned}
      &L(D) = alogD + blog(1-D) \\
      &\frac{dL(D)}{dD} = a/D + b/(1-D)*(-1) = 0\\
      & D^* = a/(a+b) \tag{6}
     
   \end{aligned}$$

   > For any (a,b) $\in R^2$, function $y\to alog(y) + blog(1-y)$ achieves its maximum in [0,1] at $\frac{a}{a+b}$
  
3. 将 $D^* = a/(a+b)$ 带入到式（3）中，有:
   
   $$\begin{aligned}
     V(G,D) &= E_x \sim_{P_{data}(x)}[log(\frac{P_{data}(x)}{(P_{data}(x)+P_G(x))})] + E_x \sim_{P_G(x)}[log(\frac{P_G(x)}{(P_{data}(x)+P_G(x))})] \\
     &= \int_x[P_{data}(x)log(\frac{P_{data}(x)}{(P_{data}(x)+P_G(x))}) + P_G(x)log(\frac{P_G(x)}{(P_{data}(x)+P_G(x))})]dx \\
     &= \int_x[P_{data}(x)log(\frac{P_{data}(x)/2}{(P_{data}(x)+P_G(x))/2}) + P_G(x)log(\frac{P_G(x)/2}{(P_{data}(x)+P_G(x))/2})]dx \\
     &= -\int_x[P_{data}(x)log2 + P_G(x)log2]dx + \int_x[P_{data}(x)log(\frac{P_{data}(x)}{(P_{data}(x)+P_G(x))/2}) + P_G(x)log(\frac{P_G(x)}{(P_{data}(x)+P_G(x))/2})]dx \\
     &= -log4 + KLDiv(P_{data}(x)||(P_{data}(x)+P_G(x))/2) + KLDiv(P_G(x)||(P_{data}(x)+P_G(x))/2) \\
     &= -log4 + 2*\color{red}JSDiv(P_{data}||P_G)
   \end{aligned}$$

#### 计算 $G^* = \mathop{\arg\min}\limits_GDiv(P_{data},P_G)$

上式就等同于:
  $$\begin{aligned}
      G^* &= \arg\mathop{\min}\limits_GDiv(P_{data},P_G) \\
          &= \arg\mathop{\min}\limits_G\mathop{\max}\limits_DV(G,D) \\
          &= \arg\mathop{\min}\limits_GC(G)  
  \end{aligned}$$

  其中 $C(G)= \arg\mathop{\max}\limits_DV(G,D)$
  
  ![](https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200615120036.png)


## Algorithm

1. Initialize generator and discriminator
2. In each training iteration:     
      1. Fix G, update D
      2. Fix D, update G


### Procerss

实际上：
 $$\begin{aligned}
      V(G,D) &= E_x \sim_{P_{data}(x)}[log(D(x))] + E_x \sim_{P_G(x)}[log(1-D(x))] \\
             &\approx \frac{1}{m}\sum_{i=1}^{m}logD(x^i) + \frac{1}{m}\sum_{i=1}^{m}log(1-D(\hat{x}^i))
  \end{aligned}$$ 
  

initialize $\theta_d$ for D and $\theta_g$ for G

- In each training iteration
- Training D, repeat K times
  - sample m examples{$x^1,x^2,...x^m$} from database $P_{data}(x)$ 
  - sample m examples{$z^1,z^2,...z^m$} from prior distribution $P_z(z)$
  - get generated data {$\hat{x}^1,\hat{x}^2,...\hat{x}^m$} via $G(z^i)$
  - fixed $\theta_g$,update $\theta_d$ to maximize: 
  $$\begin{aligned}
      \hat{V} &= \frac{1}{m}\sum_{i=1}^{m}logD(x^i) + \frac{1}{m}\sum_{i=1}^{m}log(1-D(\hat{x}^i)) \\
      \theta_d &\gets \theta_d + \eta\bigtriangledown\hat{V}(\theta_d)
  \end{aligned}$$ 

- Training G, only once
  - sample m examples{$z^1,z^2,...z^m$} from prior distribution $P_z(z)$
  - fixed $\theta_d$,update $\theta_g$ to minimize:
  $$\begin{aligned}
     \hat{V} &= \frac{1}{m}\sum_{i=1}^{m}logD(x^i) + \frac{1}{m}\sum_{i=1}^{m}log(1-D(G(z^i))) \\
     &\approx\frac{1}{m}\sum_{i=1}^{m}log(1-D(G(z^i))) \\
      \theta_g &\gets \theta_g - \eta\bigtriangledown\hat{V}(\theta_g)
  \end{aligned}$$

实际上，在 Training G 时，采用的是：

$$\begin{aligned}
     \hat{V} &=  -\frac{1}{m}\sum_{i=1}^{m}log(D(G(z^i))) \\
      \theta_g &\gets \theta_g - \eta\bigtriangledown\hat{V}(\theta_g)
\end{aligned}$$

![](https://raw.githubusercontent.com/hsjfans/git_resource/master/img/20200615124406.png)