function strctModel = fnBuildCristChamberModel( fChamberAngle, fInnerDiameterMM, fOuterDiameterMM, fChamberH1 )
% A chamber must have only two strctures that describe the 3D geometry
% One is "short" (normal size) and one is "long" to see its projection in
% the volume. 
%
% Future versions may automatically do this projection so only the short
% version will be needed.

if nargin < 3
	error([mfilename, ' expects 4 arguments, angle[deg], innder diameter[mm], outer diameter [mm], and (shortest) axial height [mm]']);
end


strctModel.m_astrctMeshShort = fnBuildShortModel(fnGetStandardDAGChamberParams(fChamberAngle, fInnerDiameterMM, fOuterDiameterMM, fChamberH1));
strctModel.m_astrctMeshLong = fnBuildLongModel(fnGetStandardDAGChamberParams(fChamberAngle, fInnerDiameterMM, fOuterDiameterMM, fChamberH1));
return;


function strctParams = fnGetStandardDAGChamberParams(fChamberAngle, fInnerDiameterMM, fOuterDiameterMM, fChamberH1)
% Builds a 3D wire-frame model of a chamber

% the "length" of the chamber alond the axial axis
% angled chambers require 2 values, the short H1 and the long H2
% fChamberH1 = 22.0;

if (fChamberAngle == 0)
    fChamberH2  = fChamberH1;
else
	%sm: according to trigonometry we expect the following formulation, that
	% comes out at 32.25 for 30 degree, so close enough...
	fChamberH2 = sind(fChamberAngle) * fOuterDiameterMM + fChamberH1;
end

strctParams.m_strManufacterer = 'DAG';
strctParams.m_strName = sprintf('DAG %d Deg, iD %d mm, oD %d mm', fChamberAngle, fInnerDiameterMM, fOuterDiameterMM);
strctParams.m_fOuterDiameterMM = fOuterDiameterMM;
strctParams.m_fInnerDiameterMM = fInnerDiameterMM;
strctParams.m_fChamberH1 = fChamberH1;
strctParams.m_fChamberH2 = fChamberH2;
strctParams.m_fChamberAngleDeg = fChamberAngle;
strctParams.m_iQuat = 20;
return;

function astrctMeshShort = fnBuildShortModel(strctChamberParams)
astrctMeshShort(1)= fnCreateChamberMesh(strctChamberParams.m_fInnerDiameterMM, -strctChamberParams.m_fChamberH1,...
    -strctChamberParams.m_fChamberH2, 0,strctChamberParams.m_iQuat, [1 0 1]);

astrctMeshShort(2)= fnCreateChamberMesh(strctChamberParams.m_fOuterDiameterMM, -strctChamberParams.m_fChamberH1,...
    -strctChamberParams.m_fChamberH2, 0,strctChamberParams.m_iQuat, [1 0 1]);

astrctMeshShort(3)= fnCreateChamberMesh(strctChamberParams.m_fOuterDiameterMM, -80,...
    -80, 0,strctChamberParams.m_iQuat, [1 0 1]);

astrctMeshShort(4)= fnCreateChamberMesh(strctChamberParams.m_fOuterDiameterMM, -80,...
    -80, 0,strctChamberParams.m_iQuat, [1 0 1]);

strctMesh.m_a2fVertices = [ 0                                      0            0                           0; ...
                          strctChamberParams.m_fInnerDiameterMM/2  0 strctChamberParams.m_fInnerDiameterMM/2 0;...
                           -strctChamberParams.m_fChamberH1 -strctChamberParams.m_fChamberH1 0  0];
strctMesh.m_a2iFaces = [1,2,3; 2 3 4]';       
strctMesh.m_afColor = [1 1 0];
strctMesh.m_fOpacity = 0.4;

astrctMeshShort(5) = strctMesh;

return;

function astrctMesh = fnBuildLongModel(strctChamberParams)

astrctMesh(1)= fnCreateChamberMesh(strctChamberParams.m_fInnerDiameterMM, -strctChamberParams.m_fChamberH1,...
    -strctChamberParams.m_fChamberH2, 0,strctChamberParams.m_iQuat, [1 0 1]);

astrctMesh(2)= fnCreateChamberMesh(strctChamberParams.m_fOuterDiameterMM, -strctChamberParams.m_fChamberH1,...
    -strctChamberParams.m_fChamberH2, 0,strctChamberParams.m_iQuat, [1 0 1]);

strctMesh.m_a2fVertices = [ 0                                      0            0                           0; ...
                          strctChamberParams.m_fInnerDiameterMM/2  0 strctChamberParams.m_fInnerDiameterMM/2 0;...
                           -strctChamberParams.m_fChamberH1 -strctChamberParams.m_fChamberH1 0  0];
strctMesh.m_a2iFaces = [1,2,3; 2 3 4]';       
strctMesh.m_afColor = [1 1 0];
strctMesh.m_fOpacity = 0.4;
astrctMesh(3) = strctMesh;

return;