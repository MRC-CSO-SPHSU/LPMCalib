
export createTowns, initializeHousesInTowns


function createTowns(pars) 
    towns = Matrix{PersonTown}(undef, pars.mapGridXDimension, pars.mapGridYDimension) 
    
    for y in 1:pars.mapGridYDimension, x in 1:pars.mapGridXDimension 
        towns[x, y] = PersonTown((x,y), pars.map[y,x])
    end
    
    for t in towns
        x = t.pos[1]
        y = t.pos[2]
        for xx in x-1:x+1, yy in y-1:y+1
            if xx == x && yy == y
                continue
            end
            
            if xx < 1 || xx > size(towns, 1) || yy < 1 || yy > size(towns, 2)
                continue
            end
            
            push!(t.adjacent, towns[xx, yy])
        end
        
#        adj2 = [t2 for t2 in towns if isAdjacent8(t, t2) ]
#        @assert issetequal(adj2, t.adjacent)
    end

    vec(towns)
end


"initialize houses in a given set of towns"
function initializeHousesInTowns(towns::Vector{PersonTown}, pars) 
    houses = PersonHouse[] 

    for town in towns
        
        if town.density <= 0
            continue
        end
            
        adjustedDensity = town.density * pars.mapDensityModifier
    
        for hx in 1:pars.townGridDimension, hy in 1:pars.townGridDimension 
            if rand() < adjustedDensity
                house = PersonHouse(town, (hx,hy))
                push!(houses,house)
                push!(town.houses, house)
            end
        end # for hx 
    end # for town 
    
    houses  
end  # function initializeHousesInTwons 
