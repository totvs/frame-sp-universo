#include 'protheus.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} MyIsam
Função de exemplo do uso de inserção no modo isam
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
User Function MyIsam()
 
    Local aStruct       as array
    Local nX            as numeric
    Local oTempTable    as object 
    Local cAlias        as character 
    Local nStart        as numeric 
 
    RpcSetEnv('T1')

    nStart := Seconds()
    aStruct := {}
 
    aAdd( aStruct, { 'FIELD1', 'C', 10, 0 } )
    aAdd( aStruct, { 'FIELD2', 'N', 10, 2 } )
    aAdd( aStruct, { 'FIELD3', 'M', 10, 0 } )
    aAdd( aStruct, { 'FIELD4', 'D', 8, 0 } )
    aAdd( aStruct, { 'FIELD5', 'L', 1, 0 } )

    cAlias := "TESTE"

    oTempTable := FWTemporaryTable():New( cAlias )

    oTemptable:SetFields( aStruct )
 
    oTempTable:Create()
 
    For nX := 1 to 100
        RecLock(cAlias,.T.)
        (cAlias)->FIELD1     := cValToChar(nX)
        (cAlias)->FIELD2      := (nX,nX)
        (cAlias)->FIELD3      := cValToChar(nX)
        (cAlias)->FIELD4      := Date()
        (cAlias)->FIELD5      := mod(nX,2)==0
        MsUnLock()
    Next
    oTempTable:Delete()
    Conout('Tempo de inserção - ' + cValToChar(Seconds() - nStart))

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} myBulk
Função de exemplo do uso do bulk de dados
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
User Function myBulk()
 
    Local oBulk         as object
    Local aStruct       as array
    Local nX            as numeric
    Local oTempTable    as object 
    Local cAlias        as character 
    Local nStart        as numeric 
    
    RpcSetEnv('T1')
    nStart := Seconds()
    aStruct := {}
 
    aAdd( aStruct, { 'FIELD1', 'C', 10, 0 } )
    aAdd( aStruct, { 'FIELD2', 'N', 10, 2 } )
    aAdd( aStruct, { 'FIELD3', 'M', 10, 0 } )
    aAdd( aStruct, { 'FIELD4', 'D', 8, 0 } )
    aAdd( aStruct, { 'FIELD5', 'L', 1, 0 } )

    cAlias := "TESTE"

    oTempTable := FWTemporaryTable():New( cAlias )

    oTemptable:SetFields( aStruct )
 
    oTempTable:Create()
 
    oBulk := FwBulk():New(oTempTable:GetRealName())
    oBulk:SetFields(aStruct)
 
    For nX := 1 to 100
        oBulk:AddData({cValToChar(nX),(nX,nX),cValToChar(nX),Date(),mod(nX,2)==0})
    Next
    oBulk:Close()
    oBulk:Destroy()
    oBulk := nil
    Conout('Tempo de inserção - ' + cValToChar(Seconds() - nStart))
Return

