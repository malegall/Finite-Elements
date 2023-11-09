# Introduction to the Problem

## Initial Problem

We aim to solve the following differential equation on the interval $\left[a,b\right]$:
\begin{equation}
\begin{cases}
-u'' = f\
u(a) = u(b) = 0
\end{cases}
\end{equation}
The variational form is obtained by multiplying equation (1) by a function $v \in \mathcal{H}0^1(\left]a,b\right[)$ and integrating over $\left[a,b\right]$:
\begin{equation}
\begin{cases}
-\int{a}^{b} u''(x)v(x) , \mathrm{d}x = \int_{a}^{b} f(x)v(x) , \mathrm{d}x\
u(a) = u(b) = 0
\end{cases}
\end{equation}
After an integration by parts and using the initial conditions, it follows that:
\begin{equation}
\begin{cases}
\int_{a}^{b} u'(x)v'(x) , \mathrm{d}x = \int_{a}^{b} f(x)v(x) , \mathrm{d}x\
u(a) = u(b) = 0
\end{cases}
\end{equation}

## Discretized Problem

Let $V_h \subset \mathcal{H}0^1(\left]a,b\right[)$ with dimension $n$, and $(\varphi_i){1\leq i\leq n}$ be a basis for $V_h$. We can represent $u$ as $u_h = \sum\limits_{i=1}^n c_i\varphi_i$. The variational form is then given by:
\begin{equation}
\begin{cases}
\forall j \in \llbracket 1,n \rrbracket, \sum\limits_{i=1}^n c_i\int_a^b\varphi'i(x)\varphi'j(x) , \mathrm{d}x = \int{a}^{b} f(x)\varphi_j(x) , \mathrm{d}x\
u_h(a) = u_h(b) = 0
\end{cases}
\end{equation}
Defining:
\begin{equation}
\begin{cases}
R{i,j} = \int_a^b\varphi'_i(x)\varphi'j(x) , \mathrm{d}x\
b_j = \int{a}^{b} f(x)\varphi_j(x) , \mathrm{d}x\
\end{cases}
\end{equation}
we obtain the matrix system:
\begin{equation}
R\Vec{c} = \Vec{b}
\end{equation}

# MATLAB Programs

## Basis Functions $\varphi$

The functions phi, phideriv, and their derivatives take parameters $x,x_m,k,i_{loc}$.

$x_m$ is the interval mesh: $x_m = \bigcup\limits_{i=1}^n \left[x_{i},x_{i+1}\right]$
$k$ is the index of the desired $\varphi_k$
$i_{loc}$ is the local interval number.
Numerical Integration

I chose the Simpson's method for integrating the functions $\varphi$ and $f$. It takes the function fun to be integrated, integration bounds $a,b$, and arguments required for the function fun.

## Main Program

The main program consists of four parts:

Initialization of the interval, mesh, and functions.
Assembly of $\Vec{b}$.
Assembly of $R$.
Computation and display of the solution.

## Assembly of $\Vec{b}$
Since $\int_{a}^{b} f(x)\varphi_j(x) , \mathrm{d}x = \sum\limits_{k=1}^{n}\int_{x_k}^{x_{k+1}} f(x)\varphi_j(x) , \mathrm{d}x$, a loop over $k$ is introduced to assemble $\Vec{b}$. Define $i_{glob} = i_{loc}+k-1$ to access all indices of $\Vec{b}$. Sum $b_{iglob}$ over each interval $\left[x_{k},x_{k+1}\right]$ for all $i_{glob} \in \llbracket 1,n \rrbracket$.

## Assembly of $R$
Similar to the assembly of $\Vec{b}$, introduce the index $j_{glob} = j_{loc}+k-1$ when assembling $R$. The process is the same, with integration over different functions.
