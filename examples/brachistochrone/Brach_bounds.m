%--------------------------------------------------------------------------
% Brach_bounds.m
% Brachistochrone variable bounds function
% outputs the simple variable bounds
%--------------------------------------------------------------------------
% p = Brach_bounds(p)
% p: parameter structure (needs p.xL and p.xU)
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function p = Brach_bounds(p)

	% state bounds
	XL = kron([-inf;-inf;0],ones(p.nt,1)); % lower
	XU = kron([inf;inf;inf],ones(p.nt,1)); % upper
    
	% control bounds
	UL = -pi/2*ones(p.nt,p.nu); % lower
	UU = pi*ones(p.nt,p.nu); % upper
    
    % time bounds
    tL = 0;
    tU = p.prob.tmax;

	% combine to column vector
	p.xL = [reshape(XL,[],1);reshape(UL,[],1);tL]; 
	p.xU = [reshape(XU,[],1);reshape(UU,[],1);tU];

end