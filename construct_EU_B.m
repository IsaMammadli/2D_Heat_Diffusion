function res = construct_EU_B(m,n,dx,dy,dt)
    %Builds B matrix in w^(n+1)=B*w^(n) for Explicit Euler

    A_m = zeros(m*n,m*n);
    row_Am=1;
    for i=1:1:m
        for j=1:1:n
            A = zeros(m,n);

            if i==1 
                A(i,j)=1;
            %i=m
            elseif i==m
                A(i,j)=1;   
            %j=1
            elseif j==1 
                A(i,j)=1;
            %j=n
            elseif j==n
                A(i,j)=1;
            
            
            %any (i,j)     
            else
                A(i,j) = (1-2*dt/dx^2-2*dt/dy^2);
                A(i+1, j) = (dt/(dy^2));
                A(i-1, j) = (dt/(dy^2));
                A(i, j+1) = (dt/(dx^2));
                A(i, j-1) = (dt/(dx^2));
                
            end
            A_m(row_Am,1:end) = ToVector(A)';
            row_Am=row_Am+1;         
        end
    end
    res = A_m;
end

