struct Link{T}
    t1 :: T
    t2 :: T
end


function kinshipNetwork(filter, house, model, pars)
    LinkT = Link{typeof(house)}
    conns = Vector{LinkT}()

    function checkAndAdd!(h)
        if h != house && filter(h)
            push!(conns, LinkT(house, h))
        end
    end
    
    for person in house.occupants
        if !isSingle(person) 
            checkAndAdd!(partner(person).pos)
        end
        
        for child in children(person)
            checkAndAdd!(child.pos)
        end
        
        f = father(person) 
        if !isUndefined(f) 
            checkAndAdd!(f.pos)
        end
        
        m = mother(person) 
        if !isUndefined(m) 
            checkAndAdd!(m.pos)
        end
    end
    
    conns
end
