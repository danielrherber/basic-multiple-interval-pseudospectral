%--------------------------------------------------------------------------
% BD_initial.m
% Bryson-Denham initial guess function
% outputs and initial guess for the given mesh
%--------------------------------------------------------------------------
% f = BD_initial(tau,X,U,t0,tf,p)
%  p: parameter structure
% x0: initial guess vector
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function x0 = BD_initial(p)
	% linear guess functions
	fX0 = @(t) (p.prob.pf - p.prob.p0)/(p.t{end}(end) - p.t{1}(1))*t + p.prob.p0;
	fV0 = @(t) (p.prob.vf - p.prob.v0)/(p.t{end}(end) - p.t{1}(1))*t + p.prob.v0;
	fU0 = @(t,u0,uf) (uf - u0)/(p.t{end}(end) - p.t{1}(1))*t + u0;
	X0 = []; V0 = []; U0 = [];
	for i = 1:length(p.Narray)
	    X0 = [X0;fX0(p.t{i})]; % position initial guess
	    V0 = [V0;fV0(p.t{i})]; % velocity initial guess
	    U0 = [U0;fU0(p.t{i},0,0)]; % control initial guess
	end

	% combine to column vector
	x0 = [reshape(X0,[],1);reshape(V0,[],1);reshape(U0,[],1)];

end