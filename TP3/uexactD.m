function y = uexactD(x)
    B = (6*exp(1)-8)/(exp(-1)-exp(1));
    A = -6-B;
    y = B*exp(-x)+A*exp(x)+10;
end

% solution de -u"+u=10
% avec u(a)=4 et u(b)=2