# assuming that this is a script located and executed within 
# the source folder of LoneParentModel.jl

currdir = pwd()

if ! endswith(currdir,"LoneParentsModel.jl/src")
    @show currdir
    error("this script has to be executed within the main source folder of LoneParentModel.jl")
end 
if ! (currdir in LOAD_PATH) 
    push!(LOAD_PATH,currdir) 
end 

# examine some basic declarations 

using SocialAgents

person = Person(1,"Glasgow",age=25)
house  = House(2,"Edinbrugh",size="small")

#=
deprecated 

import SocialGroups: Population, Household

pop = Population()
household = Household() 

=# 


