function y = phi(x,xm,k,iloc)
    if (iloc<1 | iloc>2)
        error('Pas définie en dehors de lintervalle'),
    end
    if (iloc==1)
        y = (x-xm(k+1))./(xm(k)-xm(k+1)); % fonction décroissante
    else
        y = (x-xm(k))./(xm(k+1)-xm(k)); % fonction croissante
end

