%--------------------------------------------------------------------------
% ML_solution.m
% creates the analytic solution 
%--------------------------------------------------------------------------
% See reference:
% Meditch, J., "On the Problem of Optimal Thrust Programming for a Soft
% Lunar Landing," IEEE Transactions on Automatic Control, Vol. 9,% No. 4,
% 1964, pp. 477-484.    
%--------------------------------------------------------------------------
% [t,X,U,f,tf] = BD_solution(t,p,flag)
%    t: time
%    p: parameter structure
% flag: boolean to determine if a large number of ED points time points
%    X: state solution
%    U: control solution
%    f: objective function value
%   tf: final time
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function [t,X,U,f,tf] = ML_solution(t,p,flag)

    % large number of points? otherwise use original
    if flag == 1
        t = linspace(t(1),t(end),10000)';
    end

    % extract
    h0 = p.prob.h0; v0 = p.prob.v0; U = p.prob.umax; g = p.prob.g;

    % switching time
    t1 = -(((U*(v0^2 + 2*g*h0))/(U - g))^(1/2) - (U*(v0 + ((U*(v0^2 + 2*g*h0))/(U - g))^(1/2)))/g)/U;

    % final time
    tf = (v0 + ((U*(v0^2 + 2*g*h0))/(U - g))^(1/2))/g;

    % objective
    f = (tf-t1)*U;

    % initial segment
    H1 = h0 + t*v0 - (g*t.^2)/2;
    V1 = v0 - g*t;
    U1 = zeros(length(t),1);

    % final segment
    H2 = h0 + t.^2*(U/2 - g/2) + (U*t1^2)/2 + t*(v0 - U*t1);
    V2 = v0 - U*t1 + 2*t*(U/2 - g/2);
    U2 = U*ones(length(t),1);

    % combine
    H = (t < t1).*H1 + (t >= t1 & t <= tf).*H2;
    V = (t < t1).*V1 + (t >= t1 & t <= tf).*V2;
    U = (t < t1).*U1 + (t >= t1 & t <= tf).*U2;
    X = [H,V];

end

% code to derive the formulas above
% % initialize
% syms t
% syms h(t) h0 v0 g U t1 tf 
% Dh = diff(h);
% D2h = diff(h,2);
% 
% % zero control segment
% H1 = dsolve(D2h == -g + 0, h(0) == h0, Dh(0) == v0);
% V1 = diff(H1,t);
% 
% % intermediate values
% h1 = subs(H1,'t',t1);
% v1 = subs(V1,'t',t1);
% 
% % maximum control segment
% H2 = dsolve(D2h == -g + U, h(t1) == h1, Dh(t1) == v1);
% V2 = diff(H2,t);
% 
% % final values
% h2 = subs(H2,'t',tf);
% v2 = subs(V2,'t',tf);
% 
% % solve the system of equations
% eq1 = h2 == 0;
% eq2 = v2 == 0;
% S = solve(eq1,eq2,t1,tf);
% 
% % display final formulas
% disp(S.t1(1))
% disp(S.tf(1))