function strctGridParam = fnDefineGridModel_Standard()
% Generate a standard grid model (circular).


strctGridParam.m_acParam = {
fnAddParameter('Phi','Grid Tilt Angle (deg)', 'Continuous', [0 50], 0, false), ...
fnAddParameter('Theta','Grid Rotation Angle (deg)', 'Continuous', [-180 180], 0, true), ...
fnAddParameter('LongGrid','Grid Projection', 'Logical', [false true], true, false), ...
fnAddParameter('HoleDist','In-Plane Inter-hole Dist(IHD) (mm)', 'Continuous', [0 5], 1, false), ...
fnAddParameter('HoleDistWhere','IHD measured on (tilted/nontilted) plane', 'String', [], 'tilted', false), ...
fnAddParameter('HoleDiam','Hole Diameter (mm)', 'Continuous', [0 5], 0.75, false), ...
fnAddParameter('NumHoles','Number of holes', 'String', [], 'auto', false), ...
fnAddParameter('ClipInvalid','Clip invalid holes', 'Logical', [false true], 'true', false), ...
fnAddParameter('CenterWhere','Center is relative to (tilted/nontilted) plane', 'String', [], 'nontilted', false), ...
fnAddParameter('OffsetX','Center Offset X (mm)', 'Continuous', [0 5], 0, false), ...
fnAddParameter('OffsetY','Center Offset Y (mm)', 'Continuous', [0 5], 0, false), ...
fnAddParameter('GridHeight','Grid Height (mm)', 'Continuous', [0 20], 10, false), ...
fnAddParameter('GridHeightOffset','Grid Height Offset from Top (mm)', 'Continuous', [0 20], 0, false), ...
fnAddParameter('GridInnerDiam','Grid Inner Diameter (mm)', 'Continuous', [0 25], 16.6, false), ...
fnAddParameter('GridOuterDiam','Grid Outer Diameter (mm)', 'Continuous', [0 25], 19, false), ...
fnAddParameter('ElectrodeLength','Electrode Length (mm)', 'Continuous', [0 100], 40, false)};

% Members that must be present in a grid model
strctGridParam.m_strGridType = 'Standard Circular';
strctGridParam.m_abSelectedHoles = [];

return;

function strctParam = fnAddParameter(strName, strDescription, strType, afValuesRange, fInitialValue,bHardCopy)
strctParam.m_strName = strName;
strctParam.m_strDescription = strDescription;
strctParam.m_strType = strType;
strctParam.m_afPossibleValues = afValuesRange;
strctParam.m_Value = fInitialValue;
strctParam.m_bHardCopySelected= bHardCopy;
return;
