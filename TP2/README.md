# Introduction to the Problem

## Initial Problem

We aim to solve the following differential equation on $\left[a, b\right]$

\[
\begin{equation}
    \begin{cases}
        -u'' + u = f
    \end{cases}       
\end{equation}
\]

The variational form is obtained by multiplying Equation (1) by a function \(v \in \mathcal{H}_0^1(\left]a, b\right[)\) and integrating over \(\left[a, b\right]\):

\[
\begin{equation}
        -\int_{a}^{b} u''(x)v(x) \, \mathrm{d}x + \int_{a}^{b} u(x)v(x) \, \mathrm{d}x = \int_{a}^{b} f(x)v(x) \, \mathrm{d}x
\end{equation}
\]

After integrating by parts, we get the following variational form:

\[
\begin{equation}
        \int_{a}^{b} u'(x)v'(x) \, \mathrm{d}x + \int_{a}^{b} u(x)v(x) \, \mathrm{d}x = \int_{a}^{b} f(x)v(x) \, \mathrm{d}x + [u'(x)v(x)]_a^b
\end{equation}
\]

## Discrete Problem

Let \(V_h \subset \mathcal{H}_0^1(\left]a, b\right[)\) with dimension \(n\), and \((\varphi_i)_{1\leq i\leq n}\) be a basis for \(V_h\).

We can write \(u\) as \(u_h = \sum\limits_{i=1}^n c_i\varphi_i\).

The discrete variational form is then given by:

\[
\begin{equation}
        \forall j \in \left[ 1,n \right], \sum\limits_{i=1}^n c_i\left(\int_a^b\varphi'_i(x)\varphi'_j(x) \, \mathrm{d}x + \int_a^b\varphi_i(x)\varphi_j(x) \, \mathrm{d}x\right) = \int_{a}^{b} f(x)\varphi_j(x) \, \mathrm{d}x + [u_h'(x)v_h(x)]_a^b
\end{equation}
\]

For \(i, j \in \left[ 1,n \right]\), let's define:

\[
\begin{equation}
    \begin{cases}
        R_{i,j} = \int_a^b\varphi'_i(x)\varphi'_j(x) \, \mathrm{d}x\\
        M_{i,j} = \int_a^b\varphi_i(x)\varphi_j(x) \, \mathrm{d}x\\
        K = R+M
    \end{cases}
\end{equation}
\]

The right-hand side of Equation (4) is the same as in TP1, with the addition of boundary terms from integration by parts:

\[
\begin{equation}
\begin{cases}
    b_1 = \int_{a}^{b} f(x)\varphi_1(x) \, \mathrm{d}x - u'(a)\\
    b_n = \int_{a}^{b} f(x)\varphi_n(x) \, \mathrm{d}x + u'(b)
\end{cases}
\end{equation}
\]

This leads to the following matrix system:

\[
\begin{equation}
    K\vec{c} = \vec{b}
\end{equation}
\]

# Exact Solution

Let's take \(f(x) = 10\). Thus:

\[
\begin{equation}
    \begin{cases}
        -u'' + u = 10\\
        u'(a) = 1 \\
        u'(b) = -1
    \end{cases}       
\end{equation}
\]

The solution \(u\) is obtained after solving the differential equation:

\[
\begin{equation}
    u(x) = Ae^x + Be^{-x} + 10
\end{equation}
\]

\[
\begin{equation}
    \begin{cases}
        A = 1+B\\
        B = \frac{1+e^1}{e^{-1}-e^1}
    \end{cases}       
\end{equation}
\]

# MATLAB Programs

I used the same programming approach for the \(\varphi\) functions as in TP1. I also used the Simpson integration method.

## Main Program

The main program consists of four parts.

- Initialization of the interval, mesh, and functions.
- Assembly of \(\vec{b}\).
- Assembly of \(R\) and \(M\).
- Computation and display of the solution.

## Assembly of \(vec{b}\)

Since \(\int_{a}^{b} f(x)\varphi_j(x) \, \mathrm{d}x = \sum\limits_{k=1}^{n}\int_{x_k}^{x_{k+1}} f(x)\varphi_j(x) \, \mathrm{d}x\), we use a loop over \(k\) to assemble \(\vec{b}\). We define \(i_{glob} = i_{loc}+k-1\) to access all indices of \(\vec{b}\). We sum \(b_{iglob}\) over each interval \(\left[x_{k},x_{k+1}\right]\) for all \(i_{glob} \in \left[ 1,n \right]\).

Finally, we add the boundary terms for the first and last terms of \(\vec{b}\).

## Assembly of \(R\) and \(M\)

The assembly of \(R\) and \(M\) is similar to the assembly of \(\vec{b}\). We introduce the additional index \(j_{glob} = j_{loc}+k-1\). The process remains the same, with the difference that we integrate different functions.
