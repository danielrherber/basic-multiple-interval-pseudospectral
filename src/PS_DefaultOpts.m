%--------------------------------------------------------------------------
% PS_DefaultOpts.m
% set (and lists) defaults
%--------------------------------------------------------------------------
% p = PS_DefaultOpts(p)
% p: parameter structure
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function p = PS_DefaultOpts(p)

    % check if opts field exists
    if ~isfield(p,'opts')
        p.opts = [];
    end

    % pseudospectral method
    if ~isfield(p.opts,'method')
        p.opts.method = 'LGL';
%         p.opts.method = 'CGL';
    end

    % scale problem
    if ~isfield(p.opts,'scale')
%         p.opts.scale = 1; % yes
        p.opts.scale = 0; % no
    end

    % plot flag
    if ~isfield(p.opts,'plotflag')
        p.opts.plotflag = 1; % yes
%         p.opts.plotflag = 0; % no
    end

    % save flag
    if ~isfield(p.opts,'saveflag')
%         p.opts.saveflag = 1; % yes
        p.opts.saveflag = 0; % no
    end

    % fmincon options
%     p.opts.fmincon = [];
    
end