%--------------------------------------------------------------------------
% PS_Scaling.m
% scaling function that changes variable bounds to be between 0 and 1 and
% vice versa
% needs vector inputs
%--------------------------------------------------------------------------
% x_out = PS_Scaling(x,l,u,type)
%    x: input variable vector
%    l: unscaled lower bound
%    u: unscaled upper bound
% type: scale (1) or unscale (2)
% x_out: output variable vector
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function x_out = PS_Scaling(x,l,u,type)
    if type == 1
        x_out = (x-l)./(u-l); % scale
    elseif type == 2
        x_out = l + x.*(u-l); % unscale
    else
        error('wrong type')
    end
end