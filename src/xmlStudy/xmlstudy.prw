#include 'protheus.ch'
Static _xmlTeste

//-------------------------------------------------------------------
/*/{Protheus.doc} xmlstudy
Função de estudo de performance em xml
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
user function xmlstudy()

LoadXmlP()

LoadTxml()

Return 

//-------------------------------------------------------------------
/*/{Protheus.doc} LoadXmlP
Função de estudo de performance com xmlparser
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function LoadXmlP()

Local cError    as character 
Local cWarning  as character
Local oXml      as object
Local nTime     as numeric

cError := ''
cWarning := ''
If _xmlTeste == nil 
    _xmlTeste := retXml()
Endif 
nTime := Seconds()
oXml := XmlParser(_xmlTeste,"_",@cError,@cWarning)
Conout(oXml:_XMLTESTE:_XMLLEVEL:_LEVEL499:_LEVEL4991:_LEVEL4992:TEXT)
Conout('Tempo de parser - ' + cValToChar(Seconds() - nTime))
oXml := nil 

Return 

//-------------------------------------------------------------------
/*/{Protheus.doc} LoadXmlP
Função de estudo de performance com tXmlManager
@author  framework
@since   01/01/2021
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function LoadTxml()
Local oXml  as object
Local nTime as numeric 


If _xmlTeste == nil 
    _xmlTeste := retXml()
Endif 

nTime := Seconds()
oXml := tXmlManager():New()
oXml:Parse(_xmlTeste)
Conout(oXml:xPathGetNodeValue("/xmlteste/xmllevel/level499/level4991/level4992"))
Conout('Tempo de parser - ' + cValToChar(Seconds() - nTime))
oXml := nil 

return 

//-------------------------------------------------------------------
/*/{Protheus.doc} retXml
Função que retorna o xml para nossos testes.

@return cXml Xml para os testes de performance.
@author  framework
@since   01/01/2022
@version 1.0
/*/
//-------------------------------------------------------------------

Static function retXml()
Local cXml  as character 
Local nX    as numeric 
Local cNum  as character 

cXml := '<xmlteste>'
cXml += '<xmllevel>'

For nX := 1 to 5000
    cNum := cValToChar(nX)
    cXml += '<level' + cNum + '>'
    cXml += '<level' + cNum + '1>'
    cXml += '<level' + cNum + '2>'
    cXml += cNum
    cXml += '</level' + cNum + '2>'
    cXml += '</level' + cNum + '1>'
    cXml += '</level' + cNum + '>'
Next 

cXml += '</xmllevel>'
cXml += '</xmlteste>'

Return cXml

    
