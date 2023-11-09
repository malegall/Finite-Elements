function y = prodphi(x,xm,iloc,jloc,k)    
    y = phi(x,xm,k,iloc).*phi(x,xm,k,jloc);
end