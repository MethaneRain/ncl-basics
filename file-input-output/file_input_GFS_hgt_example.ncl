begin
    ;load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
    ;load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

    setfileoption("nc", "FileStructure", "Advanced")

    fn = "/Users/chowdahead/Desktop/hgt.2016.nc" 
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
    res = True
    res@cnLevelSelectionMode = "ManualLevels"
    res@cnMinLevelValF = min(hgt(10,5,:,:)) ; Min contour
    res@cnMaxLevelValF = max(hgt(10,5,:,:)) ; Max contour
    res@cnLevelSpacingF = 40 ; Spacing
    res@cnFillOn = True
    res@cnFillPalette = "MPL_StepSeq"
    ;mpDataSetName = "Earth..1"
    res@mpOutlineBoundarySets = "GeophysicalAndUSStates"   
    plot = gsn_csm_contour_map(wks,hgt(10,5,:,:),res)  


end