# Problem Introduction

## Initial Problem

We aim to solve the following differential equation on $\left[a,b\right]$

$`\begin{equation} \begin{cases} -u" + u = f\\ \end{cases} \end{equation}`$

The variational form is obtained by multiplying equation (1) by a function $v \in \mathcal{H}_0^1(\left]a,b\right[)$ and integrating over $\left[a,b\right]$:

$`\begin{equation} -\int_{a}^{b} u"(x)v(x) \, \mathrm{d}x + \int_{a}^{b} u(x)v(x) \, \mathrm{d}x = \int_{a}^{b} f(x)v(x) \, \mathrm{d}x \end{equation}`$

After an integration by parts, we obtain the following variational form:

$`\begin{equation} \int_{a}^{b} u'(x)v'(x) \, \mathrm{d}x + \int_{a}^{b} u(x)v(x) \, \mathrm{d}x = \int_{a}^{b} f(x)v(x) \, \mathrm{d}x + [u'(x)v(x)]_a^b \end{equation}`$

## Discrete Problem

Let $`V_h \subset \mathcal{H}_0^1(\left]a,b\right[)`$ with dimension $n$ and $(\varphi_i)_{1\leq i\leq n}$ be a basis for $V_h$.

We can write $u$ as $u_h = \sum\limits_{i=1}^n c_i\varphi_i$.

The discrete variational form is then:

$`\begin{equation} \forall j \in \left[ 1,n \right], \sum\limits_{i=1}^n c_i(\int_a^b\varphi'_i(x)\varphi'_j(x) \, \mathrm{d}x + \int_a^b\varphi_i(x)\varphi_j(x) \, \mathrm{d}x) = \int_{a}^{b} f(x)\varphi_j(x) \, \mathrm{d}x + [u_h'(x)v_h(x)]_a^b \end{equation}`$

For $\forall i,j \in \left[ 1,n \right]$, we define:

$`\begin{equation} \begin{cases} R_{i,j} = \int_a^b\varphi'_i(x)\varphi'_j(x) \, \mathrm{d}x\\ M_{i,j} = \int_a^b\varphi_i(x)\varphi_j(x) \, \mathrm{d}x\\ K = R+M \end{cases} \end{equation}`$

The right-hand side of equation (4) is similar to the one in TP1, with the addition of the boundary terms from integration by parts:

$`\begin{equation} \begin{cases} b_1 = \int_{a}^{b} f(x)\varphi_1(x) \, \mathrm{d}x - u'(a)\\ b_n = \int_{a}^{b} f(x)\varphi_n(x) \, \mathrm{d}x + u'(b) \end{cases} \end{equation}`$

This leads to the matrix system:

$\begin{equation} K\vec{c} = \vec{b} \end{equation}$

# Exact Solution

Let's consider $f(x) = 10$. Thus:

$`\begin{equation} \begin{cases} -u" + u = 10\\ u'(a) = 1 \\ u'(b) = -1 \end{cases} \end{equation}`$

The solution $u$ is then, after solving the differential equation:

$`\begin{equation} u(x) = Ae^x + Be^{-x} + 10 \end{equation}`$

$`\begin{equation} \begin{cases} A = 1+B\\ B = \frac{1+e^1}{e^{-1}-e^1} \end{cases} \end{equation}`$

# MATLAB Programs

I used the same programming for the $\varphi$ functions as in TP1. I also employed the same integration method, Simpson's rule.

## Main Program

The main program consists of four parts:

- Initialization of the interval, mesh, and functions.
- Assembly of $\vec{b}$.
- Assembly of $R$ and $M$.
- Computation and display of the solution

## Assembly of $`\vec{b}`$.

Since $\int_{a}^{b} f(x)\varphi_j(x) , \mathrm{d}x = \sum\limits_{k=1}^{n}\int_{x_k}^{x_{k+1}} f(x)\varphi_j(x) , \mathrm{d}x$, we introduce a loop over $k$ to assemble $\vec{b}$. \We then set $i_{glob} = i_{loc}+k-1$ to access all indices of $\vec{b}$.\
We only need to sum $b_{iglob}$ over each interval $\left[x_{k},x_{k+1}\right]$, for all $i_{glob} \in \left[ 1,n \right]$.

Finally, we add the boundary terms for the first and last terms of $\vec{b}$.

## Assembly of $`R`$ and $`M`$

The assembly of $R$ and $M$ is similar to that of $\vec{b}$, with the additional introduction of the index $j_{glob} = j_{loc}+k-1$. The process remains the same with the only difference being the functions being integrated.
