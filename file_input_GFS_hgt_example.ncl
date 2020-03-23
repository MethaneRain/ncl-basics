load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

setfileoption("nc", "FileStructure", "Advanced")

fn = "hgt.2016.nc" 
fi = addfile(fn, "r")
printVarSummary(fi)

vNames = getfilevarnames (fi)
print(vNames)
t = fi->time 
printVarSummary(t)