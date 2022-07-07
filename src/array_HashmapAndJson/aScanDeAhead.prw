#include 'protheus.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xTstAscanHead
Função para identificar o tempo de busca de dados em array 
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
User function xTstAscanHead()

Local aHeader   as array 
Local nStart    as numeric 
Local nI        as numeric

RpcSetEnv('T1','D MG 01')

aHeader := SD1->(DbStruct())

nStart := Seconds()

For nI := 1 to Len(aHeader)
//mais de 1 coluna com o mesmo nome de variavel
    If aScan(Aheader,{|x| Upper(Alltrim(x[1])) == Upper(Alltrim(aHeader[nI,1]))}, nI + 1)
        Conout('Achei')
    Endif 
Next nI

Conout('Tempo total de aScan: ' + cValToChar(Seconds() - nStart))

Return 


//-------------------------------------------------------------------
/*/{Protheus.doc} xTstHashC
Função para identificar o tempo de busca de dados em hashmap 
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
User function xTstHashC()

Local aHeader   as array 
Local nStart    as numeric 
Local nI        as numeric
Local oHash     as object 
Local cKey      as character 

RpcSetEnv('T1','D MG 01')
oHash := FWHashMap():New()
aHeader := SD1->(DbStruct())
nStart := Seconds()

For nI := 1 to Len(aHeader)
//mais de 1 coluna com o mesmo nome de variavel
    cKey := Upper(Alltrim(aHeader[nI,1]))
    If !oHash:ContainsKey(cKey)
        oHash:Put(cKey,'')
    Endif 
Next nI
oHash:Destroy()
oHash := nil 

Conout('Tempo total de Hash: ' + cValToChar(Seconds() - nStart))

Return 
