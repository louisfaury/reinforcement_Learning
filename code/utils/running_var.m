function res = running_var(array,window_size)
%% <======================= HEADER =======================>
% @brief : This function returns an array of covariance over window_size
%          sample window from an initial array
% @param : array <- input array
%          window_size
% @return : array of size(array)
%  <======================================================>

assert(window_size>0)
n   = size(array,1);
res = zeros(n,1);

for i=1:n
    lower_index = max(1,i-round(window_size/2));
    upper_index = min(n,i+round(window_size/2));
    res(i,1)    = var(array(lower_index:upper_index,1)); 
end

end