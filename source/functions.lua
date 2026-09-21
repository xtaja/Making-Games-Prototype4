-- (0,1 - 179,180,181 - 359,0,1) -> (0,1 - 179,180,179 - 1,0,1)
 function CrankYVal(crankVal)
    if (crankVal <= 180) then
        return crankVal
    end
    return 360 - crankVal
end
