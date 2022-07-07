#Include "totvs.ch"
#Include "restful.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MeuTeste
Serviço REST de exemplo 

@author  framework
@since   01/10/2021
@version 1.0
/*/
//-------------------------------------------------------------------
wsrestful meuteste1_0 description 'Classe teste de rest'

Wsdata Id as character 

wsmethod GET teste1_0 description 'teste1_0' wssyntax "/api/framework/v1/meuteste1_0/teste1_0";
path "/api/framework/v1/meuteste1_0/teste1_0"

END WSRESTFUL

//-------------------------------------------------------------------
/*/{Protheus.doc} Teste1
Serviço (get) para testes de retorno das requisições
@author  framework
@since   01/10/2021
@version 1.0
/*/
//-------------------------------------------------------------------
wsmethod GET teste1_0 WSSERVICE meuteste1_0

Local cReturn as character 

cReturn := '{"result":"ok"}'

Self:SetResponse(cReturn)

Return .T. 
