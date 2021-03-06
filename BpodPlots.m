%% SAVEPATH

laptoppath = 'C:\Users\jbuss\Dropbox\BpodInfoseek\Data\Graphs';

if exist('D:\Dropbox\BpodInfoseek\Graphs')
  pathname = 'D:\Dropbox\BpodInfoseek\Graphs';
elseif exist(laptoppath)
    pathname = laptoppath;
else   
  pathname=uigetdir('','Choose save directory');
end

%% PLOTTING COLORS AND LABELS

purple = [121 32 196] ./ 255;
orange = [251 139 6] ./ 255;
cornflower = [100 149 237] ./ 255;
grey = [.8 .8 .8];

CCfinal = [0.2,0.2,0.2; %choice no choice
    0.474509803921569,0.125490196078431,0.768627450980392; %choice info big
    171/255,130/255,1; % choice info big NP
    0.9490, 0.8, 1.0; %choiceinfosmall
    238/255,224/255,229/255; %choiceinfoNPsmall    
    0.984313725490196,0.545098039215686,0.0235294117647059; %choice rand big
    245/255,222/255,179/255; % choice rand big NP
    1, 0.8, 0.0; %choice rand small
    244/255, 164/255, 96/255; %choice rand small NP
    0.6,0.6,0.6; %info no choice
    0,1,0; %info big
    152/255,251/255,152/255;% info big NP
    1,0,1; %infosmall
    1,192/255,203/255; %info small not present
    0.0,0.0,0.0; %infoincorrect
    0.2,0.2,0.2;% rand no choice
    0,0,1; %rand big
    135/255,206/255,1; % rand big NP
    0,1,1; %rand small
    187/255,1,1; %rand small NP
    0.0,0.0,0.0]; %rand incorrect

CCNP = [0.474509803921569,0.125490196078431,0.768627450980392; %choice info big
    0.9490, 0.8, 1.0; %choiceinfosmall  
    0.984313725490196,0.545098039215686,0.0235294117647059; %choice rand big
    1, 0.8, 0.0; %choice rand small
    0,1,0; %info big
    1,0,1; %infosmall
    0,0,1; %rand big
    0,1,1]; %rand small

a.choiceLabels = {'ChoiceInfoBig','ChoiceInfoSmall','ChoiceRandBig',...
    'ChoiceRandSmall','InfoBig','InfoSmall','RandBig','RandSmall'};

a.outcomeLabels = {'ChoiceNoChoice','ChoiceInfoBig','ChoiceInfoBigNP',...
    'ChoiceInfoSmall','ChoiceInfoSmallNP','ChoiceRandBig','ChoiceRandBigNP',...
    'ChoiceRandSmall','ChoiceRandSmallNP','InfoNoChoice','InfoBig',...
    'InfoBigNP','InfoSmall','InfoSmallNP','InfoIncorrect','RandNoChoice',...
    'RandBig','RandBigNP','RandSmall','RandSmallNP',...
    'RandIncorrect'};


%% PLOT DAY SUMMARIES BY MOUSE FOR CURRENT MICE

m=4;
for m = 1:a.mouseCt

    figure();
    
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0 0 11 8.5];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');
    
    ax = nsubplot(3,2,1,1);
    title(a.mouseList(m));
    ax.FontSize = 8;
%     set(ax,'units','inches');
%     ax.Position = [1 1 5 1];

    % if there's choice
%     if sum(isnan(cell2mat(a.daySummary.percentInfo(m,:)))) ~= a.mouseDayCt(m)
    if sum(a.mouseTrialTypes{m}==5) > 0
        ax.XTick = [0:5:a.mouseDayCt(m)];    
        ax.YTick = [0 0.25 0.50 0.75 1];
        ax.YLim = [-0.1 1.1];
        plot(0,0,'Marker','none');
        plot(1:a.mouseDayCt(m),[cell2mat(a.daySummary.percentInfo(m,:))],'Color',[.5 .5 .5],'LineWidth',2,'Marker','o','MarkerSize',3);
        plot([-10000000 1000000],[0.5 0.5],'k','xliminclude','off','color',[0.8 0.8 0.8],'LineWidth',1);  
        ylabel({'Info choice', 'probability'}); %ylabel({'line1', 'line2','line3'},)
        xlabel('Day');
        hold off;
    else
%         if a.mouseDayCt(m)>10
            ax.XTick = [0:5:a.mouseDayCt(m)];
%         end
%         ax.XLim = [1 a.mouseDayCt(m)]; 
        xlabel('Day')
        plot(1:a.mouseDayCt(m),cell2mat(a.daySummary.totalCorrectTrials(m,:)),'Color','k','LineWidth',1,'Marker','o','MarkerFaceColor','k','MarkerSize',2);
        ylabel('TotalCorrectTrials');
%         ax.YLim = [0 100];
%         ax.YTick = [0 25 50 75 100];
    %     ax.YColor = 'k';
        hold off;
    end
    
    
    ax = nsubplot(3,2,2,1);
    ax.FontSize = 8;
%     ax.XTick = [0:5:max(cell2mat(a.daySummary.day(m,:)))];
%     ax.YLim = [0 2];
    ax.XLim = [0.5 21.5];
    ax.XTick = [];
    outcomes = a.daySummary.outcome{m,a.mouseDayCt(m)};
    [outcomeCounts,outcomeBins] = histcounts(outcomes,[0.5:1:21.5]);
    ylabel('# of trials');
    % ax.YLim = [0 1];
    % ax.YTick = [0:0.25:1];
    % ax.XLim = [0 1.5];
    colormap(fig,CCfinal);
    for i = 1:numel(outcomeCounts)
        bar(i,outcomeCounts(i),'FaceColor',CCfinal(i,:),'EdgeColor','none');
    end
    xlabel('Outcome');
%     lgd = legend(ax,a.outcomeLabels,'Location','southoutside','Orientation','horizontal');
%     lgd.Box = 'off';
%     lgd.FontWeight = 'bold'; 
    hold off;3
    
    ax = nsubplot(3,2,3,1);
    ax.FontSize = 8;
    ax.XTick = [0:5:max(cell2mat(a.daySummary.day(m,:)))];
    ax.YLim = [0 2];
    plot(cell2mat(a.daySummary.rxnInfoForced(m,:)),'Color',purple,'LineWidth',1);
    plot(cell2mat(a.daySummary.rxnInfoChoice(m,:)),'Color',purple,'LineWidth',1,'LineStyle',':');
    plot(cell2mat(a.daySummary.rxnRandForced(m,:)),'Color',orange,'LineWidth',1);
    plot(cell2mat(a.daySummary.rxnRandChoice(m,:)),'Color',orange,'LineWidth',1,'LineStyle',':');
%     for r = 1:numel(cell2mat(a.reverseDay(m,:)))
%         plot([a.reverseDay{m,r}-0.5 a.reverseDay{m,r}-0.5],[-10000000 1000000],'k','yliminclude','off','xliminclude','off','LineWidth',1);
%     end
    ylabel({'Reaction', 'Time (s)'});
    xlabel('Day');    
    leg = legend(ax,['Info' newline '-Forced'],['Info' newline '-Choice'],['No Info' newline '-Forced'],['No Info' newline '-Choice'],'Location','southoutside','Orientation','horizontal');
    leg.Box = 'off';
    leg.FontWeight = 'bold';
    hold off;

%     ax = nsubplot(4,2,2,2);
%     ax.FontSize = 8;
%     ax.XTick = [0:5:max(cell2mat(a.daySummary.day(m,:)))];
%     ax.YLim = [0 inf];
%     plot(cell2mat(a.daySummary.ARewards(m,:)),'Color','g','LineWidth',1);
%     plot(cell2mat(a.daySummary.BRewards(m,:)),'Color','m','LineWidth',1);
%     plot(cell2mat(a.daySummary.CRewards(m,:)),'Color',cornflower,'LineWidth',1);
%     plot(cell2mat(a.daySummary.DRewards(m,:)),'Color',cornflower,'LineWidth',1,'LineStyle',':');
%     plot(cell2mat(a.daySummary.randBigRewards(m,:)),'Color','c','LineWidth',1);
%     plot(cell2mat(a.daySummary.randSmallRewards(m,:)),'Color','b','LineWidth',1);
%     for r = 1:numel(cell2mat(a.reverseDay(m,:)))
%         plot([a.reverseDay{m,r}-0.5 a.reverseDay{m,r}-0.5],[-10000000 1000000],'k','yliminclude','off','xliminclude','off','LineWidth',1);
%     end     
%     ylabel({'Mean Reward', '(uL)'});
% %     xlabel('Day');
%     if ismember(m,find(a.noneMice))
%     leg = legend(ax,['Info' newline '-Rew'],['Info' newline '-No Rew'],['No Info' newline '-C'],['No Info' newline '-D'],['No Info' newline '-Rew'],['No Info' newline '-No Rew'],'Location','southoutside','Orientation','horizontal');
%     else
%     leg = legend(ax,['Info' newline '-Big'],['Info' newline '-Small'],['No Info' newline '-C'],['No Info' newline '-D'],['No Info' newline '-Big'],['No Info' newline '-Small'],'Location','southoutside','Orientation','horizontal');        
%     end
%     leg.Box = 'off';
%     leg.FontWeight = 'bold';
%     hold off;
%     
%     ax = nsubplot(4,2,3,2);
%     ax.FontSize = 8;
%     ax.XTick = [0:5:max(cell2mat(a.daySummary.day(m,:)))];
% %     ax.YLim = [6000 20000];
%     plot(cell2mat(a.daySummary.trialLengthEntryInfoForced(m,:)),'Color',purple,'LineWidth',2,'Marker','o','MarkerFaceColor',purple,'MarkerSize',3);
%     plot(cell2mat(a.daySummary.trialLengthEntryInfoChoice(m,:)),'Color',purple,'LineWidth',2,'Marker','o','MarkerFaceColor',purple,'MarkerSize',3,'LineStyle',':');
%     plot(cell2mat(a.daySummary.trialLengthEntryRandForced(m,:)),'Color',orange,'LineWidth',2,'Marker','o','MarkerFaceColor',orange,'MarkerSize',3);
%     plot(cell2mat(a.daySummary.trialLengthEntryRandChoice(m,:)),'Color',orange,'LineWidth',2,'Marker','o','MarkerFaceColor',orange,'MarkerSize',3,'LineStyle',':');
%     plot([a.reverseDay(m)-0.5 a.reverseDay(m)-0.5],[-10000000 1000000],'k','yliminclude','off','xliminclude','off','LineWidth',4);
%     ylabel({'Trial', 'duration (ms)'});
% %     xlabel('Day');
%     leg = legend(ax,'Info Forced','Info Choice','No Info Forced','No Info Choice','Location','southoutside','Orientation','horizontal');
%     leg.Box = 'off';
%     leg.FontWeight = 'bold';
%     hold off;

    ax = nsubplot(3,2,1,2);
    ax.FontSize = 8;
    title(a.fileDayCell{find(a.fileMouse == m & a.fileDay == a.mouseDayCt(m),1,'first')});    
    ax.XTick = [0:5:max(cell2mat(a.daySummary.day(m,:)))];
%     ax.YLim = [6000 20000];
    plot(cell2mat(a.daySummary.infoIncorr(m,:)),'Color',purple,'LineWidth',1);
    plot(cell2mat(a.daySummary.randIncorr(m,:)),'Color',orange,'LineWidth',1);
    plot(cell2mat(a.daySummary.choiceIncorr(m,:)),'Color',[0.5 0.5 0.5],'LineWidth',1);
%     for r = 1:numel(cell2mat(a.reverseDay(m,:)))
%         plot([a.reverseDay{m,r}-0.5 a.reverseDay{m,r}-0.5],[-10000000 1000000],'k','yliminclude','off','xliminclude','off','LineWidth',1);
%     end
    ylabel('Error rate');
%     xlabel('Day');
    leg = legend(ax,'Info','No Info','Choice','Location','southoutside','Orientation','horizontal');
    leg.Box = 'off';
    leg.FontWeight = 'bold';
    hold off;

    ax = nsubplot(3,2,2,2);
    ax.FontSize = 8;
    ax.XTick = [0:5:a.mouseDayCt(m)];
    incomplete = cell2mat(a.dayIncomplete(:,:,m));
    for i=1:8
        plot(incomplete(i,:),'Color',CCNP(i,:))
    end
    xlabel('Day')
    ylabel('Not Present')

    ax = nsubplot(3,2,3,2);
    ax.FontSize = 8;
    ax.XTick = [0:5:max(cell2mat(a.daySummary.day(m,:)))];
%     ax.YLim = [0 25];
    plot(cell2mat(a.daySummary.rewardRateInfoForced(m,:)),'Color',purple,'LineWidth',1);
    plot(cell2mat(a.daySummary.rewardRateRandForced(m,:)),'Color',orange,'LineWidth',1);
    plot(cell2mat(a.daySummary.rewardRateChoice(m,:)),'Color',[0.5 0.5 0.5],'LineWidth',1);
%     plot(cell2mat(a.daySummary.rewardRateInfoForced(m,:)),'Color',purple,'LineWidth',2,'Marker','o','MarkerFaceColor',purple,'MarkerSize',3);
%     plot(cell2mat(a.daySummary.rewardRateInfoChoice(m,:)),'Color',purple,'LineWidth',2,'Marker','o','MarkerEdgeColor',purple,'MarkerFaceColor','w','MarkerSize',3,'LineStyle',':');
%     plot(cell2mat(a.daySummary.rewardRateRandForced(m,:)),'Color',orange,'LineWidth',2,'Marker','o','MarkerFaceColor',orange,'MarkerSize',3);
%     plot(cell2mat(a.daySummary.rewardRateRandChoice(m,:)),'Color',orange,'LineWidth',2,'Marker','o','MarkerEdgeColor',orange,'MarkerFaceColor','w','MarkerSize',3,'LineStyle',':');
%     for r = 1:numel(cell2mat(a.reverseDay(m,:)))
%         plot([a.reverseDay{m,r}-0.5 a.reverseDay{m,r}-0.5],[-10000000 1000000],'k','yliminclude','off','xliminclude','off','LineWidth',1);
%     end
%     plot(cell2mat(a.daySummary.infoBigLicksWater(m,:)),'Color','g','LineWidth',2,'Marker','o','MarkerFaceColor','g','MarkerSize',3,'Visible','off');
%     plot(cell2mat(a.daySummary.infoSmallLicksWater(m,:)),'Color','m','LineWidth',2,'Marker','o','MarkerFaceColor','m','MarkerSize',3,'Visible','off');
%     plot(cell2mat(a.daySummary.randBigLicksWater(m,:)),'Color','b','LineWidth',2,'Marker','o','MarkerFaceColor','b','MarkerSize',3,'Visible','off');
%     plot(cell2mat(a.daySummary.randSmallLicksWater(m,:)),'Color','c','LineWidth',2,'Marker','o','MarkerFaceColor','c','MarkerSize',3,'Visible','off');
%     plot(cell2mat(a.daySummary.CRewards(m,:)),'Color',cornflower,'LineWidth',2,'Marker','o','MarkerFaceColor',cornflower,'MarkerSize',3,'Visible','off');
%     plot(cell2mat(a.daySummary.DRewards(m,:)),'Color',cornflower,'LineWidth',2,'Marker','o','MarkerEdgeColor',cornflower,'MarkerSize',3,'LineStyle',':','Visible','off');
    ylabel({'Reward', 'Rate (uL/min)'});
    xlabel('Day');    
    leg = legend(ax,'Info','No Info','Choice','Location','southoutside','Orientation','horizontal');
    leg.Box = 'off';
    leg.FontWeight = 'bold';

%     leg = legend(ax,'Info Forced','Info Choice','No Info Forced','No Info Choice''Info-Rew','Info-No Rew','No Info - Rew','No Info - No Rew','No Info - C','No Info - D','Units','normalized','Position',[0.2 0.6 0.1 0.2],'Orientation','horizontal');
%     leg.Box = 'off';
%     leg.FontWeight = 'bold';

    hold off;

   
    saveas(fig,fullfile(pathname,a.mouseList{m}),'pdf');
%     close(fig);
    
end


%% NOT PRESENT IN PORT OVERALL

% for mm = 1:numel(a.currentMiceNums)
%     m=a.currentMiceNums(mm);
for m = 1:a.mouseCt
    figure();
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');
    
    ax = nsubplot(1,1,1,1);
    title(a.mouseList(m));
    ax.FontSize = 8;
    ylabel('% trials not present in reward port at outcome');
    
    ax.YTick = [0 0.25 0.50 0.75 1];
    ax.YLim = [-0.1 1.1];
    
    bar(a.incomplete(m,:),'FaceColor','k','EdgeColor','none');
    set(gca,'XTickLabel',a.choiceLabels,'XTick',[1:8]);
    
    saveas(fig,fullfile(pathname,['notPresent' a.mouseList{m}]),'pdf');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ALL MICE SUMMARIES

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% OVERALL: PRE-REVERSE SORTED PREFERENCE BARS WITH CONFIDENCE INTERVAL (overall.pdf)

if a.choiceMouseCt > 1
    fig = figure();
    
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');
    
    ax = nsubplot(1,1,1,1);
    ax.FontSize = 8;
    ax.XTick = [1:a.choiceMouseCt+1];
    ax.YTick = [0 0.25 0.50 0.75 1];
    ax.XTickLabel = [a.sortedMouseList; 'Mean'];
    ax.YLim = [0 1];
    for m = 1:a.choiceMouseCt
%         bar(m,a.sortedChoice(m,1),'facecolor',a.mColors(m,:),'edgecolor','none');
          bar(m,a.sortedChoice(m,1),'facecolor',[0.3 0.3 0.3],'edgecolor','none');
          errorbar(m,a.sortedChoice(m,1),a.sortedChoice(m,1) - a.sortedCI(m,1),a.sortedCI(m,2) - a.sortedChoice(m,1),'LineStyle','none','LineWidth',2,'Color','k');
    end
    bar(a.choiceMouseCt+1,a.overallPref,'facecolor','k','edgecolor','none');
    errorbar(a.choiceMouseCt+1,a.overallPref,a.overallPref - a.overallCI(1),a.overallCI(2) - a.overallPref,'LineStyle','none','LineWidth',2,'Color','k');
    plot([-10000000 1000000],[0.5 0.5],'k','yliminclude','off','xliminclude','off');
    text(a.choiceMouseCt+2,a.overallPref,['p = ' num2str(a.overallP)])
    ylabel('Info side preference');
    xlabel('Mouse');
    hold off;
    
    saveas(fig,fullfile(pathname,'Overall'),'pdf');
%     close(fig);
end


if ~isempty(a.reverseMice)
    fig = figure();
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');

    ax = nsubplot(1,1,1,1);
    ax.FontSize = 8;
    ax.XLim = [0 1];
    ax.YLim = [0 1];
    for l = 1:numel(a.reverseMice)
        m = a.reverseMice(l);
        plot([a.pref(m,1) a.pref(m,1)],[a.prefRevCI(m,1) a.prefRevCI(m,2)],'color',[0.2 0.2 0.2],'linewidth',0.25);
        plot([a.prefCI(m,1) a.prefCI(m,2)],[a.pref(m,2) a.pref(m,2)],'color',[0.2 0.2 0.2],'linewidth',0.25);
        dy = a.prefRevCI(m,2) - a.pref(m,2) + 0.02;
        text(a.pref(m,1),a.pref(m,2) + dy,a.reverseMiceList{l},'HorizontalAlignment','center');
    end
    scatter(a.pref(:,1),a.pref(:,2),'filled')
    plot([-10000000 1000000],[0.5 0.5],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    plot([0.5 0.5],[-10000000 1000000],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    text(numel(a.reverseMice)+2,a.overallPref,['p = ' num2str(a.overallP)])
%     patch([0.5 1 1 0.5],[0 0 0.5 0.5],[0.3 0.3 0.3],'FaceAlpha',0.1,'EdgeColor','none');
    ylabel({'% choice of initially informative side', 'POST-reversal'}); %{'Info choice', 'probability'}
    xlabel({'% choice of initially informative side', 'PRE-reversal'});
    title('Raw choice percentages, pre vs post-reversal');
    hold off;

    saveas(fig,fullfile(pathname,'PrevsPostIIS'),'pdf');
%     close(fig);
end

    %% LOGISTIC REGRESSION ON TRIALS TO COUNT (regression.pdf) 

if ~isempty(a.reverseMice)
    fig = figure();
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');

    ax = nsubplot(1,1,1,1);
    ax.FontSize = 8;
    ax.XLim = [-3 3];
    ax.YLim = [-3 3];
    for mm = 1:numel(a.reverseMice)
        m = a.reverseMice(mm);
        plot([a.beta(m,1) a.beta(m,1)],[a.beta(m,2) - a.betaSE(m,2) a.beta(m,2) + a.betaSE(m,2)],'color',[0.2 0.2 0.2],'linewidth',0.25);
        plot([a.beta(m,1)-a.betaSE(m,1) a.beta(m,1)+a.betaSE(m,1)],[a.beta(m,2) a.beta(m,2)],'color',[0.2 0.2 0.2],'linewidth',0.25);
%         dy = a.beta(m,2) - a.betaCI(m,2) + 0.02;
        text(a.beta(m,1),a.beta(m,2) + 0.1,a.reverseMiceList{mm},'HorizontalAlignment','center');
    end
    scatter(a.beta(:,1),a.beta(:,2),'filled','FaceColor','k')
    plot([-10000000 1000000],[0 0],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    plot([0 0],[-10000000 1000000],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    ylabel({'Info preference', '(log odds biasing to currently informative side'}); %{'Info choice', 'probability'}
    xlabel({'Side bias', '(log odds biasing to initially informative side)'});
    title('Logistic Regression Analysis');
    hold off;

    saveas(fig,fullfile(pathname,'Regression'),'pdf');
%     close(fig);
end

%% PERCENT INFO CHOICE BY SIDE

if ~isempty(a.reverseMice)
    fig = figure();
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');

    ax = nsubplot(1,1,1,1);
    ax.FontSize = 8;
    ax.XLim = [0 1];
    ax.YLim = [0 1];
    for l = 1:numel(a.reverseMice)
        m = a.reverseMice(l);
        text(a.overallChoice(m,1),a.overallChoice(m,2) + 0.02,a.reverseMiceList{l},'HorizontalAlignment','center');
    end
    scatter(a.overallChoice(:,1),a.overallChoice(:,2),'filled')
    plot([-10000000 1000000],[0.5 0.5],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    plot([0.5 0.5],[-10000000 1000000],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    plot([0 1],[0 1],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    plot([0 1],[1 0],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    ylabel({'P(choose info | Info side = 1)'}); %{'Info choice', 'probability'}
    xlabel({'P(choose info | Info side = 0)'});
    title('Raw choice percentages, by physical info side');
    hold off;

    saveas(fig,fullfile(pathname,'Prefbyside'),'pdf');
%     close(fig);
end

    if ~isempty(a.reverseMice)
    fig = figure();
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');

    ax = nsubplot(1,1,1,1);
    ax.FontSize = 8;
    ax.XLim = [0 1];
    ax.YLim = [0 1];
    for l = 1:numel(a.reverseMice)
        m = a.reverseMice(l);
        text(a.overallChoice(m,3),a.overallChoice(m,4) + 0.02,a.reverseMiceList{l},'HorizontalAlignment','center');
    end
    scatter(a.overallChoice(:,3),a.overallChoice(:,4),'filled')
    plot([-10000000 1000000],[0.5 0.5],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    plot([0.5 0.5],[-10000000 1000000],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    plot([0 1],[0 1],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    plot([0 1],[1 0],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    ylabel({'P(choose info | Info side = initially non-informative)'}); %{'Info choice', 'probability'}
    xlabel({'P(choose info | Info side = initially informative)'});
    title('Raw choice percentages, by info side');
    hold off;

    saveas(fig,fullfile(pathname,'Prefbyinitside'),'pdf');
%     close(fig);
    end
    
    %% PREFERENCE VS LEAVING

if ~isempty(a.reverseMice)
fig = figure();
fig.PaperUnits = 'inches';
fig.PaperPosition = [0.5 0.5 10 7];
set(fig,'renderer','painters');
set(fig,'PaperOrientation','landscape');

ax = nsubplot(1,1,1,1);
ax.FontSize = 8;
% ax.XLim = [0 1];
ax.YLim = [0 1];
for mm = 1:numel(a.reverseMice)
    m = a.reverseMice(mm);
    text(a.incomplete(m,6),a.overallChoice(m,5) + 0.01,a.reverseMiceList{mm},'HorizontalAlignment','center');
end
scatter(a.incomplete(a.reverseMice,6),a.overallChoice(a.reverseMice,5),'filled')
plot([-10000000 1000000],[0.5 0.5],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
plot([0.5 0.5],[-10000000 1000000],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
% plot([0 1],[0 1],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
% plot([0 1],[1 0],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
ylabel({'P(choose info)'}); %{'Info choice', 'probability'}
xlabel({'P(NOT present in port on info small)'});
title('Overall mean choice of information vs. probability of leaving on low-value info trials');
hold off;

saveas(fig,fullfile(pathname,'Prefbyleaving'),'pdf');
%     close(fig);
end

%% initial pref vs initial leaving
if ~isempty(a.reverseMice)
fig = figure();
fig.PaperUnits = 'inches';
fig.PaperPosition = [0.5 0.5 10 7];
set(fig,'renderer','painters');
set(fig,'PaperOrientation','landscape');

ax = nsubplot(1,1,1,1);
ax.FontSize = 8;
% ax.XLim = [0 1];
ax.YLim = [0 1];
for mm = 1:numel(a.choiceMice)
    m = a.choiceMice(mm);
    text(a.initialIncomplete(m,1),a.pref(m,1) + 0.01,a.choiceMiceList{mm},'HorizontalAlignment','center');
end
scatter(a.initialIncomplete(a.choiceMice,1),a.pref(a.choiceMice,1),'filled')
plot([-10000000 1000000],[0.5 0.5],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
plot([0.5 0.5],[-10000000 1000000],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
% plot([0 1],[0 1],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
% plot([0 1],[1 0],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
ylabel({'P(choose info)'}); %{'Info choice', 'probability'}
xlabel({'P(NOT present in port on info small)'});
title('Initial choice of information vs. probability of leaving on low-value info trials');
hold off;

saveas(fig,fullfile(pathname,'InitPrefbyleaving'),'pdf');
%     close(fig);
end

%% initial pref vs days of training
if ~isempty(a.reverseMice)
fig = figure();
fig.PaperUnits = 'inches';
fig.PaperPosition = [0.5 0.5 10 7];
set(fig,'renderer','painters');
set(fig,'PaperOrientation','landscape');

reverseDays = cell2mat(a.reverseDay(:,1));
reverseDays = reverseDays(reverseDays>0);
imagingReverseDays = cell2mat(a.reverseDay(:,1));
imagingReverseDays = imagingReverseDays(a.imagingMice==1);

ax = nsubplot(1,1,1,1);
ax.FontSize = 8;
% ax.XLim = [0 1];
ax.YLim = [0 1];
for mm = 1:numel(a.reverseMice)
    m = a.reverseMice(mm);
    text(a.reverseDay{m,1},a.pref(m,1) + 0.01,a.reverseMiceList{mm},'HorizontalAlignment','center');
end
scatter(reverseDays,a.pref(a.reverseMice,1),'filled');
scatter(imagingReverseDays,a.pref(find(a.imagingMice),1),'filled','MarkerFaceColor','r');
plot([-10000000 1000000],[0.5 0.5],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
plot([0.5 0.5],[-10000000 1000000],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
plot([0 1],[0 1],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
plot([0 1],[1 0],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
ylabel({'P(choose info)'}); %{'Info choice', 'probability'}
xlabel({'Days of training'});
title('Initial choice of information vs. length of training');
hold off;

saveas(fig,fullfile(pathname,'InitPrefbytraining'),'pdf');
%     close(fig);
end

%% initial pref vs initial rxn
if ~isempty(a.reverseMice)
fig = figure();
fig.PaperUnits = 'inches';
fig.PaperPosition = [0.5 0.5 10 7];
set(fig,'renderer','painters');
set(fig,'PaperOrientation','landscape');

ax = nsubplot(1,1,1,1);
ax.FontSize = 8;
% ax.XLim = [0 1];
ax.YLim = [0 1];
for mm = 1:numel(a.reverseMice)
    m = a.reverseMice(mm);
    text(a.reversalRxn(mm,1),a.pref(m,1) + 0.01,a.reverseMiceList{mm},'HorizontalAlignment','center');
end
scatter(a.reversalRxn(:,1),a.pref(a.reverseMice,1),'filled');
% scatter(imagingReverseDays,a.pref(find(a.imagingMice),1),'filled','MarkerFaceColor','r');
plot([-10000000 1000000],[0.5 0.5],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
plot([0.5 0.5],[-10000000 1000000],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
% plot([0 1],[0 1],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
% plot([0 1],[1 0],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
ylabel({'P(choose info)'}); %{'Info choice', 'probability'}
xlabel({'Reaction speed index: 1 = faster info reaction speed'});
title('Initial choice of information vs. faster info reaction');
hold off;

saveas(fig,fullfile(pathname,'InitPrefbyrxn'),'pdf');
%     close(fig);
end

%% MEAN PREFERENCE (INDEX)

if ~isempty(a.reverseMice)
    fig = figure();
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');

    ax = nsubplot(1,1,1,1);
    ax.FontSize = 6;
%     ax.YLim = [-0.2 0.2];
    ax.YLim = [-0.4 0.4];
    
    micetoplot = unique([a.reverseMice;find(a.imagingMice)]);
    imagemice = find(a.imagingMice);
    choicetoplot = a.overallChoice;
    choicetoplot(isnan(choicetoplot))=0.5;
    [sharedvals,idx] = intersect(micetoplot,imagemice);
    bar(choicetoplot(micetoplot,5)-0.5,'FaceColor',grey);
    imagingchoice = choicetoplot(sharedvals,5)-0.5;
    bar(idx,imagingchoice,'FaceColor','r');
    bar(numel(micetoplot)+1,nanmean(a.overallChoice(micetoplot,5))-0.5,'FaceColor','k');
    xticks(1:numel(micetoplot)+1);
    xticklabels([a.mouseList(micetoplot); 'Mean']);
    xlim([0.5 numel(micetoplot)+1.5]);
    ylabel('Mean choice of info side across reversals');
    yticks([-.2 -.1 0 .1 .2]);
    yticklabels({'30%','40%','50%','60%','70%'});
    text(numel(micetoplot)+1,nanmean(a.overallChoice(micetoplot,5))-0.45,['Mean = ' num2str(round(nanmean(a.overallChoice(micetoplot,5)),4))],'HorizontalAlignment','center');
    text(numel(micetoplot)+1,nanmean(a.overallChoice(micetoplot,5))-0.46,['p = ' num2str(round(a.overallChoiceP,4))],'HorizontalAlignment','center');
    

    saveas(fig,fullfile(pathname,'OverallIndex'),'pdf');
end

    %% REACTION SPEED REGRESSION

    bothSig = a.preRevRxnSpeed(:,3)<0.05 & a.postRevRxnSpeed(:,3)<0.05;

    for m = 1:a.mouseCt
        if bothSig(m) == 1
            if a.preRevRxnSpeed(m,1)>a.preRevRxnSpeed(m,2)
                if a.postRevRxnSpeed(m,1)>a.postRevRxnSpeed(m,2)
                    sig(m) = 1;
                else
                    sig(m) = 3;
                end
            else if a.preRevRxnSpeed(m,1)<a.preRevRxnSpeed(m,2)
                    if a.postRevRxnSpeed(m,1)<a.postRevRxnSpeed(m,2)
                        sig(m) = 2;
                    else
                        sig(m) = 3;
                    end
                end
            end
        else sig(m) = 4;
        end
    end
    
    reverseSig = sig(a.reverseMice);
    a.rxnSpeedIdxRev=a.rxnSpeedIdx(a.reverseMice,:);

    
    fig = figure();
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');

    ax = nsubplot(1,1,1,1);
    ax.FontSize = 8;
    ax.XLim = [-.3 .3];
    ax.YLim = [-.3 .3];
    for l = 1:numel(a.reverseMice)
        m = a.reverseMice(l);
        dy = 0.01;
        text(a.rxnSpeedIdx(m,1),a.rxnSpeedIdx(m,2) + dy,a.reverseMiceList{l},'HorizontalAlignment','center');
    end
    plot([-10000000 1000000],[0 0],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    plot([0 0],[-10000000 1000000],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
    scatter(a.rxnSpeedIdxRev(reverseSig==1,1),a.rxnSpeedIdxRev(reverseSig==1,2),'filled','MarkerEdgeColor','none','MarkerFaceColor',purple);
    scatter(a.rxnSpeedIdxRev(reverseSig==2,1),a.rxnSpeedIdxRev(reverseSig==2,2),'filled','MarkerEdgeColor','none','MarkerFaceColor',orange);
    scatter(a.rxnSpeedIdxRev(reverseSig==3,1),a.rxnSpeedIdxRev(reverseSig==3,2),'filled','MarkerEdgeColor','none','MarkerFaceColor','k');
    scatter(a.rxnSpeedIdxRev(reverseSig==4,1),a.rxnSpeedIdxRev(reverseSig==4,2),'filled','MarkerEdgeColor','none','MarkerFaceColor',[.8 .8 .8]);
    ylabel('POST-reversal (info side vs other side)');
    xlabel('PRE-reversal (info side vs other side)');
    title({'Reaction speed indices, pre vs post-reversal', '(1 = faster reaction for info side)'});
    hold off;

    saveas(fig,fullfile(pathname,'PrevsPostRxn'),'pdf');
%     close(fig);

%% PLOT MEAN CHOICES AROUND REVERSALS

    fig = figure();
    
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');
    
    ax = nsubplot(1,1,1,1);
    ax.FontSize = 8;
    ax.YTick = [0 0.25 0.50 0.75 1];
    ax.YLim = [0 1];
    ax.XLim = [0.5 9.5];
    ax.XTick = [1:8];
    
    plot([1:4], a.meanReversalMultiPrefs(1:4),'Color','k','LineWidth',3,'Marker','o','MarkerFaceColor','k','MarkerSize',5);
    plot([1:4], a.meanReversalMultiPrefs(1:4)+a.SEMReversalMultiPrefs(1:4),'Color','k','LineWidth',1,'Marker','none');
    plot([1:4], a.meanReversalMultiPrefs(1:4)-a.SEMReversalMultiPrefs(1:4),'Color','k','LineWidth',1,'Marker','none');
    plot([5:8], a.meanReversalMultiPrefs(5:8),'Color','k','LineWidth',3,'Marker','o','MarkerFaceColor','k','MarkerSize',5)
    plot([5:8], a.meanReversalMultiPrefs(5:8)+a.SEMReversalMultiPrefs(1:4),'Color','k','LineWidth',1,'Marker','none');
    plot([5:8], a.meanReversalMultiPrefs(5:8)-a.SEMReversalMultiPrefs(1:4),'Color','k','LineWidth',1,'Marker','none');
    plot([1.5 1.5],[-10000000 1000000],'color','r','linewidth',1,'linestyle','--','yliminclude','off','xliminclude','off');
    plot([5.5 5.5],[-10000000 1000000],'color','r','linewidth',1,'linestyle','--','yliminclude','off','xliminclude','off');
    
    reverseLabels = {'Pre-reverse','1','2','3','Pre-reverse','1','2','3'};
    set(gca,'XTickLabel',reverseLabels);
    ylabel({'% choice of', 'initial info side'});
    hold off;
    
    saveas(fig,fullfile(pathname,'ReversalMultiChoices'),'pdf');
    
%% PLOT MEAN CHOICES AROUND REVERSALS (single days)

% if a.choiceMouseCt > 1
    fig = figure();
    
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');
    
    ax = nsubplot(1,1,1,1);
    ax.FontSize = 8;
    ax.YTick = [0 0.25 0.50 0.75 1];
    ax.YLim = [0 1];
    ax.XLim = [0.5 3.5];
    ax.XTick = [1 2 3];
    
    for n=1:3
       plot(n,nanmean(a.reversalPrefs(:,n)),'Color','k','LineWidth',2,'Marker','o','MarkerFaceColor','k','MarkerSize',10); 
       errorbar(n,nanmean(a.reversalPrefs(:,n)),sem(a.reversalPrefs(:,n)),'Color','k','LineWidth',2,'CapSize',100);
    end
    for m = 1:numel(a.reverseMice)
%         if ~isnan(a.reversalPrefs(m,3))
            plot(a.reversalPrefs(m,:),'Color',grey,'LineStyle',':','LineWidth',2,'Marker','o','MarkerFaceColor',grey);
%         end
    end
    reverseLabels = {'Pre-reversal','Reversal','Post-reversal'};
    set(gca,'XTickLabel',reverseLabels);
    ylabel({'% choice of', 'initial info side'});
    
    saveas(fig,fullfile(pathname,'ReversalChoices'),'pdf');
    
% end

% if a.choiceMouseCt > 1
    fig = figure();
    
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');
    
    ax = nsubplot(1,1,1,1);
    ax.FontSize = 8;
%     ax.YTick = [0 0.25 0.50 0.75 1];
%     ax.YLim = [0 1];
    ax.XLim = [0.5 3.5];
    ax.XTick = [1 2 3];
    
    for n=1:3
       plot(n,nanmean(a.reversalRxn(:,n)),'Color','k','LineWidth',2,'Marker','o','MarkerFaceColor','k','MarkerSize',10); 
       errorbar(n,nanmean(a.reversalRxn(:,n)),sem(a.reversalRxn(:,n)),'Color','k','LineWidth',2,'CapSize',100);
    end
    for m = 1:numel(a.reverseMice)
        if ~isnan(a.reversalPrefs(m,3))
            plot(a.reversalRxn(m,:),'Color',grey,'LineStyle',':','LineWidth',2,'Marker','o','MarkerFaceColor',grey);
        end
    end
    reverseLabels = {'Pre-reversal','Reversal','Post-reversal'};
    set(gca,'XTickLabel',reverseLabels);
    ylabel('Reaction Speed Index');
    
    saveas(fig,fullfile(pathname,'ReversalRxn'),'pdf');
% end

%% REACTION SPEED PLOT

    fig = figure();
    
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');
    
    ax = nsubplot(1,1,1,1);
    ax.FontSize = 8;
%     ax.YTick = [0 500 1000 1500];
%     ax.YLim = [300 1300];
    ax.XLim = [0.5 3.5];
%     ax.XTick = [1 2 3];
    
%     bar(1,nanmean(a.reversalRxn(:,1)));
    for m = 1:numel(a.reverseMice)
        plot([1 3],[a.reversalRxnInfo(m,1) a.reversalRxnRand(m,1)],'Color',grey,'LineStyle',':','LineWidth',2,'Marker','o','MarkerFaceColor',grey);
    end
    plot(1,nanmean(a.reversalRxnInfo(:,1)),'Color','k','LineWidth',2,'Marker','o','MarkerFaceColor','k','MarkerSize',10);
    errorbar(1,nanmean(a.reversalRxnInfo(:,1)),sem(a.reversalRxnInfo(:,1)),'Color','k','LineWidth',2,'CapSize',100);
    plot(3,nanmean(a.reversalRxnRand(:,1)),'Color','k','LineWidth',2,'Marker','o','MarkerFaceColor','k','MarkerSize',10);
    errorbar(3,nanmean(a.reversalRxnRand(:,1)),sem(a.reversalRxnRand(:,1)),'Color','k','LineWidth',2,'CapSize',100);
    xticks([1 3]);
    xticklabels({'Info','No Info'});
    ylabel('Reaction time on last session before reversal');
    saveas(fig,fullfile(pathname,'ReactionTime'),'pdf');
    
    %% PLOT REWARD RATE DIFF AROUND REVERSALS

% if numel(a.reverseMice) > 1
    fig = figure();
    
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');
    
    ax = nsubplot(1,1,1,1);
    ax.FontSize = 8;
%     ax.YTick = [0 0.25 0.50 0.75 1];
%     ax.YLim = [0 1];
    ax.XLim = [0.5 3.5];
    ax.XTick = [1 2 3];
    
    for n=1:size(a.reversalRewardRateIdx,2)
       plot(n,nanmean(a.reversalRewardRateIdx(:,n)),'Color','k','LineWidth',2,'Marker','o','MarkerFaceColor','k','MarkerSize',10); 
       errorbar(n,nanmean(a.reversalRewardRateIdx(:,n)),sem(a.reversalRewardRateIdx(:,n)),'Color','k','LineWidth',2,'CapSize',100);
    end
    if size(a.reversalRewardRateIdx,2)==3
    for m = 1:numel(a.reverseMice)
        if ~isnan(a.reversalRewardRateIdx(m,3))
            plot(a.reversalRewardRateIdx(m,:),'Color',grey,'LineStyle',':','LineWidth',2,'Marker','o','MarkerFaceColor',grey);
        end
    end
    end
    reverseLabels = {'Pre-reversal','Reversal','Post-reversal'};
    set(gca,'XTickLabel',reverseLabels);
    ylabel('Reward Rate of Initial Info Side - Reward Rate of Initial No Info Side');
    
    saveas(fig,fullfile(pathname,'ReversalRewardRate'),'pdf');
    
% end

%% REWARD RATE PRE-REVERSE PLOT

    fig = figure();

    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');

    ax = nsubplot(1,1,1,1);
    ax.FontSize = 8;
    %     ax.YTick = [0 0.25 0.50 0.75 1];
    %     ax.YLim = [0 20];
    ax.XLim = [0 4];
    ax.XTick = [1 3];
    xticklabels({'Info','No Info'});
    ylabel('Reward rate on last day before reverse');

    %     plot(1,nanmean(a.reversalRewardRateIdx(:,1)),'Color','k','LineWidth',2,'Marker','o','MarkerFaceColor','k','MarkerSize',10);
    %     errorbar(1,nanmean(a.reversalRewardRateIdx(:,1)),sem(a.reversalRewardRateIdx(:,1)),'Color','k','LineWidth',2,'CapSize',100);

    plot(1,nanmean(a.reversalRewardRateInfo(:,1)),'Color','k','LineWidth',2,'Marker','o','MarkerFaceColor','k','MarkerSize',10);
    errorbar(1,nanmean(a.reversalRewardRateInfo(:,1)),sem(a.reversalRewardRateInfo(:,1)),'Color','k','LineWidth',2,'CapSize',100);
    plot(3,nanmean(a.reversalRewardRateRand(:,1)),'Color','k','LineWidth',2,'Marker','o','MarkerFaceColor','k','MarkerSize',10);
    errorbar(3,nanmean(a.reversalRewardRateRand(:,1)),sem(a.reversalRewardRateRand(:,1)),'Color','k','LineWidth',2,'CapSize',100);


    for m = 1:numel(a.reverseMice)
    %         plot(a.reversalRewardRateIdx(m,1),'Color',grey,'LineStyle',':','LineWidth',2,'Marker','o','MarkerFaceColor',grey);
    %         plot(a.reversalPrefs(m,1),a.reversalRewardRateIdx(m,1),'Color',grey,'LineStyle',':','LineWidth',2,'Marker','o','MarkerFaceColor',grey);
        plot([1 3],[a.reversalRewardRateInfo(m,1),a.reversalRewardRateRand(m,1)],'Color',grey,'LineStyle',':','LineWidth',2,'Marker','o','MarkerFaceColor',grey);
    %         plot(2,a.reversalRewardRateRand(m,1),'Color',grey,'LineStyle',':','LineWidth',2,'Marker','o','MarkerFaceColor',grey);
    end



    % plot(a.reversalRewardRateIdx(:,1),a.reversalMultiPrefs(:,1),'Color','k','LineStyle','none','Marker','o','MarkerFaceColor','k','MarkerSize',10);

    saveas(fig,fullfile(pathname,'RewardRate'),'pdf');
    
    
%% REWARD RATE ALL DAYS

    fig = figure();
    
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0.5 0.5 10 7];
    set(fig,'renderer','painters');
    set(fig,'PaperOrientation','landscape');
    
    ax = nsubplot(1,1,1,1);
    ax.FontSize = 8;
%     ax.YTick = [0 500 1000 1500];
%     ax.YLim = [300 1300];
    ax.XLim = [0.5 3.5];
%     ax.XTick = [1 2 3];
    
%     bar(1,nanmean(a.reversalRxn(:,1)));
    for m = 1:a.mouseCt
        plot([1 3],[a.rewardRate(m,1) a.rewardRate(m,2)],'Color',grey,'LineStyle',':','LineWidth',2,'Marker','o','MarkerFaceColor',grey);
    end
    plot(1,nanmean(a.rewardRate(:,1)),'Color','k','LineWidth',2,'Marker','o','MarkerFaceColor','k','MarkerSize',10);
    errorbar(1,nanmean(a.rewardRate(:,1)),sem(a.rewardRate(:,1)),'Color','k','LineWidth',2,'CapSize',100);
    plot(3,nanmean(a.rewardRate(:,2)),'Color','k','LineWidth',2,'Marker','o','MarkerFaceColor','k','MarkerSize',10);
    errorbar(3,nanmean(a.rewardRate(:,2)),sem(a.rewardRate(:,2)),'Color','k','LineWidth',2,'CapSize',100);
    xticks([1 3]);
    xticklabels({'Info','No Info'});
    ylabel('Reward Rate across all preference days');
    saveas(fig,fullfile(pathname,'RewardRateAllDays'),'pdf');    


%% pref vs reward rate
fig = figure();
fig.PaperUnits = 'inches';
fig.PaperPosition = [0.5 0.5 10 7];
set(fig,'renderer','painters');
set(fig,'PaperOrientation','landscape');

ax = nsubplot(1,1,1,1);
ax.FontSize = 8;
% ax.XLim = [0 1];
ax.YLim = [0 1];
for mm = 1:numel(a.reverseMice)
    m = a.reverseMice(mm);
    text(a.rewardDiff(m,1),a.overallChoice(m,5) + 0.01,a.reverseMiceList{mm},'HorizontalAlignment','center');
end
scatter(a.rewardDiff(:,1),a.overallChoice(:,5),'filled')
plot([-10000000 1000000],[0.5 0.5],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
plot([0 0],[-10000000 1000000],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
% plot([0 1],[0 1],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
% plot([0 1],[1 0],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
ylabel({'P(choose info)'}); %{'Info choice', 'probability'}
xlabel({'Info reward rate - no info reward rate (uL per minute)'});
title('Choice of information vs. reward rate difference');
hold off;

saveas(fig,fullfile(pathname,'Prefbyreward'),'pdf');
%     close(fig);   
    
    
    %% initial pref vs initial reward rate
fig = figure();
fig.PaperUnits = 'inches';
fig.PaperPosition = [0.5 0.5 10 7];
set(fig,'renderer','painters');
set(fig,'PaperOrientation','landscape');

ax = nsubplot(1,1,1,1);
ax.FontSize = 8;
% ax.XLim = [0 1];
ax.YLim = [0 1];
for mm = 1:numel(a.reverseMice)
    m = a.reverseMice(mm);
    text(a.reversalRewardRateIdx(mm,1),a.pref(m,1) + 0.01,a.reverseMiceList{mm},'HorizontalAlignment','center');
end
scatter(a.reversalRewardRateIdx(:,1),a.pref(a.reverseMice,1),'filled')
plot([-10000000 1000000],[0.5 0.5],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
plot([0 0],[-10000000 1000000],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
% plot([0 1],[0 1],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
% plot([0 1],[1 0],'color',[0.2 0.2 0.2],'linewidth',0.25,'yliminclude','off','xliminclude','off');
ylabel({'P(choose info)'}); %{'Info choice', 'probability'}
xlabel({'Info reward rate - no info reward rate (uL per minute)'});
title('Initial choice of information vs. reward rate difference');
hold off;

saveas(fig,fullfile(pathname,'InitPrefbyreward'),'pdf');
%     close(fig); 
