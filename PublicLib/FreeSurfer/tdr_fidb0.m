function [B0, fidangle, fidanglehat] = tdr_fidb0(fid,tfid,nfit)
%
% [B0, fidangle, fidanglehat] = tdr_fidb0(fid,tfid,<nfit>)
%
% Compute the B0 map from the complex Free Induction Decay (fid)
% map by fitting the first nfit components unwrap(angle(fid))
% to a linear model. B0 is reported as the slope of the fit
% in radians per time unit in tfit.
%
% $Id: tdr_fidb0.m,v 1.1 2003/10/20 22:15:15 greve Exp $
%

B0 = [];
fidangle = [];
fidanglehat = [];

if(nargin ~= 2 & nargin ~= 3)
  fprintf('[B0, fidangle, fidanglehat] = tdr_fidb0(fid,tfid,<nfit>)\n');
  return;
end

szfid = size(fid);
nechoes = szfid(end);
nv = prod(szfid(1:end-1));

if(exist('nfit') ~= 1) nfit = []; end
if(isempty(nfit)) nfit = nechoes; end
if(nfit > nechoes)
  fprintf('ERROR: nfit = %d > nechoes = %d\n',nfit,nechoes);
  return;
end
if(length(tfid) ~= nechoes)
  fprintf('ERROR: length(tfit) = %d != nechoes = %d\n',...
	  length(tfid),nechoes);
  return;
end

fid = reshape(fid,[nv nechoes])';
fidangle = unwrap(angle(fid),1);
X = [ones(nfit,1) tfid(1:nfit)];
beta = (inv(X'*X)*X')*fidangle(1:nfit,:);
B0 = beta(2,:);
B0 = reshape(B0,[szfid(1:end-1)]);

if(nargout >= 2)
  fidangle = reshape(fidangle',szfid);
end
  
if(nargout == 3)
  X = [ones(nechoes,1) tfid(1:nechoes)];
  fidanglehat = reshape((X*beta)',szfid);
end

return;