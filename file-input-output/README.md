### Working with Files
---

#### 1) NetCDF (.nc)

* GFS Reanalysis 4x Daily Geopotential Heights

```ncl
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

setfileoption("nc", "FileStructure", "Advanced")

fn = "hgt.2016.nc" 
fi = addfile(fn, "r")
printVarSummary(fi)

>>> Variable: fi
>>> Type: file
>>> filename:	hgt.2016
>>> File path	:	hgt.2016.nc

>>> Number of global attributes	:	 7
>>> Number of dimensions	:	 4
>>> Number of chunk_dimensions	:	 3
>>> Number of variables	:	 5 (in this group only) 5 (including all descendent groups)
```

Exploring the variables:
```ncl
vNames = getfilevarnames (fi)
print(vNames)

>>> Variable: vNames
>>> Type: string
>>> Total Size: 40 bytes
>>>            5 values
>>> Number of Dimensions: 1
>>> Dimensions and sizes:   [5]
>>> Coordinates: 
>>> (0)     level
>>> (1)     lat
>>> (2)     lon
>>> (3)     time
>>> (4)     hgt
```
Sweet! So the variables are levels, latitutes, longitudes, times, and actual heights.
