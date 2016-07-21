function [ output_args ] = start_Planner( input_args )
%START_PLANNER Summary of this function goes here
%   silly little wrapper to get the current path into the matlab path

path_string = path;
% where does this script live
start_dir = fileparts(mfilename('fullpath'));
% change there to be sure about the calling directory 
cd(start_dir);


% delete existing paths containing the calling directory
% this is a work around for matlab's inability to detect changed files on
% most network shares
if ~isempty(strfind(path_string, [start_dir, pathsep]))
	disp('Current directory already in the path; deleting all subdirectories from the path to work around network share issues...');
	% turn the path into cell array
	while length(path_string) > 0
		[cur_path_item, remain] = strtok(path_string, ';:');
		path_string = remain(2:end);
		if ~isempty(strfind(cur_path_item, start_dir))
			rmpath(cur_path_item);
		end
	end
end
% now add them again
addpath(genpath(start_dir));



% start planner
EntryPoint

return