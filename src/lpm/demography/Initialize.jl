module Initialize

using Random:  shuffle 
using XAgents: Town, Person, PersonHouse  
using XAgents: isFemale, isMale, partner

export initializeHousesInTowns, assignCouplesToHouses!

"initialize houses in a given set of towns"
function initializeHousesInTowns(towns::Array{Town,1}, pars) 

    houses = PersonHouse[] 

    for town in towns
        if town.density > 0

            adjustedDensity = town.density * pars.mapDensityModifier
        
            for hx in 1:pars.townGridDimension  
                for hy in 1:pars.townGridDimension 
        
                    if(rand() < adjustedDensity)
                        house = PersonHouse(town,(hx,hy))
                        push!(houses,house)
                    end
        
                end # for hy 
            end # for hx 
  
        end # if town.density 
    end # for town 
    
    houses  

end  # function initializeHousesInTwons 


"Randomly assign a population of couples to non-inhebted set of houses"
function  assignCouplesToHouses!(population::Array{Person}, houses::Array{PersonHouse})

    numberOfMens   = length([ man   for man   in population if isMale(man) ])  
    numberOfWomens = length([ woman for woman in population if isFemale(woman) ])  

    @assert(numberOfMens == numberOfWomens) 
    @assert(length(houses) >= numberOfMens)
    
    numberOfMens = trunc(Int,length(population) / 2) 

    randomHousesIndices = shuffle(1:length(houses))    
    randomhouses        = houses[randomHousesIndices[1:numberOfMens]] 

    for man in population
        isFemale(man) ? continue : nothing 

        house  = pop!(randomhouses) 
        man.pos = partner(man).pos = house 

        append!(house.occupants, [man, partner(man)])
    end # for person     
    
    length(randomhouses) > 0 ? 
        error("random houses for occupation has length $(length(randomhouses)) > 0") : 
        nothing 

end  # function assignCouplesToHouses 



end # module Initalize 