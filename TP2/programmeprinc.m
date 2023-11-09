% Mathis Le Gall
% Programme principal TP1 EF
% Résolution de :
% -u" + alpha*u = f sur [0,1]

a = 0, b = 1; % intervalle de résolution de l'équation
%ua = 4, ub = 2; % conditions initiales (Dirichlet)
n = 5, h = (b-a)/n, xm = linspace(a,b,n+1); % maillage de l'intervalle
x = linspace(a,b,100); % maillage pour la solution exacte
alpha = 1; % coefficient devant u
funphif = @phif, funphideriv = @prodphideriv, funprodphi = @prodphi % utilisation des fonctions phi*f, phi'_i*phi'_j et phi_i*phi_j

% Assemblage de B
B = sparse(n+1,1);
for k = 1:n
    for iloc = 1:2
        iglob = iloc + k-1;
        B(iglob) = B(iglob) + integsimpson(funphif,xm(k),xm(k+1),xm,k,iloc);
    end
end

% Assemblage de R et de M
R = zeros(n+1,n+1);
M = zeros(n+1,n+1);
for k = 1:n
    for iloc = 1:2
        iglob = iloc + k-1;
        for jloc = 1:2
            jglob = jloc + k-1;
            M(iglob,jglob) = M(iglob,jglob) + integsimpson(funprodphi,xm(k),xm(k+1),xm,iloc,jloc,k);
            R(iglob,jglob) = R(iglob,jglob) + integsimpson(funphideriv,xm(k),xm(k+1),xm,iloc,jloc,k);
        end
    end
end
K = R+alpha*M;

% Dirichlet à gauche et à droite
%newR = R([2:n],[2:n]);
%newintB = B - ua*R(:,1) - ub*R(:,n+1);
%newB = newintB([2:n]);

% Calcul de la solution pour Dirichlet
%u(1) = ua;
%u([2:n]) = newR\newB;
%u(n+1) = ub;

% Conditions de Neumann
uda = 1, udb = -1; % u'(a)=1 et u'(b)=-1
V = zeros(n+1,1);
V(1) = -uda, V(n+1) = udb; 
newB = B + V % On ajoute les termes de bord au premier et dernier terme de B
u = K\newB % On résout Ku = b

% Solution exacte
uex = uexact2(x); % solution exacte de -u"+alpha*u=10

% Affichage de la solution
plot(xm,u); 
hold on
plot(x,uex);
legend({'Solution approchée u_h','Solution exacte u'},'Location','southwest')