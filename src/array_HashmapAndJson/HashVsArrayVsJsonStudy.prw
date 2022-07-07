#include "protheus.ch"
#define TAM_TEST 10000
#define TAM_TEST_TEXT LTrim( Transform(TAM_TEST, "9,999,999") )

//-------------------------------------------------------------------
/*/{Protheus.doc} Benchmark
Função para testes de array, hashmap e json
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
User Function Benchmark()

    ConOut( CRLF, "Teste de performance Array vs Hash vs Json"  )
    ConOut("Tamanho do teste " + TAM_TEST_TEXT + " registros."  )

    ArrayVersion()
    HashVersion()
    JsonVersion()
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ArrayVersion
Função de testes de performance utilizando array
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ArrayVersion()

    Local aBase  as array 
    Local cKey   as character 
    Local nAsc   as numeric 
    Local nX     as numeric 
    Local nStart as numeric 
    Local bBloco as codeblock

    aBase  := {}
    cKey   := ""
    nAsc   := 64
    nX     := 0
    nStart := Seconds()

    bBloco := { |registro| registro[1] == cKey }
    
    ConOut( CRLF, "Teste de perfomance de Array" )
    ConOut( "Iniciando a insercao de " + TAM_TEST_TEXT + " registros" )
    For nX := 1 to TAM_TEST
        nAsc++
        If nAsc > 90
            nAsc := 64
        EndIf
        cKey := Replicate( Chr( nAsc ), 6 ) + cValTochar( nX )
        AAdd( aBase, { cKey, nX } )
    Next nX
    ConOut( "Duracao da operacao: " + cValTochar( Seconds() - nStart ) )

    ConOut( "Iniciando a pesquisa de registros que nao existem " + TAM_TEST_TEXT + " vezes")
    cKey := "NOTFOUND"
    nStart := Seconds()
    For nX := 1 to TAM_TEST
        AScan( aBase, bBloco )
    Next nX
    ConOut( "Duracao da operacao: " + cValTochar( Seconds() - nStart ) )

    ConOut( "Pesquisando todos os "+ TAM_TEST_TEXT + " registros na estrutura")
    nStart := Seconds()
    nAsc := 64
    For nX := 1 to TAM_TEST
        nAsc++
        If nAsc > 90
            nAsc := 64
        EndIf
        cKey := Replicate( Chr( nAsc ), 6 ) + cValTochar( nX )
        If AScan( aBase, bBloco ) == 0
            ConOut( "error" )
        EndIf
    Next nX
    ConOut( "Duracao da operacao: " + cValTochar( Seconds() - nStart ) )

    Return

//-------------------------------------------------------------------
/*/{Protheus.doc} HashVersion
Função de testes de performance utilizando hashmap
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function HashVersion()

    Local cKey   as character 
    Local nAsc   as numeric 
    Local nX     as numeric 
    Local nStart as numeric 
    Local oHash  as object 

    cKey   := ""
    nAsc   := 64
    nX     := 0
    nStart := Seconds()
    oHash  := FWHashMap():New()

    ConOut( CRLF, "Teste de perfomance de Hash" )
    ConOut( "Iniciando a insercao de " + TAM_TEST_TEXT + " registros" )
    For nX := 1 to TAM_TEST
        nAsc++
        If nAsc > 90
            nAsc := 64
        EndIf
        cKey := Replicate( Chr( nAsc ), 6 ) + cValTochar( nX )
        oHash:Put( cKey, nX )
    Next nX
    ConOut( "Duracao da operacao: " + cValTochar( Seconds() - nStart ) )

    ConOut( "Iniciando a pesquisa de registros que nao existem " + TAM_TEST_TEXT + " vezes")
    cKey := "NOTFOUND"
    nStart := Seconds()
    For nX := 1 to TAM_TEST
        oHash:Get( cKey )
    Next nX
    ConOut( "Duracao da operacao: " + cValTochar( Seconds() - nStart ) )

    nStart := Seconds()
    ConOut( "Pesquisando todos os "+ TAM_TEST_TEXT + " registros na estrutura")
    nAsc := 64
    For nX := 1 to TAM_TEST
        nAsc++
        If nAsc > 90
            nAsc := 64
        EndIf
        cKey := Replicate( Chr( nAsc ), 6 ) + cValTochar( nX )
        If !oHash:ContainsKey( cKey )
            ConOut( "error" )
        EndIf
    Next nX
    ConOut( "Duracao da operacao: " + cValTochar( Seconds() - nStart ) )

    oHash:Destroy()

    Return

//-------------------------------------------------------------------
/*/{Protheus.doc} JsonVersion
Função de testes de performance utilizando json
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JsonVersion()

    Local cKey   as character 
    Local nAsc   as numeric 
    Local nX     as numeric 
    Local nStart as numeric 
    Local oBase  as json 
  
    cKey   := ""
    nAsc   := 64
    nX     := 0
    nStart := Seconds()
    oBase := JsonObject():New()

    ConOut( CRLF, "Teste de perfomance de Json" )
    ConOut( "Iniciando a insercao de " + TAM_TEST_TEXT + " registros" )
    For nX := 1 to TAM_TEST
        nAsc++
        If nAsc > 90
            nAsc := 64
        EndIf
        cKey := Replicate( Chr( nAsc ), 6 ) + cValTochar( nX )
        oBase[cKey] := nX
    Next nX
    ConOut( "Duracao da operacao: "+ cValTochar( Seconds() - nStart ) )

    ConOut( "Iniciando a pesquisa de registros que nao existem " + TAM_TEST_TEXT + " vezes")
    cKey := "NOTFOUND"
    nStart := Seconds()
    For nX := 1 to TAM_TEST
        If(oBase[cKey] == Nil, Nil, Nil)
    Next nX
    ConOut( "Duracao da operacao: "+ cValTochar( Seconds() - nStart ) )

    ConOut( "Pesquisando todos os "+ TAM_TEST_TEXT + " registros na estrutura")
    nStart := Seconds()
    nAsc := 64
    For nX := 1 to TAM_TEST
        nAsc++
        If nAsc > 90
            nAsc := 64
        EndIf
        cKey := Replicate( Chr( nAsc ), 6 ) + cValTochar( nX )
        If oBase[cKey] == Nil
            ConOut( "error" )
        EndIf
    Next nX
    ConOut( "Duracao da operacao: " + cValTochar( Seconds() - nStart ) )

    oBase:fromJson("{}")

    Return
