#include 'protheus.ch'
#Define TAM_TEST 20000
//-------------------------------------------------------------------
/*/{Protheus.doc} ArrayVersion
Função que evidencia os tempos de inserção e busca em arrays
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
User Function ArrayVersion()

Local aBase     as array 
Local nX        as numeric 
Local nStart    as numeric 
Local cKey      as character 
Local nAsc      as numeric 

aBase := {}
nStart := Seconds()
nAsc := 64

Conout('Iniciando inserção:')

For nX := 1 to TAM_TEST
    nAsc ++
    If nAsc > 90
        nAsc := 64
    Endif 
    cKey := Replicate (Chr(nASc),6) + cValToChar(nX)
    aAdd(aBase,cKey)
Next nX

Conout('Tempo de Insert : ' + cValToChar(Seconds() - nStart))

Conout('Seek de itens que nao existem:')
nStart := Seconds()
cKey := 'NOT_FOUND'

For nX := 1 to TAM_TEST 
    If aScan(aBase,cKey) > 0
        Conout("Erro, nao deveria achar")
    Endif 
Next nX

Conout('Tempo de seek dos nao existentes ' + cValToChar(Seconds() - nStart))

Conout('Seek de todos os itens existentes:')
nStart := Seconds()
nAsc := 64

For nX := 1 to TAM_TEST 
    nAsc ++
    If nAsc > 90
        nAsc := 64
    Endif 
    cKey := Replicate (Chr(nASc),6) + cValToChar(nX)
    If aScan(aBase,cKey) == 0
        Conout("Erro, deveria achar")
    Endif 
Next nX

Conout('Tempo de seek existente ' + cValToChar(Seconds() - nStart))

Return 
//-------------------------------------------------------------------
/*/{Protheus.doc} HashVersion
Função que evidencia os tempos de inserção e busca em hashmap
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
    
User Function HashVersion()

Local oHash     as object  
Local nX        as numeric 
Local nStart    as numeric 
Local cKey      as character 
Local nAsc      as numeric 

oHash := FWHashMap():New()
nStart := Seconds()
nAsc := 64

Conout('Iniciando inserção:')

For nX := 1 to TAM_TEST
    nAsc ++
    If nAsc > 90
        nAsc := 64
    Endif 
    cKey := Replicate (Chr(nASc),6) + cValToChar(nX)
    oHash:Put(cKey,'')
Next nX

Conout('Tempo de Insert : ' + cValToChar(Seconds() - nStart))

Conout('Seek de itens que nao existem:')
nStart := Seconds()
cKey := 'NOT_FOUND'

For nX := 1 to TAM_TEST 
    If oHash:ContainsKey(cKey) 
        Conout("Erro, nao deveria achar")
    Endif 
Next nX

Conout('Tempo de seek dos nao existentes ' + cValToChar(Seconds() - nStart))

Conout('Seek de todos os itens existentes:')
nStart := Seconds()
nAsc := 64

For nX := 1 to TAM_TEST 
    nAsc ++
    If nAsc > 90
        nAsc := 64
    Endif 
    cKey := Replicate (Chr(nASc),6) + cValToChar(nX)
    If !oHash:ContainsKey(cKey)
        Conout("Erro, deveria achar")
    Endif 
Next nX
oHash:Destroy()
oHash := nil 

Conout('Tempo de seek existente ' + cValToChar(Seconds() - nStart))

Return 
