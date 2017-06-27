%--------------------------------------------------------------------------
% ML_initial.m
% Moon lander initial guess function
% outputs and initial guess for the given mesh
%--------------------------------------------------------------------------
% f = ML_initial(tau,X,U,t0,tf,p)
%  p: parameter structure
% x0: initial guess vector
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function x0 = ML_initial(p)
	% linear guess functions
	fXguess = @(t) (p.prob.hf - p.prob.h0)/(p.t{end}(end) - p.t{1}(1))*t + p.prob.h0;
	fVguess = @(t) (p.prob.vf - p.prob.v0)/(p.t{end}(end) - p.t{1}(1))*t + p.prob.v0;
	fUguess = @(t,u0,uf) (uf - u0)/(p.t{end}(end) - p.t{1}(1))*t + u0;
	Xguess = []; Vguess = []; Uguess = [];
	for i = 1:length(p.Narray)
	    Xguess = [Xguess;fXguess(p.t{i})]; % position initial guess
	    Vguess = [Vguess;fVguess(p.t{i})]; % velocity initial guess
	    Uguess = [Uguess;fUguess(p.t{i},0,0)]; % control initial guess
	end

    % final time guess
    tguess = p.prob.tf;

	% combine to column vector
	x0 = [reshape(Xguess,[],1);reshape(Vguess,[],1);reshape(Uguess,[],1);tguess];

end