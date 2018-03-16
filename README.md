# mitgcm\_to\_iglobe
Interpolation of MITgcm output to grid used for iGlobe display

## Pre-Requisites

- Install the [gcmfaces toolbox](http://gcmfaces.readthedocs.io/) and [this repository](https://github.com/gaelforget/mitgcm_to_iglobe)
- Obtain the MITgcm grid and output. In the [ECCOv4](http://eccov4.readthedocs.io/) test case below, the pre-computed interpolation matrix is also downloaded.

```
git clone https://github.com/gaelforget/gcmfaces
git clone https://github.com/gaelforget/mitgcm_to_iglobe

setenv ECCOv4FTP 'ftp://mit.ecco-group.org/ecco_for_las/version_4/release2/'
wget --recursive {$ECCOv4FTP}/nctiles_grid
wget --recursive {$ECCOv4FTP}/nctiles_climatology

wget ftp://mit.ecco-group.org/gforget/mitgcm_to_iglobe/llc90/MGtoIG.mat
```

## ECCOv4 Test Case

Start Matlab, go to the downloaded content directory, and type:

```
p = genpath('gcmfaces/'); addpath(p);
addpath('mitgcm_to_iglobe/');
mitgcm_to_iglobe_demo;
```

## Using Octave?

Use this version of the [gcmfaces toolbox](http://gcmfaces.readthedocs.io/) instead:

```
git clone -b octave https://github.com/gaelforget/gcmfaces
```

Install and activate the [Octave nectdf implementation](https://github.com/Alexander-Barth/octave-netcdf/wiki):

```
pkg install -forge netcdf
pkg load netcdf
```

## Other Test Case?

Download the following instead:

```
setenv llc270_hzhang 'ftp://mit.ecco-group.org/gforget/llc270_hzhang/'
wget --recursive {$llc270_hzhang}/nctiles_grid
wget --recursive {$llc270_hzhang}/nctiles_climatology

wget ftp://mit.ecco-group.org/gforget/mitgcm_to_iglobe/llc270/MGtoIG.mat
```


