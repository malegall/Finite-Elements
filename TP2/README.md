# Introduction du problème

## Problème initial

On cherche à résoudre l'équation différentielle suivante sur $\left[a,b\right]$

$`\begin{equation}
    \begin{cases}
        -u" + u = f\\
    \end{cases}       
\end{equation}`$

La forme variationnelle s'obtient en multipliant l'équation (1) par une fonction $v \in \mathcal{H}_0^1(\left]a,b\right[)$ et en intégrant sur $\left[a,b\right]$ : 

$`\begin{equation}
        -\int_{a}^{b} u"(x)v(x) \, \mathrm{d}x + \int_{a}^{b} u(x)v(x) \, \mathrm{d}x = \int_{a}^{b} f(x)v(x) \, \mathrm{d}x
\end{equation}
On obtient, suite à une IPP, la forme variationnelle suivante:
\begin{equation}
        \int_{a}^{b} u'(x)v'(x) \, \mathrm{d}x + \int_{a}^{b} u(x)v(x) \, \mathrm{d}x = \int_{a}^{b} f(x)v(x) \, \mathrm{d}x + [u'(x)v(x)]_a^b
\end{equation}`$

## Problème discret

Soit $`V_h \subset \mathcal{H}_0^1(\left]a,b\right[)`$ de dimension $n$ et $(\varphi_i)_{1\leq i\leq n}$ une base de $V_h$.

On peut alors écrire $u$ sous la forme $u_h = \sum\limits_{i=1}^n c_i\varphi_i$.

On a alors la forme variationnelle discrète suivante : 

$`\begin{equation}
        \forall j \in \llbracket 1,n \rrbracket, \sum\limits_{i=1}^n c_i(\int_a^b\varphi'_i(x)\varphi'_j(x) \, \mathrm{d}x + \int_a^b\varphi_i(x)\varphi_j(x) \, \mathrm{d}x) = \int_{a}^{b} f(x)\varphi_j(x) \, \mathrm{d}x + [u_h'(x)v_h(x)]_a^b
\end{equation}`$

$`\forall i,j \in \llbracket 1,n \rrbracket`$, on pose :

$`\begin{equation}
    \begin{cases}
        R_{i,j} = \int_a^b\varphi'_i(x)\varphi'_j(x) \, \mathrm{d}x\\
        M_{i,j} = \int_a^b\varphi_i(x)\varphi_j(x) \, \mathrm{d}x\\
        K = R+M
    \end{cases}
\end{equation}`$

Le membre de droite de l'équation (4) est le même que celui du TP1, à la seule différence qu'on lui rajoute les termes de bord de l'IPP:

$`\begin{equation}
\begin{cases}
    b_1 = \int_{a}^{b} f(x)\varphi_1(x) \, \mathrm{d}x - u'(a)\\
    b_n = \int_{a}^{b} f(x)\varphi_n(x) \, \mathrm{d}x + u'(b)
\end{cases}
\end{equation}`$

Et on obtient donc le système matriciel suivant :

$`\begin{equation}
    K\vec{c} = \vec{b}
\end{equation}`$

# Solution exacte

Prenons dans notre cas $f(x) = 10$. Ainsi:

$`\begin{equation}
    \begin{cases}
        -u" + u = 10\\
        u'(a) = 1 \\
        u'(b) = -1
    \end{cases}       
\end{equation}`$

$u$ s'écrit donc, après résolution de l'équation différentielle:

$`\begin{equation}
    u(x) = Ae^x + Be^{-x} + 10
\end{equation}`$

$`\begin{equation}
    \begin{cases}
        A = 1+B\\
        B = \frac{1+e^1}{e^{-1}-e^1}
    \end{cases}       
\end{equation}`$

# Programmes MATLAB 

J'ai utilisé la même programmation des fonctions $\varphi$ que pour le TP1. J'ai également utilisé la même méthode d'intégration, celle de Simpson.

## Programme principal

Le programme principal se décompose en 4 parties.

- L'initialisation de l'intervalle, du maillage et des fonctions.
- L'assemblage de $\Vec{b}$.
- L'assemblage de $R$ et de $M$.
- Le calcul et affichage de la solution.

## L'assemblage de $'\vec{b}'$ 
Comme $\int_{a}^{b} f(x)\varphi_j(x) \, \mathrm{d}x = \sum\limits_{k=1}^{n}\int_{x_k}^{x_{k+1}} f(x)\varphi_j(x) \, \mathrm{d}x$, on introduit une boucle $for$ sur $k$ pour assembler $\vec{b}$. \\On pose alors $i_{glob} = i_{loc}+k-1$ pour pouvoir accéder à tous les indices de $\vec{b}$.\\
Il suffit donc de sommer $b_{iglob}$ sur chaque intervalle $\left[x_{k},x_{k+1}\right]$ et cela $\forall i_{glob} \in \llbracket 1,n \rrbracket$.

On ajoute finalement les termes de bord pour le premier et dernier termes de $\Vec{b}$.

## L'assemblage de $'R'$ et de $'M'$
L'assemblage de $R$ et de $M$ est similaire à celui de $\vec{b}$, il faut simplement introduire en plus l'indice $j_{glob} = j_{loc}+k-1$. Le processus reste ensuite le même à la simple différence que ce ne sont pas les mêmes fonctions que l'on intégre.
