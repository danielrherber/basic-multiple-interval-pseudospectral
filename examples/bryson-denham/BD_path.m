%--------------------------------------------------------------------------
% BD_path.m
% Bryson-Denham path constraint function
%--------------------------------------------------------------------------
% path = BD_path(X,U,p)
% X: state
% U: control
% p: parameter structure
% path: path constraint vector
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function path = BD_path(X,U,p)
    % initialize
    path = [];

    % position path constraint
    path1 = X(:,1)-p.prob.l;

    % combine
    path = [path;reshape(path1,[],1)];     
end