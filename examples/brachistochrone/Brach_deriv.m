%--------------------------------------------------------------------------
% Brach_deriv.m
% Brachistochrone derivative function
% outputs a derivative function matrix
%--------------------------------------------------------------------------
% f = Brach_deriv(tau,X,U,t0,tf,p)
% tau: scaled nodes
%  X: state
%  U: control
% t0: initial time
% tf: final time
%  p: parameter structure
%  f: derivative value
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function f = Brach_deriv(tau,X,U,t0,tf,p)
    % state 1 derivative
    f(:,1) = X(:,3).*sin(U(:,1)); % x
    % state 2 derivative
    f(:,2) = X(:,3).*cos(U(:,1)); % y
    % state 3 derivative
    f(:,3) = p.prob.g*cos(U(:,1)); % v

end