function [ output_args ] = fnMiscCallback( a, b, strEvent )
%FNMISCCALLBACK put all extensions not approved by Shay here, so forward
%porting is less painfull
%   Detailed explanation goes here
% TODO print the anatomical name plus additional information on the figure 
% before saving and remove it afterwards...

%global g_strctModule 

switch strEvent
	case 'SaveFigureScreenShot'
		%20111121sm
        fnSaveFigureScreenShot();
    otherwise
        dbg = 1;
end

return;
end

function fnSaveFigureScreenShot()
global g_strctModule
% TODO get the name of the active volume, overlay, 
tmp_time = fix(clock);	% no fractional seconds...
tod_string = [num2str(tmp_time(4), '%02d'), num2str(tmp_time(5), '%02d'), num2str(tmp_time(6), '%02d')];
if isfield(g_strctModule, 'm_acAnatVol') && ~isempty(g_strctModule.m_acAnatVol)
	if isfield(g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}, 'm_strName')
		cur_anat_vol_name = g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strName;
		%cur_func_vol_name = g_strctModule.m_acFuncVol{g_strctModule.m_iCurrFuncVol}.m_strName;
	end
else
	cur_anat_vol_name = 'No_Anatomical_loaded';
end
[fig_name, fig_dir_name]=uiputfile(['Planner_', cur_anat_vol_name, '_', tod_string, '.tif'], 'Where to save the current figure');
if fig_name(1) == 0
    return;
end;
[dummy_pathstr, fig_name_stem, fig_ext] = fileparts(fig_name);	% get the extension
switch fig_ext(2:end)
	case {'png', 'PNG'}
		print_cmd_opt = 'png';
 	case {'jpg', 'JPG', 'jpeg', 'JPEG'}
 		print_cmd_opt = 'jpg';
 	case {'bmp', 'BMP'}
 		print_cmd_opt = 'bmp';
	case {'tiff', 'tif' , 'TIF', 'TIFF'}
		fig_ext = '.tif';
		print_cmd_opt = 'tiff';
	otherwise		
		disp('Output format not recognized, defaulting to tif.');
		fig_ext = '.tif';
		print_cmd_opt = 'tiff';
end

% to get a pixel-perfect screen shot 
cur_figure_frame = getframe(gcf);
[cur_fig_matrix, cur_fig_Map] = frame2im(cur_figure_frame);
imwrite(cur_fig_matrix, fullfile(fig_dir_name, [fig_name_stem, fig_ext]));
msgbox('Screen-shot Saved');

return;
end

