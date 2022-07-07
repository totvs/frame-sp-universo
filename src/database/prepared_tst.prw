#include 'protheus.ch'

Static _oPrepared as object 


//-------------------------------------------------------------------
/*/{Protheus.doc} MyChangQuery
Função para evidenciar o tempo com um looping de changequery
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
user Function MyChangQuery()

Local cQuery    as character 
Local nTime     as numeric 
Local nX        as numeric 
Local cAlias    as character 

//-----------------------------
//como estamos rodando 'por fora' para testes, é necessário abrir o ambiente para nossos testes
//-----------------------------

RpcSetEnv('T1')

cAlias := GetNextAlias()

nTime := Seconds()

For nX := 1 to 100

    cQuery := "select e1_filial, e1_prefixo, e1_num, e1_parcela, e1_tipo, e1_naturez, e1_portado, "
    cQuery += "e1_agedep, e1_cliente, e1_loja, e1_nomcli, e1_emissao, e1_vencto, e1_vencrea, e1_valor, "
    cQuery += "e1_baseirf, e1_iss, e1_irrf, e1_numbco, e1_indice, e1_baixa, e1_numbor, e1_databor, e1_emis1, "
    cQuery +="e1_hist, e1_la, e1_lote, e1_motivo, e1_movimen, e1_op, e1_situaca, e1_contrat, e1_saldo, e1_supervi, "
    cQuery +="e1_vend1, e1_vend2, e1_vend3, e1_vend4, e1_vend5, e1_comis1, e1_comis2, e1_comis3, e1_comis4, "
    cQuery += "e1_descont, e1_comis5, e1_multa, e1_juros, e1_correc, e1_valliq, e1_vencori, e1_conta, e1_valjur, "
    cQuery += "e1_porcjur, e1_moeda, e1_bascom1, e1_bascom2, e1_bascom3, e1_bascom4, e1_bascom5, e1_fatpref, "
    cQuery += "e1_fatura, e1_ok, e1_projeto, e1_clascon, e1_valcom1, e1_valcom2, e1_valcom3, e1_valcom4, 
    cQuery += "e1_valcom5, e1_ocorren, e1_instr1, e1_instr2, e1_pedido, e1_dtvaria, e1_varurv, e1_vlcruz, "
    cQuery += "e1_dtfatur, e1_numnota, e1_serie, e1_status, e1_origem "
    cQuery += "from se1t10 "
    cQuery += "where e1_fabov = " + cValToChar(nX - 1) + " AND  d_e_l_e_t_ = ' '"

    cQuery := ChangeQuery(cQuery)

    DbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),cAlias)

    (cAlias)->(DbCloseArea())

Next

Conout('Tempo decorrido - '+ cValToChar(Seconds() - ntime ))

Return 

//-------------------------------------------------------------------
/*/{Protheus.doc} myprepared
Exemplo mostrando o uso da FWPreparedStatement, usando inclusive
varíavel static para montar um cache na rotina.
Atenção ao cache static. Ele nem sempre é necessário. Deve ser avaliado caso a caso
Aqui ilustramos apenas para mostrar que é possível.
Documentação disponível em https://tdn.totvs.com/display/framework/FWPreparedStatement

@author  framework
@since   01/10/021
@version 1.0
/*/
//-------------------------------------------------------------------
user Function myprepared()

Local cQuery    as character 
Local nTime     as numeric 
Local nX        as numeric 
Local cAlias    as character 

//-----------------------------
//como estamos rodando 'por fora' para testes, é necessário abrir o ambiente para nossos testes
//-----------------------------

RpcSetEnv('T1')

If _oPrepared == nil 
    cQuery := "select e1_filial, e1_prefixo, e1_num, e1_parcela, e1_tipo, e1_naturez, e1_portado, "
    cQuery += "e1_agedep, e1_cliente, e1_loja, e1_nomcli, e1_emissao, e1_vencto, e1_vencrea, e1_valor, "
    cQuery += "e1_baseirf, e1_iss, e1_irrf, e1_numbco, e1_indice, e1_baixa, e1_numbor, e1_databor, e1_emis1, "
    cQuery +="e1_hist, e1_la, e1_lote, e1_motivo, e1_movimen, e1_op, e1_situaca, e1_contrat, e1_saldo, e1_supervi, "
    cQuery +="e1_vend1, e1_vend2, e1_vend3, e1_vend4, e1_vend5, e1_comis1, e1_comis2, e1_comis3, e1_comis4, "
    cQuery += "e1_descont, e1_comis5, e1_multa, e1_juros, e1_correc, e1_valliq, e1_vencori, e1_conta, e1_valjur, "
    cQuery += "e1_porcjur, e1_moeda, e1_bascom1, e1_bascom2, e1_bascom3, e1_bascom4, e1_bascom5, e1_fatpref, "
    cQuery += "e1_fatura, e1_ok, e1_projeto, e1_clascon, e1_valcom1, e1_valcom2, e1_valcom3, e1_valcom4, "
    cQuery += "e1_valcom5, e1_ocorren, e1_instr1, e1_instr2, e1_pedido, e1_dtvaria, e1_varurv, e1_vlcruz, "
    cQuery += "e1_dtfatur, e1_numnota, e1_serie, e1_status, e1_origem "
    cQuery += "from se1t10 "
    cQuery += "where e1_fabov = ? AND  d_e_l_e_t_ = ?"
    cQuery := ChangeQuery(cQuery)
    _oPrepared := FwPreparedStatement():New(cQuery)
Endif 

cAlias := GetNextAlias()

_oPrepared:SetString(2,' ')

nTime := Seconds()

For nX := 1 to 100

    _oPrepared:SetNumeric(1,cValToChar(nX -1))
    cQuery := _oPrepared:GetFixQuery()
    

    DbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),cAlias)
    (cAlias)->(DbCloseArea())

Next

Conout('Tempo decorrido - '+ cValToChar(Seconds() - ntime ))

Return 


//-------------------------------------------------------------------
/*/{Protheus.doc} fwmyexec
Exemplo mostrando o uso da FWExecStatement, usando inclusive
varíavel static para montar um cache na rotina.
Atenção ao cache static. Ele nem sempre é necessário. Deve ser avaliado caso a caso
Aqui ilustramos apenas para mostrar que é possível.
Documentação disponível em https://tdn.totvs.com/display/framework/FWExecStatement

@author  framework
@since   01/10/2021
@version 1.0
/*/
//-------------------------------------------------------------------
user Function fwmyexec()

Local cQuery    as character 
Local nTime     as numeric 
Local nX        as numeric 
Local cAlias    as character 

//-----------------------------
//como estamos rodando 'por fora' para testes, é necessário abrir o ambiente para nossos testes
//-----------------------------

RpcSetEnv('T1')

If _oPrepared == nil 
    cQuery := "select e1_filial, e1_prefixo, e1_num, e1_parcela, e1_tipo, e1_naturez, e1_portado, "
    cQuery += "e1_agedep, e1_cliente, e1_loja, e1_nomcli, e1_emissao, e1_vencto, e1_vencrea, e1_valor, "
    cQuery += "e1_baseirf, e1_iss, e1_irrf, e1_numbco, e1_indice, e1_baixa, e1_numbor, e1_databor, e1_emis1, "
    cQuery +="e1_hist, e1_la, e1_lote, e1_motivo, e1_movimen, e1_op, e1_situaca, e1_contrat, e1_saldo, e1_supervi, "
    cQuery +="e1_vend1, e1_vend2, e1_vend3, e1_vend4, e1_vend5, e1_comis1, e1_comis2, e1_comis3, e1_comis4, "
    cQuery += "e1_descont, e1_comis5, e1_multa, e1_juros, e1_correc, e1_valliq, e1_vencori, e1_conta, e1_valjur, "
    cQuery += "e1_porcjur, e1_moeda, e1_bascom1, e1_bascom2, e1_bascom3, e1_bascom4, e1_bascom5, e1_fatpref, "
    cQuery += "e1_fatura, e1_ok, e1_projeto, e1_clascon, e1_valcom1, e1_valcom2, e1_valcom3, e1_valcom4, "
    cQuery += "e1_valcom5, e1_ocorren, e1_instr1, e1_instr2, e1_pedido, e1_dtvaria, e1_varurv, e1_vlcruz, "
    cQuery += "e1_dtfatur, e1_numnota, e1_serie, e1_status, e1_origem "
    cQuery += "from se1t10 "
    cQuery += "where e1_fabov = ? AND  d_e_l_e_t_ = ?"
    cQuery := ChangeQuery(cQuery)
    _oPrepared := FwExecStatement():New(cQuery)
Endif 

_oPrepared:SetString(2,' ')

nTime := Seconds()

For nX := 1 to 100

    _oPrepared:SetNumeric(1,cValToChar(nX -1))
    cAlias:= _oPrepared:OpenAlias()
    (cAlias)->(DbCloseArea())

Next

Conout('Tempo decorrido - '+ cValToChar(Seconds() - ntime ))

Return 

