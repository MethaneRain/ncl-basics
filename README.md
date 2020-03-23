# ncl-basics
Basics of NCAR's Command Language (NCL)
---

Even though NCAR is transitioning towards Pyhton, they stated they wont be abandoning NCL so I though I'd expand my atmospheric science software toolkit by learning the basics of NCL.

---

The first major hurdle I ran into was installing NCL via Conda from NCAR's website: [http://www.ncl.ucar.edu/Download/conda.shtml](http://www.ncl.ucar.edu/Download/conda.shtml "NCL Conda Install")

The Conda environment was created no problem, but when checking if NCL was installed correctly, I ran into an error:
```
dyld: Library not loaded: @rpath/libwebp.7.dylib

Referenced from: /Users/chowdahead/anaconda3/envs/test-ncl/lib/libtiff.5.dylib

  Reason: Incompatible library version: libtiff.5.dylib requires version 9.0.0 or later, but libwebp.7.dylib provides version 8.0.0


Abort trap: 6
```

I was not able to overcome this error yet, I am waiting to hear from the support team about how to approach this. In the mean time I was able to get NCL installed with PyNio via Conda:
```
conda create --name ncl_to_python --channel conda-forge/label/cf201901 pynio
```

Notice the extra cf201901 before the pynio argument. Now everything is all good!!

Printing ```ncl -V``` in the activated environment resulted in ```6.5.0```!

---

### Getting to know basic variables

The syntax is simialr to many languages and variables can be assigned
```
var=12.0
```
Just like Python, we can print out the value of the variable:
```
print(var)
>>> 12.0
```
We can reassign the varibale to a new value <strong>as long as the variable type is the same!!</strong>
```
var=6.0
print(var)
>>> 6.0
```
However, if we want to reassign the variable to a string, we will run into an error:
```
var="houseboat"
fatal:["NclVar.c":1390]:Assignment type mismatch, right hand side can't be coerced to type of left hand side
```

---
### Working with Files
---

#### 1) NetCDF (.nc)

* GFS Reanalysis 4x Daily Pressures

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
Sweet! So the variables are level, latitutes, longitudes, times, and actual pressure values.
