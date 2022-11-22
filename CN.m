function res = CN(dt,dx,dy)
    %Crank-Nicolson scheme written in function form
    pi = 3.14145926536;
    
    
    x = 0:dx:1;
    y = 0:dy:1;
    t = 0:dt:0.16;
    
    m = size(y,2);
    n = size(x,2);
    
    
    %Initial conditions and Boundary conditions
    %---Initial Conditions, w(x,y,0) = 0
    W_0 = zeros(m,n);
    
    %---Boundary, conditions
    W  = zeros(m,n);
    %w(x=0, y, t) LEFT
    W(1:end,1) =  1-y.^3;
    %w(x=1, y, t) RIGHT
    W(1:end,end) = 1-sin(pi/2*y);
    %w(x,0,t)  BOTTOM
    W(1, 1:end) = ones(size(x));
    %w(x,1,t) TOP
    W(end, 1:end) = zeros(size(x));
    
    
    %Grid
    [X,Y] = meshgrid(x,y);
    
    B_m = constructB(m,n,dx,dy,dt);
    A_m = constructA(m,n,dx,dy,dt);
    A_f = A_m\B_m;
    
    w = ToVector(W); %W is matrix, w is vector
    W_f = W; %forward step will be called W_f
    w_all = zeros(m*n,size(t,2)+1);
    
    
    %Time-stepping
    for i=1:1:size(t,2)
       
        %Plotting
        %contourf(x,y,W_f); colorbar('WestOutside'); drawnow;
        %plot_mesh(W_f,x,y,dx,dy, 1); drawnow; %shading('interp');
    
        w = A_f*w; %instead of w = A_m\(B_m*w)
        
        w_all(:,i+1)=w;
     

    end

disp(['Finished simulation: dt dx dy = ', string(dt),string(dx),string(dy)])
res = w_all;






