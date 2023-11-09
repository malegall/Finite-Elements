function y = phideriv(x,xm,k,iloc)
    if (iloc<1 | iloc>2)
        error('Pas définie en dehors de lintervalle'),
    end
    
    if (iloc==1)
        y = ones(size(x))./(xm(k)-xm(k+1));
    else
        y = ones(size(x))./(xm(k+1)-xm(k));
end

