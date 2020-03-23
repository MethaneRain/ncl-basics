load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

setfileoption("nc", "FileStructure", "Advanced")

fn = "/Users/chowdahead/Desktop/hgt.2016.nc" 
fi = addfile(fn, "r")
printVarSummary(fi)
;print(vNames)
;t = fi->time  ; set t to the time variable
;printVarSummary(t) ; print out the summary of the time variable
vNames = getfilevarnames (fi) ; all variable names
          
  nvars  = dimsizes(vNames)

  do nv = 0,nvars-1
    vtype  = getfilevartypes(f,vnames(nv))
    vatts  := getfilevaratts(f,vnames(nv))       ; The := is important because these
    dnames := getfilevardimnames(f,vnames(nv))   ; variables may be a different size
    dsizes := getfilevardimsizes(f,vnames(nv))   ; the next time through the loop

;   print("==================================================")
    print("Variable '" + vnames(nv) + "'")
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