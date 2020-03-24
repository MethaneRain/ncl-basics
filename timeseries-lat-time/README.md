# Plotting a time series based off a set of latitudes from GFS 4x daily Geopotential Heights Reanalysis

---

```
Arguments
wks
A Workstation identifier. The identifier is one returned either from calling gsn_open_wks or calling create to create a Workstation object.

data
The two-dimensional data to contour. The leftmost dimension should be latitude, and the rightmost dimension time.

res
A variable containing an optional list of plot resources, attached as attributes. Set to True if you want the attached attributes to be applied, and False if you either don't have any resources to set, or you don't want the resources applied.
```