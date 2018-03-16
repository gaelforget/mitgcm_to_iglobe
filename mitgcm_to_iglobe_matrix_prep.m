function [MGtoIG]=mitgcm_to_iglobe_prep(gridName,plotTest);
% [MGtoIG]=mitgcm_to_iglobe_prep(gridName,plotTest);

gcmfaces_global;
if isempty(whos('plotTest')); plotTest=0; end;

%target locations:
lon=[0.5:2048]*360/2048-180; lat=[0.5:1024]*180/1024-90;
[lat,lon] = meshgrid(lat,lon);

%one-time preparation of interpolation coefficients:
interp=gcmfaces_interp_coeffs(lon(:),lat(:));

%format output:
MGtoIG.gridName=gridName;
MGtoIG.lon=lon;
MGtoIG.lat=lat;
MGtoIG.matrix=interp.SPM;

if plotTest;
  %apply to ocean topography as a test:
  fldIn=mygrid.Depth;
  %
  tmp1=convert2vector(fldIn);
  tmp0=1*~isnan(tmp1);
  tmp1(isnan(tmp1))=0;
  %
  tmp0=MGtoIG.matrix*tmp0;
  tmp1=MGtoIG.matrix*tmp1;
  %
  fldOut=reshape(tmp1./tmp0,size(MGtoIG.lon));
  %
  figureL; pcolor(MGtoIG.lon,MGtoIG.lat,fldOut); shading flat; colorbar; 
end;


