function y = integsimpson(fun,a,b,varargin)
    c = (a+b)/2; % point milieu
    g = feval(fun,[a c b],varargin{:});
    y = (b-a)*(g(1)+4*g(2)+g(3))/6;
end
