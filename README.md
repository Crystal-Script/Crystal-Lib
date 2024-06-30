# Crystal-Lib
Crystal Lib

Libreria necessaria per la maggior parte dei miei scripts

# Dipendenze

es_extended

--- NELLA PRIMA VERSIONE è DISPONIBILE SOLO IL MIO GRIDSYSTEM ---

# EXPORT

-- EXPORT PER USARLO --
 ```
exports['crystal_lib']:CRYSTAL().gridsystem({ 
    pos = vector3(0,0,0), -- posizione del marker
    rot = vector3(90.0, 90.0, 90.0) -- rotazione del marker
    scale = vector3(0.8, 0.8, 0.8), -- grandezza del marker
    textureName = 'marker', -- nome della texture del marker.ytd
    saltaggio = true, -- in questo modo il marker saltellerà
    permission = 'police', -- in questo caso solo la polizia potrà accedere al marker (se questa linea verrà cancellata tutti potranno accederci)
    job_grade = 2, -- in questo modo solamente il job police (settato subito sopra) con questo grado potra accedere al marker
    msg = 'Premi [E] per interagire', -- messagio che compare se sarai sopra al marker
    key = 38, -- in questo modo premendo G eseguira la funzione qui sotto (se questa linea non ci fosse, il tasto di default è 38 ovvero E)
    action = function () -- funzione da eseguire se premuto il tasto settato
        print('ciao')
    end
})
 ```
By Alga11
