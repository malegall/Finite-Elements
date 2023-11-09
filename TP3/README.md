# Introduction to the Problem

## Initial Problem

We aim to solve the following differential equation on $\left[a,b\right]$:

$`\begin{equation}
        -u'' + u = f\\     
\end{equation}`$

The variational form is obtained by multiplying equation (1) by a function $v \in \mathcal{H}_0^1(\left]a,b\right[)$ and integrating over $\left[a,b\right]$:

$`\begin{equation}
        -\int_{a}^{b} u''(x)v(x) \, \mathrm{d}x + \int_{a}^{b} u(x)v(x) \, \mathrm{d}x = \int_{a}^{b} f(x)v(x) \, \mathrm{d}x
\end{equation}`$

After an integration by parts (IPP), the variational form becomes:

$`\begin{equation}
        \int_{a}^{b} u'(x)v'(x) \, \mathrm{d}x + \int_{a}^{b} u(x)v(x) \, \mathrm{d}x = \int_{a}^{b} f(x)v(x) \, \mathrm{d}x + [u'(x)v(x)]_a^b
\end{equation}`$

## Dirichlet Conditions

I have chosen the following Dirichlet conditions:

$`\begin{cases}
    u(a) = 4\\
    u(b) = 2
\end{cases}\\`$

In the case of Dirichlet conditions, $u_{/\Gamma} = 0$. The variational form becomes:

$`\begin{equation}
    \int_{a}^{b} u'(x)v'(x) \, \mathrm{d}x + \int_{a}^{b} u(x)v(x) \, \mathrm{d}x = \int_{a}^{b} f(x)v(x) \, \mathrm{d}x
\end{equation}`$

## Neumann Conditions

I have chosen the following Neumann conditions:

$`\begin{cases}
    u'(a) = 1\\
    u'(b) = 1
\end{cases}`$

In this case, the variational form becomes:

$`\begin{equation}
        \int_{a}^{b} u'(x)v'(x) \, \mathrm{d}x + \int_{a}^{b} u(x)v(x) \, \mathrm{d}x = \int_{a}^{b} f(x)v(x) \, \mathrm{d}x - v(a) - v(b)
\end{equation}`$

## Mixed Conditions

I have chosen the following mixed conditions:

$`\begin{cases}
    u(a) = 4\\
    u'(b) = -1
\end{cases}`$

In this case, the variational form becomes:

$`\begin{equation}
        \int_{a}^{b} u'(x)v'(x) \, \mathrm{d}x + \int_{a}^{b} u(x)v(x) \, \mathrm{d}x = \int_{a}^{b} f(x)v(x) \, \mathrm{d}x - v(b)
\end{equation}`$

## Discrete Problem

Let $`V_h \subset \mathcal{H}_0^1(\left]a,b\right[)`$ with dimension $n$ and $(\varphi_i)_{1\leq i\leq n}$ be a basis of $V_h$.\\

We can then write $u$ as $u_h = \sum\limits_{i=1}^n c_i\varphi_i$.\\

The discrete variational form is then:

$`\begin{equation}
        \forall j \in \llbracket 1,n \rrbracket, \sum\limits_{i=1}^n c_i(\int_a^b\varphi'_i(x)\varphi'_j(x) \, \mathrm{d}x + \int_a^b\varphi_i(x)\varphi_j(x) \, \mathrm{d}x) = \int_{a}^{b} f(x)\varphi_j(x) \, \mathrm{d}x
\end{equation}`$

$`\forall i,j \in \left[ 1,n \right]`$, we define:

$`\begin{equation}
    \begin{cases}
        R_{i,j} = \int_a^b\varphi'_i(x)\varphi'_j(x) \, \mathrm{d}x\\
        M_{i,j} = \int_a^b\varphi_i(x)\varphi_j(x) \, \mathrm{d}x\\
        K = R+M\\
        b_j =   \int_{a}^{b} f(x)\varphi_j(x) \, \mathrm{d}x\\
    \end{cases}
\end{equation}`$


And we obtain the matrix system:

$`\begin{equation}
    K\vec{c} = \vec{b}
\end{equation}`$

# Exact Solution

Let's take $f(x) = 10$ in our case.

$u$ is then, after solving the differential equation:

$`\begin{equation}
    u(x) = Ae^x + Be^{-x} + 10
\end{equation}`$

## Dirichlet Conditions

We have:

$`\begin{cases}
    u(a) = 4\\
    u(b) = 2
\end{cases}`$


We obtain:
$`\begin{equation}
    \begin{cases}
        A = -6-B\\
        B = \frac{6e-8}{e^{-1}-e}
    \end{cases}       
\end{equation}`$

## Neumann Conditions

We have:

$`\begin{cases}
    u'(a) = 1\\
    u'(b) = -1
\end{cases}`$


We obtain:

$`\begin{equation}
    \begin{cases}
        A = 1+B\\
        B = \frac{1+e}{e^{-1}-e}
    \end{cases}       
\end{equation}`$

## Mixed Conditions

We have:

$`\begin{cases}
    u'(a) = 1\\
    u'(b) = -1
\end{cases}`$


We obtain:

$`\begin{equation}
    \begin{cases}
        A = -10-B\\
        B = \frac{1-10e}{e^{-1}+e}
    \end{cases}       
\end{equation}`$

# MATLAB Programs

I used the same programming of the $\varphi$ functions as in TP1. I also used the same integration method, Simpson's rule.

## Main Program

The main program is divided into 4 parts:

- Initialization of the interval, mesh, and functions.
- Assembly of $\vec{b}$.
- Assembly of $R$ and $M$.
- Calculation and display of the solution.

## Assembly of $`\vec{b}`$ 

Since $\int_{a}^{b} f(x)\varphi_j(x) \, \mathrm{d}x = \sum\limits_{k=1}^{n}\int_{x_k}^{x_{k+1}} f(x)\varphi_j(x) \, \mathrm{d}x$, a loop over $k$ is introduced to assemble $\Vec{b}$. We then set $i_{glob} = i_{loc}+k-1$ to access all indices of $\Vec{b}$.\\
We simply sum $b_{iglob}$ over each interval $\left[x_{k},x_{k+1}\right]$ for all $i_{glob} \in \left[ 1,n \right]$.

## Assembly of $`R`$ and $`M`$
The assembly of $`R`$ and $`M`$ is similar to that of $\Vec{b}$, but we introduce the additional index $j_{glob} = j_{loc}+k-1$. The process remains the same with the only difference being the integration of different functions.

## Differences in Assemblies

### Construction of $K$ and $b$ for Dirichlet Conditions

We extract the sub-matrix $newK$, which is the matrix $K$ without its first row, last row, first column, and last column.

We create a new vector $newB$, which is the vector $b$ minus the first and last columns of $K$ multiplied by the respective boundary terms. We then extract the sub-vector without the first and last terms.

We solve $newK*u = newB$, and fix $u$ at the boundaries.

### Construction of $K$ and $b$ for Neumann Conditions

The right-hand side of (8) is the same as that for Dirichlet conditions, with the only difference that we add the IPP boundary terms:

$`\begin{equation}
\begin{cases}
    b_1 = \int_{a}^{b} f(x)\varphi_1(x) \, \mathrm{d}x - u'(a)\\
    b_n = \int_{a}^{b} f(x)\varphi_n(x) \, \mathrm{d}x + u'(b)
\end{cases}
\end{equation}`$

This time, we do not perform matrix and vector extractions. We directly solve $K*c = b$.

### Construction of $K$ and $b$ for Mixed Conditions

The right-hand side of (8) is the same as that for Dirichlet conditions, with the only difference that we add the IPP boundary terms.\\

$`\begin{equation}
    b_n = \int_{a}^{b} f(x)\varphi_n(x) \, \mathrm{d}x + u'(b)
\end{equation}`$

We extract the sub-matrix $newK$, which, this time, is the matrix $K$ without its first row and first column.

We create a new vector $newB$, which is the vector $b$ minus the first column of $K$ multiplied by the respective boundary term. We then extract the sub-vector without the first term.

We solve $newK*u = newB$, and fix $u$ at the boundary.
