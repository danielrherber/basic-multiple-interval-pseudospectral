%--------------------------------------------------------------------------
% PS_Solve.m
% main function for solving optimal control problems using 
% multiple-interval pseudospectral methods
% note that the problem specific parameters need to be changed if a
% different problem is being solved for
%--------------------------------------------------------------------------
% [t,X,U,f,p] = PS_Solve(p)
% p: parameter structure
% t: time vector
% X: state matrix
% U: control matrix
% f: objective function value
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function [t,X,U,f,p] = PS_Solve(p)
    % default options
    p = PS_DefaultOpts(p);

    %--- problem specific parameters ---%
    p.nt = sum(p.Narray); % total number of nodes

    %--- mesh parameters ---%
    t0 = p.prob.t0; % initial time
    tf = p.prob.tf; % final time
    p.Tarray = PS_Scaling(p.Tarray,p.Tarray(1),p.Tarray(end),1); % scale
    p.cumN = [0,cumsum(p.Narray)]; % segment ending indices
    
    % build segment information
    for i = 1:length(p.Narray)
        if strcmp(p.opts.method,'LGL')
            p.tau{i,1} = LGL_nodes(p.Narray(i)-1); % calculate scaled node locations
            p.w{i,1} = LGL_weights(p.tau{i}); % segment Gaussian quadrature weights
            p.D{i,1} = LGL_Dmatrix(p.tau{i}); % segment differentiation matrix
        elseif strcmp(p.opts.method,'CGL')
            p.tau{i,1} = CGL_nodes(p.Narray(i)-1); % calculate scaled node locations
            p.w{i,1} = CGL_weights(p.tau{i}); % segment Gaussian quadrature weights
            p.D{i,1} = CGL_Dmatrix(p.tau{i}); % segment differentiation matrix
        end
        % unscaled segments
        p.t0(i,1) = PS_Scaling(p.Tarray(i),t0,tf,2); % initial time
        p.tf(i,1) = PS_Scaling(p.Tarray(i+1),t0,tf,2); % final time
        p.t{i,1} = ((1-p.tau{i})*p.t0(i) + (1+p.tau{i})*p.tf(i))/2; % time values
    end

    %--- problem setup ---%
    % variable bounds function
    p = p.func.bounds(p);

    % initial guess
    x0 = p.func.initial(p);

    % potential scaling
    if p.opts.scale == 1
        x0 = PS_Scaling(x0,p.xL,p.xU,1); % scale initial guess
        xL = zeros(size(x0)); xU = ones(size(x0));
    else
        xL = p.xL; xU = p.xU;
    end

    %--- optimization ---%
    % optimization routine options
    options = optimoptions('fmincon','Display','Iter',...
        'Algorithm','sqp','MaxFunEvals',Inf,...
        'OptimalityTolerance', 100*eps, 'StepTolerance', 100*eps);
    
	% additional options
    if isfield(p.opts,'fmincon')
        options = optimoptions(options,p.opts.fmincon);
    end

    % start timer
    tic

    % solve the problem
    [x,f] = fmincon(@(x) PS_Objective(x,p),x0,[],[],[],[],xL,xU,...
        @(x) PS_Nonlincon(x,p),options);

	% end timer
    toc

    %--- extract results ---%
    % potential scaling
    if p.opts.scale == 1
        x = PS_Scaling(x,p.xL,p.xU,2); % unscale design variables
    end

    % extract from optimization vector 
    X = reshape(x(1:p.ns*p.nt),p.nt,[]); % states
    if p.varTF == 1
        U = reshape(x(p.ns*p.nt+1:end-1),p.nt,[]); % controls

        % update Tarray
        tf = x(end); % final time (final optimal value)
        p.Tarray = PS_Scaling(p.Tarray,t0,tf,2); % unscale

        % update unscaled segments
        for i = 1:length(p.Narray)
            p.t0(i,1) = p.Tarray(i); % initial time
            p.tf(i,1) = p.Tarray(i+1); % final time
            p.t{i,1} = ((1-p.tau{i})*p.t0(i) + (1+p.tau{i})*p.tf(i))/2;
        end

    else
        U = reshape(x(p.ns*p.nt+1:end),p.nt,[]); % controls
    end

    % unscaled time vector
    t = cell2mat(p.t);

end