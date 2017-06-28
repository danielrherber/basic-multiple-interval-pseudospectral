%--------------------------------------------------------------------------
% Brach_solution.m
% creates the analytic solution  
%--------------------------------------------------------------------------
% see http://www.danielherber.com/matlab.php?option=post_8 for more
% information on the solution
%--------------------------------------------------------------------------
% [t,X,U,f,tf] = Brach_solution(t,p,flag)
%    t: time
%    p: parameter structure
% flag: boolean to determine if a large number of ED points time points
%    X: state solution
%    U: control solution
%    F: objective function value
%   tf: final time
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function [t,X,U,F] = Brach_solution(t,p,flag)

    % large number of points? otherwise use original
    if flag == 1
        t = linspace(t(1),t(end),10000)';
    end

    % extract
    tin = t;
    gin  = p.prob.g;
    xfin = p.prob.xf;
    yfin = p.prob.yf;

    % initialize symbolic variables
    syms theta k xf yf

    % define symbolic functions
    eqnX = symfun( k^2/2*(theta - sin(theta)) == xf , xf);
    eqnY = symfun( k^2/2*(1 - cos(theta)) == yf , yf );

    % solve for thetaf and k
    S = vpasolve([eqnX(xfin),eqnY(yfin)],[theta,k],[0 2*pi; 0 Inf]);

    % extract 
    thetaf = S.theta; k = S.k;

    % scaling constant
    alphat = sqrt(k^2/(2*gin));

    % final time
    tfin = alphat*thetaf;

    % theta horizon   
    theta = tin/alphat;

    % states
    X = k^2/2*(theta - sin(theta));
    Y = k^2/2*(1 - cos(theta));
    V = k*sqrt(2*gin)*sin(theta/2);
    
    % control    
    U = theta/2;

    % convert to double
    V = double(V(:));
    X = double(X(:));
    Y = double(Y(:));
    U = double(U(:));
    prob.tf = double(tfin);

    % create outputs
    X = [X,Y,V];
    t = tin;
    F = prob.tf;

end