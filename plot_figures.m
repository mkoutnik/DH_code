% Plot figures

addpath('export_fig')

% -------------------------------------------------------------------------
% Results from SS runs -- to find consistent LGM surfaces
% -------------------------------------------------------------------------

% ---------------
% Figure to show how these sets of BC match the modern data
% a) Darwin surface
% b) Darwin velocity
% c) Hatherton surface
% d) Hatherton velocity
% ---------------


run_value = [1 2 4:7];  

%run_value = 1

for ii = 1:length(run_value)
ii_use = run_value(ii);
%eval(['load run_min_search' int2str(ii_use) 'a.mat'])    
eval(['load min' int2str(ii_use) '.mat'])    

% Darwin : (modern surface - calculated surface)
figure(1)
set(gcf, 'Units', 'centimeters','position', [35 20 22 20])
subplot('position', [0.2 0.81 0.8 0.15])
set(gca, 'fontsize', 16)
plot(x_P/1000, (S_modern-S_P(1,:))./S_modern, 'color', [0.7 0.7 0.7], 'linewidth', 1)
hold on
plot([x_P(1) x_P(end)]/1000, [0 0],'k--')
if (ii == 1)
 plot(x_P/1000, (S_modern-S_P(1,:))./S_modern, 'k', 'linewidth', 2)
end    
ylabel({'Fractional';' elevation ';'difference ';'[obs-model]'}, 'fontweight', 'bold')
xlim([x_P(1) x_P(end)]/1000)
%ylim([-300 350])
ylim([-0.05 0.2])
if (ii == 6)
text(110, -100,'Darwin Glacier', 'fontangle', 'italic', 'fontsize', 16)
end
set(gca, 'xticklabel', [])


% Darwin : (observed - calculated surface velocity)
subplot('position', [0.2 0.6 0.8 0.15])
set(gca, 'fontsize', 16)
measures_on_xedges = interp1( Darwin_measures_centerline_distance, Darwin_measures_flowspeed, x_edges, 'linear', 'extrap');
plot(x_edges/1000, (measures_on_xedges - average_vel_estimate*(5/4))./measures_on_xedges, 'color', [0.7 0.7 0.7], 'linewidth', 1)
hold on
plot([x_edges(1) x_edges(end)]/1000, [0 0],'k--')
if (ii == 1)
 plot(x_edges/1000, (measures_on_xedges - average_vel_estimate*(5/4))./measures_on_xedges, 'k', 'linewidth', 2)
end  
ylabel({'Fractional';' velocity'; 'difference';' [obs-model]'}, 'fontweight', 'bold')
xlim([x_P(1) x_P(end)]/1000)
%ylim([-25 25])
ylim([-10 1])
xlabel('Distance along flowband (km)', 'fontweight', 'bold')


% Hatherton : (modern surface - calculated surface)
subplot('position', [0.2 0.33 0.8 0.15])
set(gca, 'fontsize', 16)
plot(x_P2/1000, (S_modern2-S_P2(1,:))./S_modern2, 'color', [0.7 0.7 0.7], 'linewidth', 1)
hold on
plot([x_P2(1) x_P2(end)]/1000, [0 0],'k--')
if (ii == 1)
 plot(x_P2/1000, (S_modern2-S_P2(1,:))./S_modern2, 'k', 'linewidth', 2)
end
ylabel({'Fractional';' elevation ';'difference ';'[obs-model]'}, 'fontweight', 'bold')
xlim([x_P2(1) x_P2(end)]/1000)
ylim([-0.2 0.2])
if (ii == 6)
text(60, -100,'Hatherton Glacier', 'fontangle', 'italic', 'fontsize', 16)
end
set(gca, 'xticklabel', [])

% Hatherton : (observed - calculated surface velocity)
subplot('position', [0.2 0.12 0.8 0.15])
set(gca, 'fontsize', 16)
measures_on_xedges2 = interp1( Hat_measures_centerline_distance, Hat_measures_flowspeed, x_edges2, 'linear', 'extrap');
plot(x_edges2/1000, (measures_on_xedges2 - average_vel_estimate2*(5/4))./measures_on_xedges2, 'color', [0.7 0.7 0.7], 'linewidth', 1)
hold on
plot([x_edges2(1) x_edges2(end)]/1000, [0 0],'k--')
if (ii == 1)
   plot(x_edges2/1000, (measures_on_xedges2 - average_vel_estimate2*(5/4))./measures_on_xedges2, 'k', 'linewidth', 2)
end
xlabel('Distance along flowband (km)', 'fontweight', 'bold')
ylabel({'Fractional';' velocity'; 'difference';' [obs-model]'}, 'fontweight', 'bold')
xlim([x_P2(1) x_P2(end)]/1000)
ylim([-10 1])
%set(gca, 'ytick', [-75 -50 -25 0], 'yticklabel',{'-75','-50','-25','0'})

end

export_fig figure1_match_to_modern.pdf -pdf -transparent
save figure1_match_to_modern.fig


% ---------------
% Figure to plot finding LGM elevation at Darwin that best matches
% Hatherton data
% ---------------

% a) RMS mismatch vs. LGM elevation vector
% b) Darwin surfaces for LGM SS 
% c) Hatherton mismatch to data 
% d) Hatherton surfaces for LGM SS 

addpath('export_fig')

run_value = [1 2 4:7];


for jj = 1:length(run_value)
ii = run_value(jj);
 eval(['load LGM_steady_state_min' int2str(ii) '.mat'])
 
    
figure(2)
set(gcf, 'Units', 'centimeters','position', [35 20 24 20])
subplot('position', [0.15 0.61 0.2 0.34])
set(gca, 'fontsize', 16) 
% mismatch vs. LGM elevation values
plot(LGM_elev_vec, RMS_mismatch, 'color', [0.7 0.7 0.7], 'linewidth', 1)
hold on
set (gca, 'fontsize', 16)
xlabel({'LGM elevation ';'at Darwin Gl. (m)'}, 'fontsize', 16, 'fontweight', 'bold')
ylabel({'RMS mismatch'; 'along Hatherton Gl.'}, 'fontsize', 16, 'fontweight', 'bold')
if (ii == 1)
 plot(LGM_elev_vec, RMS_mismatch, 'k', 'linewidth', 2)
end    
xlim([300 1400])
set(gca,'xtick', [400 900 1400],'xticklabel',{'400','900','1400'})

subplot('position', [0.5 0.61 0.45 0.34])
set(gca, 'fontsize', 16) 
plot(x_P/1000, B_P,'r')
hold on
plot(x_P/1000, S_modern, 'linewidth', 2)
plot(x_P/1000, S_P(1,:),'c')
if (ii == 1)
h = legend('Bed', 'Modern surface', 'Calculated LGM', 'location', 'southeast');
set(h, 'fontsize', 12)
plot(x_P/1000, S_P(1,:),'k', 'linewidth', 1)
text(18, 2100, 'Darwin Glacier', 'fontangle', 'italic', 'fontsize', 16)
end
ylabel('Elevation (m)', 'fontweight', 'bold')
xlabel('Distance along flowband (km)', 'fontweight', 'bold')
xlim([x_P(1) x_P(end)]/1000)
ylim([-1000 2400])


   DAN_calc_elevation = interp1( x_P2, S_P2(time,:), DAN_position ); 
   MVfloor_calc_elevation = interp1( x_P2, S_P2(time,:), MVfloor_position ); 
   LWC14_calc_elevation = interp1( x_P2, S_P2(time,:), LWC14_position ); 
   
subplot('position', [0.15 0.12 0.2 0.34])
set(gca, 'fontsize', 16) 
plot(DAN_position/1000, DAN_mean_elevation - DAN_calc_elevation, 'g.', 'markersize', 12)
hold on
plot(MVfloor_position/1000, MVfloor_mean_elevation - MVfloor_calc_elevation, 'm.', 'markersize', 12)
plot(LWC14_position/1000, LWC14_mean_elevation - LWC14_calc_elevation, 'k.', 'markersize', 12)
if (ii == 1)
    plot(DAN_position/1000, DAN_mean_elevation - DAN_calc_elevation, 'o', 'markersize', 10,'markeredgecolor', 'k', 'markerfacecolor', 'g')
    plot(MVfloor_position/1000, MVfloor_mean_elevation - MVfloor_calc_elevation, 'o', 'markersize', 10,'markeredgecolor', 'k', 'markerfacecolor', 'm')
    plot(LWC14_position/1000, LWC14_mean_elevation - LWC14_calc_elevation, 'o', 'markersize', 10,'markeredgecolor', 'k', 'markerfacecolor', 'k')
end
xlabel({'Position along'; 'flowband (km)'}, 'fontweight', 'bold')
ylabel({'Elevation';'difference (m)'}, 'fontweight', 'bold')



subplot('position', [0.5 0.12 0.45 0.34])
set(gca, 'fontsize', 16) 
plot(x_P2/1000, B_P2,'r')
hold on
plot(x_P2/1000, S_modern2, 'linewidth', 2)
plot(x_P2/1000, S_P2(1,:),'c')
plot(DAN_position/1000, DAN_mean_elevation, 'g*')
plot(MVfloor_position/1000, MVfloor_mean_elevation, 'm*')
plot(LWC14_position/1000, LWC14_mean_elevation, 'k*')
 plot([DAN_position DAN_position]/1000, [700 1500], 'g')
 plot([MVfloor_position MVfloor_position]/1000, [700 1500], 'm')
 plot([LWC14_position LWC14_position]/1000, [700 1500], 'k')
if (ii == 1)
 h = legend('Bed', 'Modern surface', 'Calculated LGM', 'location', 'southeast');
set(h, 'fontsize', 12)
plot(x_P2/1000, S_P2(1,:),'k', 'linewidth', 1)
text(14, 2100, 'Hatherton Glacier', 'fontangle', 'italic', 'fontsize', 16)
 text(11, 1650, 'LW', 'fontsize', 14)
 text(28, 1650, 'MV', 'fontsize', 14, 'color', 'm')
 text(42, 1650, 'DAN', 'fontsize', 14, 'color', 'g')
end
xlabel('Distance along flowband (km)', 'fontweight', 'bold')
ylabel('Elevation (m)', 'fontweight', 'bold')
xlim([x_P2(1) x_P2(end)]/1000)
ylim([-500 2300])


end


export_fig figure2_LGM_SS.pdf -pdf -transparent




% -------------------------------------------------------------------------
% Results from transient runs -- prescribe LGM elevation history at Darwin;
% compare to data from Hatherton
% -------------------------------------------------------------------------

addpath('export_fig')

load LGM_steady_state_min2.mat   % to load mean elevation values of data.

% NOTE: Need to change file names in the plot command below for smooth or step!

for jj = 1:7 
   
% eval(['load stepwise_9ka_min' int2str(jj) '.mat'])
%  eval(['load smooth_9ka_min' int2str(jj) '.mat'])
  eval(['load pollard_min' int2str(jj) '.mat'])


 index_val = jj;
 
figure
set(gcf, 'Units', 'centimeters','position', [35 20 24 30])
subplot('position', [0.15 0.875 0.8 0.1])
    plot(t_P/1000, S_at_GL,'k', 'linewidth', 2)
    set(gca, 'fontsize', 16)
    xlabel('Time (kyr)', 'fontweight', 'bold')
    ylabel({'Elevation'; '(m a.s.l.)'}, 'fontweight', 'bold')
    %text(-11.6, 400, 'Prescribed elevation near ', 'fontangle', 'italic', 'fontsize', 14)
    %text(-11.6, 200, 'Darwin Glacier grounding line', 'fontangle', 'italic', 'fontsize', 14)
    xlim([-12 0])
    ylim([0 1000]) 
    
subplot('position', [0.15 0.61 0.8 0.2])
    plot(x_P/1000, S_P(81:20:end,:),'b')
    hold on
    plot(x_P/1000, B_P,'r')
    plot([x_P(index_xpos_Hatherton_P) x_P(index_xpos_Hatherton_P)]/1000,[B_P(index_xpos_Hatherton_P) 2200], 'c')
    plot(x_P/1000, S_modern(end,:),'k--','linewidth', 2)
    set(gca, 'fontsize', 16)
    %xlabel('Distance along flowband (km)', 'fontweight', 'bold')
    ylabel({'Elevation'; '(m a.s.l.)'}, 'fontweight', 'bold')
    xlim([17 150])
    ylim([-750 2200])
    text(120, -300, 'Darwin Glacier', 'fontangle', 'italic', 'fontsize', 18)
    text(36, 1850, 'Hatherton Glacier', 'fontangle', 'italic', 'fontsize', 14)
    text(36, 1500, 'input', 'fontangle', 'italic', 'fontsize', 14)

    
 load all_values.mat   
 load LGM_values_use.mat
 index_DAN     = find(x_P2 <= DAN_position, 1, 'last');
 index_MVfloor = find(x_P2 <= MVfloor_position, 1, 'last')-1;
 index_LWC14   = find(x_P2 <= LWC14_position, 1, 'last'); 
    
 
subplot('position', [0.15 0.36 0.8 0.2])
    plot(x_P2/1000, S_P2(81:20:end,:),'c')
    hold on
    plot(x_P2/1000, B_P2,'r')
    plot(x_P2/1000, S_modern2, 'k--', 'linewidth', 2)
    set(gca, 'fontsize', 16)
    xlabel('Distance along flowband (km)', 'fontweight', 'bold')
    ylabel({'Elevation'; '(m a.s.l.)'}, 'fontweight', 'bold')
    ylim([-200 2100])
    text(65, 100, 'Hatherton Glacier', 'fontangle', 'italic', 'fontsize', 18)
    xlim([10 85])
    plot([DAN_position DAN_position]/1000, [700 1500], 'g')
    plot([MVfloor_position MVfloor_position]/1000, [700 1500], 'm')
    plot([LWC14_position LWC14_position]/1000, [700 1500], 'k')
    plot(DAN_position/1000, DAN_mean_elevation, 'g*')
    plot(MVfloor_position/1000, MVfloor_mean_elevation, 'm*')
    plot(LWC14_position/1000, LWC14_mean_elevation, 'k*')
    text(11, 1700, 'LW', 'fontsize', 14)
    text(28, 1700, 'MV', 'fontsize', 14, 'color', 'm')
    text(43, 1700, 'DAN', 'fontsize', 14, 'color', 'g')
   
    
    run_value = [1:7]
   %  run_value = [1:6]
for ii = 1:length(run_value)
    
 % eval(['load smooth_9ka_min' int2str(ii) '.mat'])
 % eval(['load stepwise_9ka_min' int2str(ii) '.mat'])     
   eval(['load pollard_min' int2str(ii) '.mat'])

  subplot('position', [0.15 0.075 0.2 0.2])
    plot(t_P2/1000, S_P2(:,index_LWC14), 'color', [0.7 0.7 0.7])
    hold on
    plot(-LWC14_ages/1000, LWC14_elevations, 'k.', 'markersize', 12)
    xlim([-12 0])
    set(gca, 'fontsize', 16)
    ylabel({'Elevation'; '(m a.s.l.)'}, 'fontweight', 'bold')
    
 subplot('position', [0.45 0.075 0.2 0.2])
    plot(t_P2/1000, S_P2(:,index_MVfloor), 'color', [0.7 0.7 0.7])
    hold on
    plot(-MVfloor_Be10_ages/1000, MVfloor_elevations, 'm.', 'markersize', 12)
    xlim([-12 0])
    set(gca, 'fontsize', 16)
    xlabel('Time (kyr)', 'fontweight', 'bold')
         
 subplot('position', [0.75 0.075 0.2 0.2])
    plot(t_P2/1000, S_P2(:,index_DAN), 'color', [0.7 0.7 0.7])
    hold on
    plot(-DAN_Be10_ages/1000, DAN_elevations, 'g.', 'markersize', 12)
    xlim([-12 0])
    set(gca, 'fontsize', 16)
    
end

%  eval(['load smooth_9ka_min' int2str(index_val) '.mat'])
%   eval(['load stepwise_9ka_min' int2str(index_val) '.mat'])
  eval(['load pollard_min' int2str(index_val) '.mat'])


 subplot('position', [0.15 0.075 0.2 0.2])
    plot(t_P2/1000, S_P2(:,index_LWC14), 'c')
    hold on
    plot(-LWC14_ages/1000, LWC14_elevations, 'k.', 'markersize', 12)
    xlim([-12 0])
    set(gca, 'fontsize', 16)
    ylabel({'Elevation'; '(m a.s.l.)'}, 'fontweight', 'bold')
    
 subplot('position', [0.45 0.075 0.2 0.2])
    plot(t_P2/1000, S_P2(:,index_MVfloor), 'c')
    hold on
    plot(-MVfloor_Be10_ages/1000, MVfloor_elevations, 'm.', 'markersize', 12)
    xlim([-12 0])
    set(gca, 'fontsize', 16)
    xlabel('Time (kyr)', 'fontweight', 'bold')
         
 subplot('position', [0.75 0.075 0.2 0.2])
    plot(t_P2/1000, S_P2(:,index_DAN), 'c')
    hold on
    plot(-DAN_Be10_ages/1000, DAN_elevations, 'g.', 'markersize', 12)
    xlim([-12 0])
    set(gca, 'fontsize', 16)
    

    
% eval(['export_fig figure3_LGM_transient_smooth9ka_min' int2str(index_val) '.pdf -pdf -transparent'])
% eval(['export_fig figure3_LGM_transient_step9ka_min' int2str(index_val) '.pdf -pdf -transparent'])
eval(['export_fig figure3_LGM_transient_pollard_min' int2str(index_val) '.pdf -pdf -transparent'])

close all

end


    
