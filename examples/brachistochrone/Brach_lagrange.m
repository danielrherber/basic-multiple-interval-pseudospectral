%--------------------------------------------------------------------------
% Brach_lagrange.m
% Brachistochrone Lagrange term
%--------------------------------------------------------------------------
% L = Brach_lagrange(x,p,i)
% x: scaled optimization vector
% p: parameter structure
% i: interval number
% L: Lagrange term
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function L = Brach_lagrange(x,p,i)
    % extract from optimization vector
    X = reshape(x(1:p.ns*p.nt),p.nt,[]); % states
    U = reshape(x(p.ns*p.nt+1:end-1),p.nt,[]); % controls
    % Lagrange term values for this segment
    L = zeros(p.Narray(i),1);
    
end