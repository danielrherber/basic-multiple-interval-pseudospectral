%--------------------------------------------------------------------------
% Brach_mayer.m
% Brachistochrone Mayer term
%--------------------------------------------------------------------------
% m = Brach_mayer(x,p)
% x: scaled optimization vector
% p: parameter structure
% m: Mayer term
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function m = Brach_mayer(x,p)
    % extract from optimization vector
    X = reshape(x(1:p.ns*p.nt),p.nt,[]); % states
    U = reshape(x(p.ns*p.nt+1:end-1),p.nt,[]); % controls
	tf = x(end); % final time
    % Lagrange term values for this segment
    m = tf;
end