%--------------------------------------------------------------------------
% ML_bounds.m
% Moon lander variable bounds function
% outputs the simple variable bounds
%--------------------------------------------------------------------------
% p = ML_bounds(p)
% p: parameter structure (needs p.xL and p.xU)
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function p = ML_bounds(p)

	% state bounds
	XL = kron([0;-inf],ones(p.nt,1)); % lower
	XU = kron([inf;inf],ones(p.nt,1)); % upper

	% control bounds
	UL = zeros(p.nt,p.nu); % lower
	UU = p.prob.umax*ones(p.nt,p.nu); % upper
    
    % time bounds
    tL = 0;
    tU = p.prob.tmax;

	% combine to column vector
	p.xL = [reshape(XL,[],1);reshape(UL,[],1);tL]; 
	p.xU = [reshape(XU,[],1);reshape(UU,[],1);tU];

end