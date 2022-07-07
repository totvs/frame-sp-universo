#include 'protheus.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} cache_ex
Este exemplo mostra o uso do cache de queries. 
Este cache faz com que a query seja buscada na dbapi, se for o mesmo resultset.
muito útil quando executamos a mesma query em diversos lugares do sistema
Documentação disponível em https://tdn.totvs.com/display/PROT/FWExecCachedQuery
@author  framework
@since   08/10/2021
@version 1.0
/*/
//-------------------------------------------------------------------
user function cache_ex()

Local cQuery    as character 
Local cAlias    as character 
Local nTime     as numeric 
Local nX        as numeric 
Local oExec     as object 

//----------------------------------
//para o exemplo vamos conectar no banco de dados.
//mas para uso, basta estar conectado
//----------------------------------
TcLink()

cQuery := "SELECT E1_NUM FROM SE1T10 WHERE E1_FABOV = 0 AND  D_E_L_E_T_ = ' '"

cAlias := GetNextAlias()

Conout('******************************dbuseArea***************')

For nX := 1 to 10
    nTime := Seconds()

    DbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),cAlias)

    Conout('Tempo decorrido - '+ cValToChar(Seconds() - ntime ))

    (cAlias)->(DbCloseArea())
Next

//executando com cache

Conout('******************************Cache***************')

For nX := 1 to 10
    nTime := Seconds()

    cAlias := FwExecCachedQuery():OpenQuery(cQuery,,,,'300','120')

    Conout('Tempo decorrido - '+ cValToChar(Seconds() - ntime ))

    (cAlias)->(DbCloseArea())
Next


//executando com cache

Conout('******************************Cache e bind***************')
oExec := FWExecStatement():New("SELECT E1_NUM FROM SE1T10 WHERE E1_FABOV = ? AND  D_E_L_E_T_ = ?")
oExec:SetNumeric(1,0)
oExec:SetString(2,' ')

For nX := 1 to 10
    nTime := Seconds()

    oExec:OpenAlias(@cAlias,'300','120')

    Conout('Tempo decorrido - '+ cValToChar(Seconds() - ntime ))

    (cAlias)->(DbCloseArea())
Next
Return 


