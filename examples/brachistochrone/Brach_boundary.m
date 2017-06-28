%--------------------------------------------------------------------------
% Brach_boundary.m
% Brachistochrone boundary constraint function
%--------------------------------------------------------------------------
% b = Brach_boundary(X,U,p)
% X: state
% U: control
% p: parameter structure
% b: boundary constraint vector
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function b = Brach_boundary(X,U,p)
    % initialize boundary constraint
    b = [];
    % initial boundary constraints
    b = [b;X(1,1)-p.prob.x0;X(1,2)-p.prob.y0;X(1,3)-p.prob.v0];
    % final boundary constraints
    b = [b;X(end,1)-p.prob.xf;X(end,2)-p.prob.yf];
end