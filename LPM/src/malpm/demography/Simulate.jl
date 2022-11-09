"""
    Main simulation functions for the demographic aspect of LPM. 
""" 

module Simulate

using MultiAgents.Util: getproperty

using XAgents: Person, isFemale, alive, age

using MultiAgents: ABM, allagents, add_agent!
using MALPM.Population: removeDead!

using MALPM.Demography.Create: LPMUKDemography, LPMUKDemographyOpt

using LPM
import LPM.Demography.Simulate: doDeaths!
import LPM.Demography.Simulate: doBirths!
export doDeaths!,doBirths!

alivePeople(population::ABM{Person},example::LPMUKDemography) = allagents(population)

alivePeople(population::ABM{Person},example::LPMUKDemographyOpt) = 
               # Iterators.filter(person->alive(person),allagents(population))
                [ person for person in allagents(population)  if alive(person) ]

function doDeaths!(population::ABM{Person}) # argument simulation or simulation properties ? 

    (deadpeople) = LPM.Demography.Simulate.doDeaths!(
            people=alivePeople(population,population.properties.example),
            parameters=population.parameters.poppars,
            data=population.data,
            currstep=population.properties.currstep,
            verbose=population.properties.verbose,
            sleeptime=population.properties.sleeptime,
            checkassumption=population.properties.checkassumption) 

    #for deadperson in deadpeople
    #    removeDead!(deadperson,population)
    #end

    nothing 

    # false ? population.variables[:numberDeaths] += numberDeaths : nothing # Temporarily this way till realized 

end # function doDeaths!


function doBirths!(population::ABM{Person}) 

    newbabies = LPM.Demography.Simulate.doBirths!(
                        people = alivePeople(population,population.properties.example),
                        parameters =  population.parameters.birthpars,
                        data = population.data,
                        currstep = population.properties.currstep,
                        verbose = population.properties.verbose,
                        sleeptime = population.properties.sleeptime,
                        checkassumption = population.properties.checkassumption) 

    # false ? population.variables[:numBirths] += length(newbabies) : nothing # Temporarily this way till realized 
    
    for baby in newbabies
        add_agent!(population,baby)
    end

    nothing 
end

end # Simulate 