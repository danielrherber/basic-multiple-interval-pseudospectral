%--------------------------------------------------------------------------
% BD_lagrange.m
% Bryson-Denham Lagrange term
%--------------------------------------------------------------------------
% L = BD_lagrange(x,p,i)
% x: scaled optimization vector
% p: parameter structure
% i: interval number
% L: Lagrange term
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function L = BD_lagrange(x,p,i)
    % extract from optimization vector
    X = reshape(x(1:p.ns*p.nt),p.nt,[]); % states
    U = reshape(x(p.ns*p.nt+1:end),p.nt,[]); % controls

    % Lagrange term values for this segment
    L = 1/2*U(p.cumN(i)+1:p.cumN(i+1),1).^2;
end