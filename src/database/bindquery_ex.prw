#include 'protheus.ch'

Static _oPrepared as object 

//-------------------------------------------------------------------
/*/{Protheus.doc} myExec
Exemplo mostrando o uso da FWExecStatement, usando inclusive
varíavel static para montar um cache na rotina. Esta classe deriva da classe FwPreparedStatement,
possuindo os mesmos métodos, porém utiliza o bind de queries nativo do dbaccess, que faz com que as queries
não sejam recompiladas a todo momento no banco de dados, deixando o processo muito mais rápido.
Atenção ao cache static. Ele nem sempre é necessário. Deve ser avaliado caso a caso
Aqui ilustramos apenas para mostrar que é possível.
A classe também permite passar parâmetros para criar o cache de queries. Caso informados, na sintaxe abaixo, ele irá 
assumir também o comportamento da FWExecCachedQuery (https://tdn.totvs.com/display/PROT/FWExecCachedQuery)
    _oPrepared:OpenAlias(cAlias,cLifeTime,cTimeout)
    _oPrepared:ExecScalar(cColumn,cLifeTime,cTimeout)

Documentação disponível em https://tdn.totvs.com/display/framework/FWExecStatement

@author  framework
@since   01/10/021
@version 1.0
/*/
//-------------------------------------------------------------------
user Function myExec()

Local cQuery    as character 
Local nTime     as numeric 
Local nX        as numeric 
Local cAlias    as character 

//-----------------------------
//como estamos rodando 'por fora' para testes, é necessário abrir o ambiente para nossos testes
//-----------------------------

RpcSetEnv('T1')

If _oPrepared == nil 
    cQuery := "SELECT ? FROM SE1T10 WHERE E1_FABOV = ? AND  D_E_L_E_T_ = ?"
    cQuery := ChangeQuery(cQuery)
    _oPrepared := FwExecStatement():New(cQuery)
Endif 

//ao contrário do código da fwprepareadstatement, não precisamos mais do GetNextAlias
//cAlias := GetNextAlias()

_oPrepared:SetString(3,' ')
_oPrepared:SetUnsafe(1,'E1_NUM')

nTime := Seconds()

For nX := 1 to 10
 
    _oPrepared:SetNumeric(2,cValToChar(nX -1))
    //ao contrário do código da fwpreparedstatement, não precisamos mais recuperar a query
    //cQuery := _oPrepared:GetFixQuery()
    
    //ao contrário do código da fwpreparedstatement, não precisamos mais usar o dbusearea
    // DbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),cAlias)

    cAlias := _oPrepared:OpenAlias(,'300','120')

    //Também existe o método ExecScalar para esta classe, que se comporta bem parecido com a 
    //função FwExecScalar
    //cQuery := "SELECT COUNT(*) CNT FROM SE1T10 WHERE E1_FABOV = ? AND  D_E_L_E_T_ = ?"
    //...........................
    //_oPrepared:ExecScalar('CNT')
    

    (cAlias)->(DbCloseArea())

Next

Conout('Tempo decorrido - '+ cValToChar(Seconds() - ntime ))

Return 

//-------------------------------------------------------------------
/*/{Protheus.doc} myBind
Exemplo mostrando o uso da MpSysOpenquery, utilizando o bind de queries nativo do dbaccess, que faz com que as queries
não sejam recompiladas a todo momento no banco de dados, deixando o processo muito mais rápido.

Documentações - https://tdn.totvs.com/display/framework/MPSysExecScalar e https://tdn.totvs.com/display/framework/MPSysOpenQuery


@author  framework
@since   01/10/021
@version 1.0
/*/
//-------------------------------------------------------------------
user Function mybind()

Local cQuery        as character 
Local cAlias        as character 
Local aBindParam    as array 

//-----------------------------
//como estamos rodando 'por fora' para testes, é necessário abrir o ambiente para nossos testes
//-----------------------------

RpcSetEnv('T1')

//diretamente pela função não existe 'setunsafe'
//cQuery := "SELECT ? FROM SE1T10 WHERE E1_FABOV = ? AND  D_E_L_E_T_ = ?"

cQuery := "SELECT E1_NUM FROM SE1T10 WHERE E1_FABOV = ? AND  D_E_L_E_T_ = ?"
cQuery := ChangeQuery(cQuery)

//os parametros DEVEM ser enviados na mesma ordem em que aparecem na query.
aBindParam := {'0', ' '}

cAlias  := MPSysOpenQuery(cQuery,,,,aBindParam)
//o execscalar também tem bind, com a sintaxe abaixo
//MPSysExecScalar(cQuery,cColumn,aBindParam)

(cAlias)->(DbCloseArea())


Return 
