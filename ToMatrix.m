function res = ToMatrix(A, X_Dir, Y_Dir)
 
    res = reshape(A, [X_Dir, Y_Dir]);
    res = res';
    
end
