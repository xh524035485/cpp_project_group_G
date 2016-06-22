function [val,error] =QUAD(S_0,r,sig,X,T,Dc,K)


t=0;
delta_t = T-t;
k= 2 * (r-Dc)/sig^2 -1;
    
x = log(S_0/X);
% ymin = -10;

b = log(X);
ymax = 200;
% N_x = 10000;
% delta_y= (ymax-b)/N_x;

% K=100;
delta_y = delta_t^0.5/K;
N_x= floor((ymax-b)/delta_y);

Inv =0;
for i=1:N_x - 1
    Inv = Inv + (2*B_func(x,i*delta_y,sig,delta_t,k) * payoff_func(X,i*delta_y) + 4*B_func(x,(i+1/2)*delta_y,sig,delta_t,k) * payoff_func(X,(i+1/2)*delta_y));
end
Remain = B_func(x,0,sig,delta_t,k) * payoff_func(X,0) + 4*B_func(x,delta_y/2,sig,delta_t,k) * payoff_func(X,delta_y/2) +  B_func(x,N_x * delta_y,sig,delta_t,k) * payoff_func(X,N_x * delta_y);
V = A_func(x,sig,delta_t,k,r)/6 * delta_y * (Inv + Remain);

val=V;

% K=500;
% delta_y = delta_t^0.5/K
% N_x= floor((ymax-b)/delta_y);
% 
% Inv =0;
% for i=1:N_x - 1
%     Inv = Inv + (2*B_func(x,i*delta_y,sig,delta_t,k) * payoff_func(X,i*delta_y) + 4*B_func(x,(i+1/2)*delta_y,sig,delta_t,k) * payoff_func(X,(i+1/2)*delta_y));
% end
% Remain = B_func(x,0,sig,delta_t,k) * payoff_func(X,0) + 4*B_func(x,delta_y/2,sig,delta_t,k) * payoff_func(X,delta_y/2) +  B_func(x,N_x * delta_y,sig,delta_t,k) * payoff_func(X,N_x * delta_y);
% V = A_func(x,sig,delta_t,k,r)/6 * delta_y * (Inv + Remain)
% 
% V2=V;
% delta_y2=delta_y;
% 
% 
% Vext = (delta_y1^4*V2 - delta_y2^4*V1) / (delta_y1^4 - delta_y2^4)

[Call, Put] = blsprice(S_0, X, r, T, sig, Dc);

error = V - Call;