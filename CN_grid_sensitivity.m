%Grid sensitivity with the CN function for convergence study
dt = 0.001;
h = 4:2:80;
w_final = zeros(1,size(h,2));

for i=1:1:size(h,2)
    w_all = CN(dt,1/h(i),1/h(i));
    w_final(i) = mean(w_all(:,end));
end 


scatter(h, w_final,'LineWidth',1); grid on;
xlabel('H values. Grid size=1/h');
ylabel('Final Temperature (averaged over whole domain)');
sgtitle('Simulation runs. Crank-Nicolson, dt=0.001, Grid sizes from dh=0.25 to dh=0.0125. (h=4 to h=80)')
