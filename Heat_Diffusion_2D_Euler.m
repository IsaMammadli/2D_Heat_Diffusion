clc; clear;
tic
pi = 3.14145926536;

%Step sizes and dimensions of mesh
dx = 1/40;
dy = 1/40;
dt = 0.0001; %dt<1.5625e-04 for stability

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

B_m = construct_EU_B(m,n,dx,dy,dt);


w = ToVector(W); %W is matrix, w is vector
W_f = W; %forward step will be called W_f
w_all = zeros(m*n,size(t,2)+1);

for i=1:1:size(t,2)
   
    %Plotting
    %contourf(x,y,W_f);
    %shading('interp');
    %plot_mesh(W_f,x,y,dx,dy, 1); drawnow; %to update the plot at every iteration
    
    w = (B_m*w);
    w_all(:,i+1)=w;
    W_f = ToMatrix(w,m,n);
    % 
    disp(['Timestep ',num2str(i)]);

end

time = toc;

%Plots required for the tasksheet
figure;
sgtitle('Explicit Euler with Grid [' + string(m)+ 'x'+ string(n)+'],' + ' timestep='+string(dt));
subplot(2,2,1)
%Plot for x=y=0.4
i_x = 0.4/dx+1;
i_y = 0.4/dy+1;
T1 = w_all(i_x+(i_y-1)*n,2:end);
plot(t,T1,'LineWidth',1); 
xlabel('Time'); ylabel('Temperature at x=0.4, y=0.4'); grid("on");

subplot(2,2,2)
%Plot for y-vertical temperature profile at x=0.4, t=0.16
i_x = 0.4/dx+1;
w_2 = ToMatrix(w_all(:,end), n, m);
scatter(w_2(:,i_x),y, 'LineWidth',1); 
xlabel('Temperature at x=0.4, t=0.16'); ylabel('Y-Vertical'); grid("on");

subplot(2,2,3)
diff = mean(w_all(:,3:end)-w_all(:, 2:end-1),1);
scatter(t(1,2:end), diff);
xlabel('Time'); ylabel('Temperature difference (average)'); grid("on");
hold on;


figure;
sgtitle('Explicit Euler with Grid [' + string(m)+ 'x'+ string(n)+'],' + ' timestep='+string(dt));
%Plot for y-vertical temperature profile at x=0.4, t=0.16
W_t01 = ToMatrix(w_all(:,0.01/dt+1), n,m);
W_t02 = ToMatrix(w_all(:,0.02/dt+1), n,m);
W_t04 = ToMatrix(w_all(:,0.04/dt+1), n,m);
W_t08 = ToMatrix(w_all(:,0.08/dt+1), n,m);
W_t16 = ToMatrix(w_all(:,0.16/dt+1), n,m);

subplot(3,2,1); plot_mesh(W_t01,x,y,dx,dy, 1); xlabel('t=0.01');
subplot(3,2,2); plot_mesh(W_t02,x,y,dx,dy, 1); xlabel('t=0.02');
subplot(3,2,3); plot_mesh(W_t04,x,y,dx,dy, 1); xlabel('t=0.04');
subplot(3,2,4); plot_mesh(W_t08,x,y,dx,dy, 1); xlabel('t=0.08');
subplot(3,2,5); plot_mesh(W_t16,x,y,dx,dy, 1); xlabel('t=0.16');


time