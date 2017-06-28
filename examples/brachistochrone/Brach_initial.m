%--------------------------------------------------------------------------
% Brach_initial.m
% Brachistochrone initial guess function
% outputs and initial guess for the given mesh
%--------------------------------------------------------------------------
% f = Brach_initial(tau,X,U,t0,tf,p)
%  p: parameter structure
% x0: initial guess vector
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function x0 = Brach_initial(p)   
	% linear guess functions
	fX0 = @(t) (p.prob.xf - p.prob.x0)/(p.t{end}(end) - p.t{1}(1))*t + p.prob.x0;
    fY0 = @(t) (p.prob.yf - p.prob.y0)/(p.t{end}(end) - p.t{1}(1))*t + p.prob.y0;
	fV0 = @(t,v0,vf) (vf - v0)/(p.t{end}(end) - p.t{1}(1))*t + v0;
	fU0 = @(t,u0,uf) (uf - u0)/(p.t{end}(end) - p.t{1}(1))*t + u0;
	Xguess = []; Yguess = []; Vguess = []; Uguess = [];
	for i = 1:length(p.Narray)
	    Xguess = [Xguess;fX0(p.t{i})]; % x initial guess
        Yguess = [Yguess;fY0(p.t{i})]; % y initial guess
	    Vguess = [Vguess;fV0(p.t{i},0,1)]; % v initial guess
	    Uguess = [Uguess;fU0(p.t{i},0,pi)]; % u initial guess
	end

    % final time guess
    tguess = p.t{end}(end);

	% combine to column vector
	x0 = [reshape(Xguess,[],1);reshape(Yguess,[],1);reshape(Vguess,[],1);...
        reshape(Uguess,[],1);tguess];
    
end