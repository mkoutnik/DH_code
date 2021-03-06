function [ b_dot_nodes, ...
           b_dot_P, ...
           b_dot_edges ] = load_b_dot( x_P, x_edges, t_P, ...
                                       x_nodes, t_nodes )

% -------------------------------------------------------------------------                                   
                                   
global N_t_nodes N_x_nodes
  
global DIRECTORY_data

addpath(DIRECTORY_data)


bdot1 = 1;
bdot2 = 0;
bdot3 = 0;
bdot4 = 0;

disp (' ')
disp ('Check bdot prescribed in load_b_dot.m')
disp(' ')


% Interpolate onto nodes and mesh:
% ================================
  b_dot_nodes = NaN * ones(N_t_nodes, N_x_nodes);
  
  
  
% Estimate from available observations
% ====================================

% From QGIS -- Accumulation_A vs. Accumulation_R
load DH_accum_width_velocity.mat

load DH_surf_bed.mat

 

if (bdot1 == 1)
% % ------------------------------
% % OPTION 1: lapse rate estimate modern
% % ------------------------------

% if you want to calculate from a lapse rate similar to Bliss et al. (2011) for Taylor glacier 
precip_at_sl = -0.35;
lapse        = 0.35/1500;
Darwin_bdot_modern_lapse = precip_at_sl + lapse.*Darwin_modern_surface;
b_dot_use    = interp1(Darwin_centerline_distance, Darwin_bdot_modern_lapse, x_nodes);

% % % OLD:
% % b_dot_use = interp1(Darwin_accumulation_centerline_distance, Darwin_accumulation_A, x_nodes);  % NOT NEGATIVE here...
% % % b_dot_use = linspace(0,0, length(x_nodes));
% % %b_dot_use = interp1(accumulation_centerline_distance, accumulation_R, x_nodes);
% % 
% % b_dot_use = interp1([x_nodes(1) x_nodes(end)], [-0.26 0.14], x_nodes, 'linear', 'extrap');
% % 
% % %b_dot_use = 0.1 * ones(size(b_dot_use));   % Make positive, even though negative!!
% 
% % b_dot_use = interp1(Darwin_centerline_distance, Darwin_bdot_modern_lapse, x_nodes);
% % b_dot_use = -interp1(Darwin_accumulation_centerline_distance, Darwin_accumulation_A, x_nodes);
% % b_dot_use = linspace(0,0, length(x_nodes));


elseif (bdot2 == 1)
% ------------------------------
% OPTION 2: Arthern estimate LGM
% ------------------------------
 b_dot_use = interp1(Darwin_accumulation_centerline_distance, Darwin_accumulation_A*0.6, x_nodes);  % NOT NEGATIVE here...


 elseif (bdot3 == 1)
% ------------------------------
% OPTION 3: RACMO estimate LGM
% ------------------------------
 b_dot_use = interp1(Darwin_accumulation_centerline_distance, Darwin_accumulation_R*0.6, x_nodes);  % NOT NEGATIVE here...


 elseif (bdot4 == 1)
% ------------------------------
% OPTION 4: LGM estimate
% ------------------------------
  b_dot_use = interp1(Darwin_accumulation_centerline_distance, Darwin_accumulation_LGM, x_nodes);

  
end 
  
  for ii = 1:N_t_nodes
    b_dot_nodes(ii,:) = b_dot_use;
  end

  
 
  

% % Constant in time
% % ------------------
%  b_dot_use = interp1([x_P(1) x_P(end)], [0.3 0.3], x_P);  % Average accumulation 28 cm/yr
%                                                           % Denton et al. (1989)                                                                                                          
%  for ii = 1:N_t_nodes
%    b_dot_nodes(ii,:) = interp1(x_P, b_dot_use, ...
%                                x_nodes, 'linear', 'extrap');
%  end

       
% % Linearly decreasing in time
% % ----------------------------
% b_dot_use      = interp1([x_P(1) x_P(end)], [0.1 0.1], x_P);
% time_variation = interp1([t_P(1) t_P(end)], [6 3], t_nodes); 
% 
% for ii = 1:N_t_nodes
%     b_dot_nodes(ii,:) = time_variation(ii) * interp1(x_P, b_dot_use, x_nodes, 'linear', 'extrap');
% end
 




% interpolate onto mesh -- from nodes!
% ----------------------                                        
   b_dot_P = interp2( repmat( x_nodes, N_t_nodes, 1 ), ...
                      repmat( t_nodes, 1, N_x_nodes ), ...
                      b_dot_nodes, x_P, t_P );

 
% interpolate onto edges of mesh
% ------------------------------ 
   b_dot_edges = interp2( repmat( x_nodes, N_t_nodes, 1 ), ...
                           repmat( t_nodes, 1, N_x_nodes ), ...
                           b_dot_nodes, x_edges, t_P );  
%                        b_dot_edges(:,1) = b_dot_edges(:,2);
                                               