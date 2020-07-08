function strctModel = fnBuildRectangularChamberModel3D(fChamberWidthMM, fChamberLengthMM, fChamberDepthMM)
% A chamber must have only two strctures that describe the 3D geometry
% One is "short" (normal size) and one is "long" to see its projection in
% the volume. 
%
% SM20200708: The 3D version requires the full specification of all 3 
%	dimensions to allow non-square bases 
%
% Future versions may automatically do this projection so only the short
% version will be needed.
strctModel.m_astrctMeshShort = fnBuildRectModel( fnGetStandardRectChamberParams3D(fChamberWidthMM, fChamberLengthMM, fChamberDepthMM), 0);
strctModel.m_astrctMeshLong = fnBuildRectModel( fnGetStandardRectChamberParams3D(fChamberWidthMM, fChamberLengthMM, fChamberDepthMM), 80);
return;


function strctParams = fnGetStandardRectChamberParams(fChamberWidthMM)
% Builds a 3D wire-frame model of a rectangular chamber
fChamberHeightMM = 20;
strctParams.m_strManufacterer = 'Rectangular';
strctParams.m_strName = sprintf('Rect %d mm',fChamberWidthMM);
strctParams.m_fWidthMM = fChamberWidthMM;
strctParams.m_fHeightMM = fChamberHeightMM;

return;

function strctParams = fnGetStandardRectChamberParams3D(fChamberWidthMM, fChamberLengthMM, fChamberDepthMM)
% Builds a 3D wire-frame model of a rectangular chamber, taking in 3
% dimensions
fChamberHeightMM = fChamberDepthMM;
strctParams.m_strManufacterer = 'Rectangular';
strctParams.m_strName = sprintf('Rect %d mm',fChamberWidthMM);
strctParams.m_fWidthMM = fChamberWidthMM;
strctParams.m_fHeightMM = fChamberHeightMM;
strctParams.m_fLengthMM = fChamberLengthMM;
return;



function astrctMesh = fnBuildRectModel(strctChamberParams, fDepthMM)
astrctMesh= fnCreateRectChamberMesh3D(strctChamberParams.m_fWidthMM, strctChamberParams.m_fLengthMM, strctChamberParams.m_fHeightMM, fDepthMM, ...
     [1 0 1]);
return;

