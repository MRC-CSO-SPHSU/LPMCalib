using CSV
using Tables


export loadDemographyData


function loadDemographyData(fertFName, deathFFName, deathMFName) 
    fert = CSV.File(fertFName, header=0) |> Tables.matrix
    deathFemale = CSV.File(deathFFName, header=0) |> Tables.matrix
    deathMale = CSV.File(deathMFName, header=0) |> Tables.matrix

    (fertility=fert,deathFemale=deathFemale,deathMale=deathMale)
end
