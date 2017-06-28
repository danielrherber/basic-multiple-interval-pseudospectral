%--------------------------------------------------------------------------
% PS_Nonlincon.m
% nonlinear constraint function for multiple-interval pseudospectral methods
% defect equality constraints
% continuity equality constraints
% boundary equality constraints
% path inequality constraints
%--------------------------------------------------------------------------
% [c,ceq] = PS_Nonlincon(x,p)
%   x: scaled optimization variable vector
%   p: parameter structure
%   c: inequality constraint vector
% ceq: equality constraint vector
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function [c,ceq] = PS_Nonlincon(x,p)

    %--- preliminaries ---%
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
    
    % initialize constraints
    c = []; ceq = []; contin = [];
    % extract from optimization vector
    X = reshape(x(1:p.ns*p.nt),p.nt,[]); % states
    if p.varTF == 1
        U = reshape(x(p.ns*p.nt+1:end-1),p.nt,[]); % controls
    else
        U = reshape(x(p.ns*p.nt+1:end),p.nt,[]); % controls
    end
    
    %--- equality constraints ---%
    % determine defect constraints for each segment
    for i = 1:length(p.Narray)
        Xi = X(p.cumN(i)+1:p.cumN(i+1),:); % states for segment i
        Ui = U(p.cumN(i)+1:p.cumN(i+1),:); % controls for segment i
        D = p.D{i}; % differentiation matrix
        F = PS_Fmatrix(p.tau{i},Xi,Ui,p.t0(i),p.tf(i),p); % differential matrix
        defect{i,1} = D*Xi - F; % defect constraints
    end
    ceq = [ceq;reshape(cell2mat(defect),[],1)];
    
    % state and control continuity constraints between segments
    for i = 2:length(p.Narray)
        contin{i-1,1} = X(p.cumN(i),:) - X(p.cumN(i)+1,:);
    end
    ceq = [ceq;reshape(cell2mat(contin),[],1)];

    % boundary constraints
    boundary = p.func.boundary(X,U,p);
    ceq = [ceq;reshape(boundary,[],1)];
    
    %--- inequality constraints ---%
    % path constraints
    path = p.func.path(X,U,p);
    c = [c;reshape(path,[],1)];
end