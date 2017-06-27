%--------------------------------------------------------------------------
% BD_main.m
% - Main script for solving optimal control problems using 
%   multiple-interval pseudospectral methods
% - Define the mesh and method, then solve and plot solution
% - Note that case 0 can be changed by the user
% - Other cases are based on the technical report of the same name
%--------------------------------------------------------------------------
% BD_main
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
p.func.deriv = @BD_deriv; % derivative function name
p.func.lagrange = @BD_lagrange; % Lagrange term function name
p.func.mayer = @BD_mayer; % Mayer term function name
p.func.path = @BD_path; % path constraint function name
p.func.boundary = @BD_boundary; % boundary constraint function name
p.func.plot = @BD_plot; % plot function name
p.func.bounds = @BD_bounds; % variables bounds function name
p.func.initial = @BD_initial; % initial guess function name

% problem specific parameters
prob.p0 = 0; prob.pf = 0; % position boundary conditions
prob.v0 = 1; prob.vf = -1; % velocity boundary conditions
prob.l = 1/9; % path constraint bound for Bryson-Denham
prob.t0 = 0; % initial time (required)
prob.tf = 1; % initial time (required)
p.prob = prob;

% number of states and controls
p.ns = 2; % states
p.nu = 1; % controls

% variable final time problem
p.varTF = 0; % 0:no, 1:yes

%--- options ---%
% pseudospectral method
p.opts.method = 'LGL'; % either LGL or CGL

% scale problem
p.opts.scale = 0; % 0:no, 1:yes

% plot flag
p.opts.plotflag = 1; % 0:no, 1:yes

% save flag
p.opts.saveflag = 1; % 0:no, 1:yes

% mesh number, see technical report
mesh = 7; % 0 indicates user defined mesh

% switch statement for case studies
switch mesh
    case 0
        %--- user defined mesh ---%
        p.Tarray = linspace(0,1,3); % segment boundaries
        p.Narray = 10*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment (same size as p.Tarray)
        %--- user defined mesh ---%
    case 1
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 4+1; % number of nodes per segment
    case 2
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 9+1; % number of nodes per segment
    case 3
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 19+1; % number of nodes per segment
    case 4
        p.Tarray = linspace(0,1,3); % segment boundaries
        p.Narray = 3*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 5
        p.Tarray = linspace(0,1,3); % segment boundaries
        p.Narray = 5*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 6
        p.Tarray = linspace(0,1,3); % segment boundaries
        p.Narray = 9*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 7 % exact
        p.Tarray = [0,3*p.prob.l,1-3*p.prob.l,1]; % segment boundaries
        p.Narray = [3 1 3]+1; % number of nodes per segment
    case 8
        p.Tarray = [0,3*p.prob.l,1-3*p.prob.l,1]; % segment boundaries
        p.Narray = [5 1 5]+1; % number of nodes per segment
    case 9
        p.Tarray = [0,3*p.prob.l,1-3*p.prob.l,1]; % segment boundaries
        p.Narray = [5 5 5]+1; % number of nodes per segment
    case 10
        p.Tarray = linspace(0,1,6); % segment boundaries
        p.Narray = 3*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 11
        p.Tarray = linspace(0,1,6); % segment boundaries
        p.Narray = 5*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 12
        p.Tarray = linspace(0,1,6); % segment boundaries
        p.Narray = 9*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 13
        p.Tarray = linspace(0,1,11); % segment boundaries
        p.Narray = 3*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 14
        p.Tarray = linspace(0,1,11); % segment boundaries
        p.Narray = 5*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 15
        p.Tarray = linspace(0,1,11); % segment boundaries
        p.Narray = 9*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
end

%--- solve and plot ---%
% solve the problem
[t,X,U,f,p] = PS_Solve(p);

% plot the solution
if p.opts.plotflag
    p.func.plot(t,X,U,f,p)
end