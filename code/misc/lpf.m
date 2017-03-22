function y = lpf(x, alpha)
    y = x;
    for i=2:size(x,1)
       y(i) = (1-alpha)*y(i-1) + alpha*x(i);
    end
end