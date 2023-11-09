function y = prodphideriv(x,xm,iloc,jloc,k)    
    y = phideriv(x,xm,k,iloc).*phideriv(x,xm,k,jloc);
end