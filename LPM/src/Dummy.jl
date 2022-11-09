"""
functions for a dummy simulation
"""


module Dummy

    using Utilities: Gender, unknown, female, male
    using XAgents: Town, House, Person
    using XAgents: setAsParentChild!, setAsPartners! 
    using MultiAgents: ABM, add_agent!

    export createPopulation

    "Establish a dummy population"
    function initPopulation(houses::Array{House{Person},1})
    
        population = ABM{Person}()

        for house in houses
            mother   = Person(house,rand(25:55) + rand(0:11) // 12 , gender=female)
            father   = Person(house,rand(30:55) + rand(0:11) // 12 , gender=male)
            son      = Person(house,rand(1:15)  + rand(0:11) // 12 , gender=male)
            daughter = Person(house,rand(1:15)  + rand(0:11) // 12 , gender=female)
    
            setAsPartners!(mother,father) 

            setAsParentChild!(son,father)
            setAsParentChild!(daughter,father)
            setAsParentChild!(son,mother)
            setAsParentChild!(daughter,mother)

            add_agent!(mother,population)
            add_agent!(father,population)
            add_agent!(son,population)
            add_agent!(daughter,population)
        end 

        population 
    end 


    function createPopulation()
        # init Towns
        glasgow   = Town((10,10),name="Glasgow") 
        edinbrugh = Town((11,12),name="Edinbrugh")
        sterling  = Town((12,10),name="Sterling") 
        aberdeen  = Town((20,12),name="Aberdeen")
        towns = [aberdeen,edinbrugh,glasgow,sterling]

        # init Houses 
        numberOfHouses = 100 
        # sizes = ["small","medium","big"]

        houses = House{Person}[] 
        for index in range(1,numberOfHouses)
            town = rand(towns)
            # sz   = rand(sizes) 
            x,y  = rand(1:10),rand(1:10)
            push!(houses,House{Person}(town,(x,y)))#,size=sz))
        end
    
        print("sample houses: \n ")
        print("============== \n ")
        @show houses[1:10]
   
        # init Population 
        population = initPopulation(houses) 
        print("Sample population : \n")
        print("=================== \n ")
        @show population.agentsList[1:10]

        population
    end 


end # module Dummy

