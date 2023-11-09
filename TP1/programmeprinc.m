% Mathis Le Gall
% Programme principal TP1 EF
% Résolution de :
% -u" = f sur [0,1]

a = 0, b = 1; % intervalle de résolution de l'équation
n = 5, h = (b-a)/n, xm = [0,0.2,0.3,0.6,0.8,1]; % maillage de l'intervalle
funphif = @phif, funphideriv = @prodphideriv; % utilisation des fonctions phi*f et phi'_i*phi'_j

% Assemblage de B
B = sparse(n+1,1);
for k = 1:n
    for iloc = 1:2
        iglob = iloc + k-1;
        B(iglob) = B(iglob) + integsimpson(funphif,xm(k),xm(k+1),xm,k,iloc);
    end
end

% Assemblage de R
R = sparse(n+1,n+1);
for k = 1:n
    for iloc = 1:2
        iglob = iloc + k-1;
        for jloc = 1:2
            jglob = jloc + k-1;
            R(iglob,jglob) = R(iglob,jglob) + integsimpson(funphideriv,xm(k),xm(k+1),xm,iloc,jloc,k);
        end
    end
end
R = -1*R; % on résout -u'' = f;
R(1,1) = 10^7, R(n+1,n+1) = 10^7;

% Calcul de la solution
u = R\B;

% Conditions initiales
u(1) = 0, u(n+1) = 0;

% Affichage de la solution
plot(xm,u);
