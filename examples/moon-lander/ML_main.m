%--------------------------------------------------------------------------
% ML_main.m
% - Main script for the moon lander problem
% - Define the mesh and method, then solve and plot solution
%--------------------------------------------------------------------------
% ML_main
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
p.func.deriv = @ML_deriv; % derivative function name
p.func.lagrange = @ML_lagrange; % Lagrange term function name
p.func.mayer = @ML_mayer; % Mayer term function name
p.func.path = @ML_path; % path constraint function name
p.func.boundary = @ML_boundary; % boundary constraint function name
p.func.plot = @ML_plot; % plot function name
p.func.bounds = @ML_bounds; % variables bounds function name
p.func.initial = @ML_initial; % initial guess function name

% problem specific parameters
prob.h0 = 10; prob.hf = 0; % position boundary conditions
prob.v0 = -2; prob.vf = 0; % velocity boundary conditions
prob.g = 1.5; % gravity
prob.umax = 3; % maximum control
prob.tmax = 200; % maximum allowable tf
prob.t0 = 0; % initial time (required)
prob.tf = 2; % final time (required)
p.prob = prob;

% number of states and controls
p.ns = 2; % states
p.nu = 1; % controls

% variable final time problem
p.varTF = 1; % 0:no, 1:yes

%--- options ---%
% pseudospectral method
p.opts.method = 'LGL'; % either LGL or CGL

% scale problem
p.opts.scale = 0; % 0:no, 1:yes

% plot flag
p.opts.plotflag = 1; % 0:no, 1:yes

% save flag
p.opts.saveflag = 1; % 0:no, 1:yes

% mesh number
mesh = 11;

% switch statement for case studies
switch mesh
    case 1
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 5; % number of nodes per segment (same size as p.Tarray)
    case 2
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 10; % number of nodes per segment
    case 3
        p.Tarray = [0,5]; % segment boundaries
        p.Narray = 20; % number of nodes per segment
    case 4
        p.Tarray = [0,5]; % segment boundaries
        p.Narray = 50; % number of nodes per segment
    case 5
        p.Tarray = linspace(0,1,4); % segment boundaries
        p.Narray = 3*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 6
        p.Tarray = linspace(0,1,7); % segment boundaries
        p.Narray = 3*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 7
        p.Tarray = linspace(0,1,11); % segment boundaries
        p.Narray = 3*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 8
        p.Tarray = linspace(0,1,4); % segment boundaries
        p.Narray = 7*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 9
        p.Tarray = linspace(0,1,7); % segment boundaries
        p.Narray = 7*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 10
        p.Tarray = linspace(0,1,11); % segment boundaries
        p.Narray = 7*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 11 % exact
        p.Tarray = [0,1.41540375041177,4.16414083415688]; % segment boundaries
        p.Narray = [3 3]; % number of nodes per segment
    case 12
        p.Tarray = [0,1.41540375041177,4.16414083415688]; % segment boundaries
        p.Narray = [10 10]; % number of nodes per segment
end

%--- solve and plot ---%
% solve the problem
[t,X,U,f,p] = PS_Solve(p);

% plot the solution
if p.opts.plotflag
    p.func.plot(t,X,U,f,p)
end