;*********************************************
; GFS 500mb Heights
;*********************************************
;
; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;*********************************************
; read in data
;*********************************************
 ;fili  = "hgt.2016.nc"
 fili  = "hgt.2016.nc"                              ; data

 f     = addfile (fili , "r")
 ;HGT = f->hgt
 hgt500   = f->hgt(120:145,5,:,:)
 printVarSummary(hgt500) ; give a summary of the data
 ;print(typeof(f->hgt))
 print("--------------------------------------------")
 print("-//////////////////////////////////////////-")
 print("--------------------------------------------")
 print(dimsizes(hgt500))    ; print out what the dimensions of each variable are

;*********************************************
; manipulate data for plotting
;*********************************************
 ;time = f->time(120:145)
 lon = f->lon
 lat = f->lat

 ;*******************************************************************
 ; Need to keep all the dimensions of sst the same, but
 ; switch the time dimension with a converted dimension???????????
 ;*******************************************************************
 time = f->time(120:145)
 print(time)
 ;time@units = "hours since 1800-01-01 00:00:0.0"
 ;time2 = cd_calendar(time, 3)
 ;print(time2)



 ;print(time2)

 ;*******************************************************************
 ; Need to have the time and lat dimensions in the correct order for
 ; the gsn_csm_lat_time() function!!
 ; lat needs to be arg(0) and time the last arg(1)
 ;*******************************************************************
 shov      = hgt500({lon|250:250},lat|:,time|:)          ; put time last
 dims      = dimsizes(shov)

 sdemo     = onedtond(ndtooned(shov), (/dims(1),dims(2)/) )
 sdemo!0         = "lat"
 sdemo!1         = "time"
 sdemo&lat       = hgt500&lat
 sdemo&time      = hgt500&time
 sdemo@long_name = "500mb Geopotential Heights"
 sdemo@units     = "m"

 sdemo = smooth92d (sdemo,0.5, 0.25)                  ; 2D smoother
;***********************************************************************
; plotting parameters
;***********************************************************************
 wks   = gsn_open_wks ("png", "hgt_2016_lat_time" )  ; send graphics to PNG file

 res                  = True                ; plot mods desired
 res@cnFillOn         = True                ; color on
 res@lbLabelStride    = 4                   ; every other label
 res@lbOrientation    = "Vertical"          ; vertical label bar
 res@pmLabelBarOrthogonalPosF = -0.08      ; move label bar closer to axis
 res@cnLinesOn        = False               ; turn off contour lines
 res@cnFillPalette    = "wh-bl-gr-ye-re"    ; set color map

 res@tiMainString     = "Denver"  ; title

 res@vpXF             = 0.12                ; default is 0.2 (aspect ratio)
 res@vpYF             = 0.8                 ; default is 0.8
 res@vpHeightF        = 0.4                 ; default is 0.6
 res@vpWidthF         = 0.75                ; default is 0.6

 res@cnLevelSelectionMode = "ManualLevels" ; manual levels
 res@cnMinLevelValF       = 5300
 res@cnMaxLevelValF       = 5720
 res@cnLevelSpacingF      = 10
 restick = True
 restick@ttmFormat = "%c-%d %hZ"
 restick@ttmAxis = "XB"
 restick@ttmMajorStride = 5

 time_axis_labels(sdemo&time,res,restick)
 plot = gsn_csm_lat_time(wks,sdemo({30:50},:), res)

end
