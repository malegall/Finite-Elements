function y = uexactM(x)
    B = (1-10*exp(1))/(exp(-1)+exp(1));
    A = -10-B;
    y = B*exp(-x)+A*exp(x)+10;
end

% solution de -u"+u=10
% avec u(a)=0 et u'(b)=-1