%--------------------------------------------------------------------------
% PS_Fmatrix.m
% determines differential matrix for multiple-interval pseudospectral
% method
%--------------------------------------------------------------------------
% F = PS_Fmatrix(tau,X,U,t0,tf,p)
% tau: nodes
%   X: states
%   U: control
%  t0: initial time
%  tf: final time
%   p: parameter structure
%   F: differential matrix
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function F = PS_Fmatrix(tau,X,U,t0,tf,p)
    % determine differential matrix
    f = p.func.deriv(tau,X,U,t0,tf,p);
	% scale
    F = (tf-t0)/2*f;
end