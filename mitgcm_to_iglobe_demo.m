function []=mitgcm_to_iglobe_demo();
% []=mitgcm_to_iglobe_demo();

%% pre-requisites
 
p = genpath('gcmfaces/'); addpath(p);
addpath mitgcm_to_iglobe;
grid_load('nctiles_grid/',5,'nctiles');
gcmfaces_global;

if 0;%set to 1 to recompute interpolation matrix
  [MGtoIG]=mitgcm_to_iglobe_matrix_prep('llc90',1);
  save MGtoIG.mat MGtoIG;
else;%reload precomputed interpolation matrix
  load MGtoIG.mat;
end;

%% load and preppare fields for interpolation

T=read_nctiles('nctiles_climatology/THETA/THETA','THETA',[],1);
UX=read_nctiles('nctiles_climatology/UVELMASS/UVELMASS','UVELMASS',[],1);
VY=read_nctiles('nctiles_climatology/VVELMASS/VVELMASS','VVELMASS',[],1);

[UE,VN]=calc_UEVNfromUXVY(UX,VY);

%% interpolation itself

varIn={'T','UE','VN'};
for ii=1:length(varIn);
  eval(['tmp0=' varIn{ii} ';']);
  %
  tmp1=convert2vector(tmp0);
  [tmp0,s3]=size(tmp1);
  tmp0=1*~isnan(tmp1);
  tmp1(isnan(tmp1))=0;
  %
  tmp0=MGtoIG.matrix*tmp0;
  tmp1=MGtoIG.matrix*tmp1;
  tmp1=reshape(tmp1./tmp0,[size(MGtoIG.lon) s3]);
  %
  eval([varIn{ii} '_IG=tmp1;']);
end;

%% depict results

figureL; pcolor(MGtoIG.lon,MGtoIG.lat,mean(T_IG,3)); shading flat; caxis([-2 30]); colorbar;
figureL; pcolor(MGtoIG.lon,MGtoIG.lat,mean(UE_IG,3)); shading flat; caxis([-1 1]*0.25); colorbar;
figureL; pcolor(MGtoIG.lon,MGtoIG.lat,mean(VN_IG,3)); shading flat; caxis([-1 1]*0.25); colorbar;

