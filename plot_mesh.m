function plot_mesh(W,x,y,dx,dy,k)
    %mesh plotting routine with the required parameters
    [m,n] = size(W);
    x_k = [x , x(end)+dx*k];
    y_k = [y , y(end)+dy*k];
    W_m = zeros(m+k,n+k);
    W_m(1:1:end-k,1:1:end-k) = W;
  
    
    surf(x_k,y_k,W_m); view(2); colorbar('WestOutside');
    xlim([min(x_k), max(x_k)]); ylim([min(y_k), max(y_k)]);
    %yyaxis right;
    %ylim([1, m+1]);
    colormap('jet')
end
