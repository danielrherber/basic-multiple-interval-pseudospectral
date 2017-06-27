%--------------------------------------------------------------------------
% ML_deriv.m
% Moon lander derivative function
% outputs a derivative function matrix
%--------------------------------------------------------------------------
% f = ML_deriv(tau,X,U,t0,tf,p)
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
function f = ML_deriv(tau,X,U,t0,tf,p)
    % state 1 derivative
    f(:,1) = X(:,2); % velocity
    % state 2 derivative
    f(:,2) = -p.prob.g + U(:,1); % acceleration
end