function y = uexact2(x)
    B = (1+exp(1))/(exp(-1)-exp(1));
    A = 1+B;
    y = B*exp(-x)+A*exp(x)+10;
end

% solution de -u"+u=10