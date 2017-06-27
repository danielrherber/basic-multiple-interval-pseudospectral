%--------------------------------------------------------------------------
% ML_boundary.m
% Moon lander boundary constraint function
%--------------------------------------------------------------------------
% b = ML_boundary(X,U,p)
% X: state
% U: control
% p: parameter structure
% b: boundary constraint vector
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function b = ML_boundary(X,U,p)
    % initialize boundary constraint
    b = [];
    % position boundary constraints
    b = [b;X(1,1)-p.prob.h0;X(end,1)-p.prob.hf];
    % velocity boundary constraints
    b = [b;X(1,2)-p.prob.v0;X(end,2)-p.prob.vf];
end