function res = ToVector(A)
    M = numel(A);
    res = reshape(A',[M,1]);
    %reshape(M.',1,[]);
end


