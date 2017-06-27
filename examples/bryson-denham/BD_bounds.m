%--------------------------------------------------------------------------
% BD_bounds.m
% Bryson-Denham variable bounds function
% outputs the simple variable bounds
%--------------------------------------------------------------------------
% p = BD_bounds(p)
% p: parameter structure (needs p.xL and p.xU)
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function p = BD_bounds(p)
	% state bounds
	XL = -1*ones(p.nt,p.ns); % lower
	XU = 1*ones(p.nt,p.ns); % upper

	% control bounds
	UL = -20*ones(p.nt,p.nu); % lower
	UU = 20*ones(p.nt,p.nu); % upper

	% combine to column vector
	p.xL = [reshape(XL,[],1);reshape(UL,[],1)]; 
	p.xU = [reshape(XU,[],1);reshape(UU,[],1)];

end