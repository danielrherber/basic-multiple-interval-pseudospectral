%--------------------------------------------------------------------------
% BD_solution.m
% creates the analytic solution 
% note this closed-form solution is only valid for 0 < l < 1/6
%--------------------------------------------------------------------------
% Can be found on page 122:
% Bryson, A E and Y-C Ho. Applied Optimal Control: Optimization,
% Estimation, and Control, revised edition, Taylor & Francis, 1975.
%--------------------------------------------------------------------------
% [t,X,U,f] = BD_solution(t,p,flag)
%    t: time
%    p: parameter structure
% flag: boolean to determine if a large number of ED points time points
%    X: state solution
%    U: control solution
%    f: objective function value
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function [t,X,U,f] = BD_solution(t,p,flag)

    % large number of points? otherwise use original
    if flag == 1
        t = linspace(t(1),t(end),10000)';
    end

    % extract parameter
    l = p.prob.l;
    
    % loop time values
    for i = 1:length(t)
        if (t(i) <= 3*l)
            u = -2/(3*l)*(1-t(i)/(3*l));
            v = (1 - t(i)/(3*l)).^2;
            x = l*(1 - (1 - t(i)/(3*(l))).^3);
        elseif (t(i) >= 1-3*l)
            u = -2/(3*l)*(1 - (1-t(i))/(3*l));
            v = -(1 - (1-t(i))/(3*l)).^2;
            x = l*(1 - (1 - (1-t(i))/(3*(l))).^3);
        else
            u = 0;
            v = 0;
            x = l;
        end

        % create the control matrix
        U(i,:) = u;

        % create the state matrix
        X(i,:) = [x,v];
    end

    % objective function    
    f = 4/(9*l);
end