%--------------------------------------------------------------------------
% PS_Objective.m
% objective function for multiple-interval pseudospectral methods
% calculates Lagrange and Mayer terms
%--------------------------------------------------------------------------
% fobj = PS_Objective(x,p)
%    x: scaled optimization variable vector
%    p: parameter structure
% fobj: PS_objective function value
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function fobj = PS_Objective(x,p)
    % scale
    if p.opts.scale == 1
        x = PS_Scaling(x,p.xL,p.xU,2); % unscale design variables
    end
    
    % update segment boundaries with current tf
    if p.varTF == 1
        % get old values
        t0 = p.t0(1); tf = p.tf(end);
        % scale to 0 to 1
        p.t0 = PS_Scaling(p.t0,t0,tf,1); % scale
        p.tf = PS_Scaling(p.tf,t0,tf,1); % scale
        % new tf value
        tf = x(end);
        % update segment boundaries
        p.t0 = PS_Scaling(p.t0,t0,tf,2); % unscale
        p.tf = PS_Scaling(p.tf,t0,tf,2); % unscale
    end
    
    % determine integral value
    fobj = 0; % initialize
    for i = 1:length(p.Narray) % for each segment
        h = p.func.lagrange(x,p,i); % obtain segment Lagrange term values
        fobj = fobj + (p.tf(i)-p.t0(i))/2*p.w{i}'*h; % Gaussian quadrature  
    end
    
    % determine Mayer term value
    M = p.func.mayer(x,p);
    fobj = fobj + M;
end