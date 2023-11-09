% Mathis Le Gall
% Programme principal TP1 EF
% Résolution de :
% -u" + alpha*u = f sur [a,b], u(a)=0 et u'(b)=-1;

a = 0, b = 1; % intervalle de résolution de l'équation
ua = 0; % conditions initiales (Dirichlet)
n = 5, h = (b-a)/n, xm = linspace(a,b,n+1); % maillage de l'intervalle
x = linspace(a,b,100); % maillage pour la solution exacte
alpha = 1; % coefficient devant u
u = zeros(n+1,1); % initialisation de u
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

% Neumann à droite
udb = -1; % u'(b)=-1
V = zeros(n+1,1);
V(n+1) = udb; 
B = B + V; % On ajoute les termes de bord au dernier terme de B

% Dirichlet à gauche
newK = K([2:n+1],[2:n+1]);;
newintB = B - ua*K(:,1)
newB = newintB([2:n+1]);

% Calcul de la solution
u(1) = ua;
u([2:n+1]) = newK\newB;

% Solution exacte
uexact = @uexactM;
uex = uexact(x); % solution exacte de -u"+alpha*u=10

% Affichage de la solution
plot(xm,u); 
hold on
plot(x,uex);
legend({'Solution approchée u_h','Solution exacte u'},'Location','southwest')