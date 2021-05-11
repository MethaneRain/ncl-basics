begin
    ;load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
    ;load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

    setfileoption("nc", "FileStructure", "Advanced")

    fn = "/Path/To/File/hgt.2016.nc" 
    fi = addfile(fn, "r")
    printVarSummary(fi)
    ;print(vNames)
    hgt = fi->hgt
    ;t = fi->time  ; set t to the time variable
    ;printVarSummary(t) ; print out the summary of the time variable
    vNames = getfilevarnames (fi) ; all variable names
            
    nvars  = dimsizes(vNames)

    do nv = 0,nvars-1
        vtype  = getfilevartypes(fi,vNames(nv))
        vatts  := getfilevaratts(fi,vNames(nv))       ; The := is important because these
        dnames := getfilevardimnames(fi,vNames(nv))   ; variables may be a different size
        dsizes := getfilevardimsizes(fi,vNames(nv))   ; the next time through the loop

    ;   print("==================================================")
        print("Variable '" + vNames(nv) + "'")
        print("  type            : " + vtype)
        if(.not.any(ismissing(dnames))) then
        print("  dimension names : " + str_join(dnames,","))
        else
        print("  dimension names : ")
        end if
        print("  dimension sizes : " + str_join(""+dsizes,","))
        if(.not.any(ismissing(vatts))) then
        print("  attributes      : " + str_join(vatts,","))
        else
        print("  attributes      : ")
        end if
    end do
    print(hgt(0,0,50,50))
    do i=0,16
        print(hgt(0,i,50,50))
    end do
    
    wks = gsn_open_wks("png","500mb_heights") 
    res@gsnMaximize = True
    res@gsnPaperMargin = 0.0
    res = True
    res@cnLevelSelectionMode = "ManualLevels"
    res@cnMinLevelValF = min(hgt(30,5,:,:)) ; Min contour
    res@cnMaxLevelValF = max(hgt(30,5,:,:)) ; Max contour
    res@cnMinLevelValF = 5000 ; Min contour
    res@cnMaxLevelValF = 5800 ; Max contour
    res@cnLevelSpacingF = 10 ; Spacing
    res@cnFillOn = True
    res@cnFillPalette = "so4_23"
    ;cmap = read_colormap_file("so4_23")
    ;res@cnFillPalette = cmap(::-1,:)
    ;mpDataSetName = "Earth..1"
    res@mpLimitMode           = "LatLon"
    res@mpMinLatF             = 20
    res@mpMaxLatF             = 55
    res@mpMinLonF             = 230
    res@mpMaxLonF             = 290
    res@mpCenterLonF          = -100.0
    res@mpCenterLatF          = 40.0
    res@mpGridAndLimbDrawOrder = "Predraw"
    res@mpOutlineBoundarySets = "GeophysicalAndUSStates"   
    plot = gsn_csm_contour_map(wks,hgt(30,5,:,:),res)  
end
