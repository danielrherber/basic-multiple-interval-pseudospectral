%--------------------------------------------------------------------------
% ML_plot.m
% Moon lander plotting function
%--------------------------------------------------------------------------
% ML_plot(t,X,U,f,p)
% t: time
% X: state
% U: control
% f: objective function value
% p: parameter structure
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function ML_plot(t,X,U,f,p)

    %% --- interpolate
    % interpolate the solution with the specified polynomials
    interpN = 2000; % number of linearly spaced interpolation points
    for i = 1:length(p.Narray)
        % interpolate based on method
        tarray1{i} = linspace(p.t0(i),p.tf(i),interpN);
        interpX1{1,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),1)',tarray1{i});
        interpX1{2,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),2)',tarray1{i});
        interpU1{1,i} = LagrangeInter(p.t{i}',U(p.cumN(i)+1:p.cumN(i+1),1)',tarray1{i});
    end

    % create column vectors
    tarray = cell2mat(tarray1)';
    interpX = cell2mat(interpX1)';
    interpU = cell2mat(interpU1)';

    %% --- plot parameters
    % fonts
    font1 = 18; % font size parameter
    font2 = 12;

    % colors
    wcolor = [1 1 1]; % white color
    bcolor = [0 0 0]; % black color
    xc = [0.7 0.7 0.7];
    vc = [0 0 0];
    uc = [0.8500 0.3250 0.0980];
    lc = [76,175,80]/255;

    % defaults
    set(0,'DefaultTextInterpreter','latex'); % change the text interpreter
    set(0,'DefaultLegendInterpreter','latex'); % change the legend interpreter
    set(0,'DefaultAxesTickLabelInterpreter','latex'); % change the tick interpreter

    %% --- plot states and control
    hf = figure;
    hf.Color = wcolor; % change the figure background color

    % plot lagrange polynomials
    h1 = plot(tarray,[interpX,interpU],'linewidth',2); hold on
    h1(1).Color = xc;
    h1(2).Color = vc;
    h1(3).Color = uc;

    % plot DT nodes
    h2 = plot(t,[X,U],'linestyle','none','Marker','o','linewidth',2); hold on
    h2(1).Color = xc;
    h2(2).Color = vc;
    h2(3).Color = uc;

    % labels
    ylabel('$h$ [m], $v$ [m/s], $u$ [m/s$^2$]','interpreter','latex','fontsize',font1) % left y-axis
    xlabel('$t$ (s)','interpreter','latex','fontsize',font1);

    % axis color
    ha = gca; % get current axis handle
    ha.XAxis.Color = bcolor; % change the x axis color to black (not a dark grey)
    ha.YAxis.Color = bcolor; % change the y axis color to black (not a dark grey)

    % legend
    hL = legend('$x_{\mathrm{interp}}$','$v_{\mathrm{interp}}$',...
        '$u_{\mathrm{interp}}$',['$x_{\mathrm{',p.opts.method,'}}$'],...
        ['$v_{\mathrm{',p.opts.method,'}}$'],['$u_{\mathrm{',p.opts.method,'}}$']);
    set(hL,'orientation','horizontal','interpreter','latex',...
        'Position',[0.03,0.93,0.95,0.08],'box','off')
    hL.AutoUpdate = 'off';

    % segment boundaries
    for i = 1:length(p.tf)
        h3 = plot([p.tf(i),p.tf(i)],[ha.YLim(1),ha.YLim(2)],'--','Color',lc); hold on
        uistack(h3, 'bottom')
    end

    %% --- plot error between actual solution
    hf = figure;
    hf.Color = wcolor; % change the figure background color

    % get actual solution values
    [~,sMat,uMat,factual,tfactual] = ML_solution(tarray,p,0);

    % plot position error
    error = abs(interpX(:,1)-sMat(:,1));
    results.maxx = max(error);
    plot(tarray,log10(error),'color',xc,'linewidth',2); hold on

    % plot velocity error
    error = abs(interpX(:,2)-sMat(:,2));
    results.maxv = max(error);
    plot(tarray,log10(error),'color',vc,'linewidth',2); hold on

    % plot control error
    error = abs(interpU-uMat);
    results.maxu = max(error);
    plot(tarray,log10(error),'color',uc,'linewidth',2); hold on

    % label and other plotting stuff
    ylabel('absolute error','interpreter','latex','fontsize',font1);
    xlabel('$t$ (s)','interpreter','latex','fontsize',font1);

    % axis color
    ha = gca; % get current axis handle
    ha.XAxis.Color = bcolor; % change the x axis color to black (not a dark grey)
    ha.YAxis.Color = bcolor; % change the y axis color to black (not a dark grey)
    
    % limits
    xlim([p.Tarray(1) p.Tarray(end)]);
    ylim([-18 ha.YLim(2)]);

    % legend
    hL = legend('error $x$','error $v$','error $u$');
    set(hL,'orientation','horizontal','interpreter','latex',...
        'Position',[0.03,0.93,0.95,0.08],'box','off')
    set(hL,'interpreter','latex','fontsize',font1-6);

    % results 
    results.Nt = length(U);
    results.NI = length(p.Narray);
    results.f = f;
    results.ferror = abs(f - factual);
    results.tf = tarray(end);
    results.tferror = abs(tfactual - tarray(end));

    % display results
    format shortE
    disp(results)
    
    % save results and figures
    if p.opts.saveflag
        
        % path to Saved_Data folder
        mypath = msavename(mfilename('fullpath'),'saved');
        
        % prefix
        prefixname = ['MLsol-',p.opts.method,'-Nt_',num2str(results.Nt),'-NI_',num2str(results.NI)];
        
        % figure suffixes
        fignames = {'-sol','-error'};
        
        % save results
        save([mypath,prefixname,'-results','.mat'],'results')
        
        % go through each figure and save
        for i = 1:2
            figure(i)
            
            % save a png version
            pathpng = mfoldername(mfilename('fullpath'),fullfile('saved','png'));
            filename = [pathpng,prefixname,fignames{i}];
            str = ['export_fig ''',filename,''' -png -m4'];
            eval(str)

            % save a pdf version
            pathpdf = mfoldername(mfilename('fullpath'),fullfile('saved','pdf'));
            filename = [pathpdf,prefixname,fignames{i}];
            str = ['export_fig ''',filename,''' -pdf'];
            eval(str)
        
        end
    end
end