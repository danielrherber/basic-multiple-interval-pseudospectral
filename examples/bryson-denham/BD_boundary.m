%--------------------------------------------------------------------------
% BD_boundary.m
% Bryson-Denham boundary constraint function
%--------------------------------------------------------------------------
% b = BD_boundary(X,U,p)
% X: state
% U: control
% p: parameter structure
% b: boundary constraint vector
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function b = BD_boundary(X,U,p)
    % initialize boundary constraint
    b = [];

    % position boundary constraints
    b = [b;X(1,1)-p.prob.p0;X(end,1)-p.prob.pf];

    % velocity boundary constraints
    b = [b;X(1,2)-p.prob.v0;X(end,2)-p.prob.vf];
end