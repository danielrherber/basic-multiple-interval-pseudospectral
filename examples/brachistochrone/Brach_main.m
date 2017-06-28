%--------------------------------------------------------------------------
% Brach_main.m
% - Main script for the Brachistochrone problem
% - Define the mesh and method, then solve and plot solution
%--------------------------------------------------------------------------
% Brach_main
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
clc
clear
close all

%--- problem specification ---%
% problem functions
p.func.deriv = @Brach_deriv; % derivative function name
p.func.lagrange = @Brach_lagrange; % Lagrange term function name
p.func.mayer = @Brach_mayer; % Mayer term function name
p.func.path = @Brach_path; % path constraint function name
p.func.boundary = @Brach_boundary; % boundary constraint function name
p.func.plot = @Brach_plot; % plot function name
p.func.bounds = @Brach_bounds; % variables bounds function name
p.func.initial = @Brach_initial; % initial guess function name

% problem specific parameters
prob.x0 = 0; prob.y0 = 0; prob.v0 = 0; % initial conditions
prob.xf = 10; prob.yf = 2;  % final conditions
prob.g = 10; % gravity
prob.tmax = 100; % maximum allowable tf
prob.t0 = 0; % initial time (required)
prob.tf = 10; % final time (required)
p.prob = prob;

% number of states and controls
p.ns = 3; % states
p.nu = 1; % controls

% variable final time problem
p.varTF = 1; % 0:no, 1:yes

%--- options ---%
% pseudospectral method
p.opts.method = 'CGL'; % either LGL or CGL

% scale problem
p.opts.scale = 0; % 0:no, 1:yes

% plot flag
p.opts.plotflag = 1; % 0:no, 1:yes

% save flag
p.opts.saveflag = 0; % 0:no, 1:yes

% additional fmincon options
p.opts.fmincon.MaxIter = 2000;

% mesh number
mesh = 7;

% switch statement for case studies
switch mesh
    case 1
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 5; % number of nodes per segment (same size as p.Tarray)
    case 2
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 10; % number of nodes per segment
    case 3
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 20; % number of nodes per segment
    case 4
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 50; % number of nodes per segment
    case 5
        p.Tarray = linspace(0,1,3); % segment boundaries
        p.Narray = 4*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 6
        p.Tarray = linspace(0,1,3); % segment boundaries
        p.Narray = 10*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 7
        p.Tarray = linspace(0,1,3); % segment boundaries
        p.Narray = 20*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 8
        p.Tarray = linspace(0,1,4); % segment boundaries
        p.Narray = 10*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 9
        p.Tarray = linspace(0,1,6); % segment boundaries
        p.Narray = 10*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 10
        p.Tarray = linspace(0,1,8); % segment boundaries
        p.Narray = 10*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
end

%--- solve and plot ---%
% solve the problem
[t,X,U,f,p] = PS_Solve(p);

% plot the solution
if p.opts.plotflag
    p.func.plot(t,X,U,f,p)
end