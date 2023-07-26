*** Settings ***

Library        SeleniumLibrary   
Library        XML
Library        Collections

*** Variables ***
${URL}                https://www.amazon.com.br/
${MENULOGIN}          //span[@class='nav-line-1 nav-progressive-content'][contains(.,'Olá, faça seu login')]    

${EMAIL}              sdaniellecristine@gmail.com
${EMAILINCORRETO}     sdaniellecristin@gmail.com
${SENHA}              Bel2911*
${SENHAINCORRETA}     2544


${CAMPOTEXTOEMAIL}   //input[@type='email'][contains(@id,'email')]     
${CAMPOTEXTOSENHA}   //input[@type='password'][contains(@id,'password')]

${BOTÃOCONFEMAIL}    //input[contains(@tabindex,'5')]
${BOTÃOCONFSENHA}    //input[contains(@tabindex,'3')]


${CAMPOTEXTOBUSCA}  //input[contains(@type,'text')]
${TEXTOCAMPOBUSCA}  baton 182
${CATBUSCABELEZA}   //option[@value='search-alias=beauty'][contains(.,'Beleza')] 
${BOTÃOPESQUISAR}   nav-search-submit-text
${PRODUTOBELEZA}    //img[contains(@alt,'Batom - Nro. 182- Nuts, Koloss')]
${BOTÃOADDCART}     //input[contains(@name,'submit.add-to-cart')]
${MENUCART}        //div[@class=' nav-progressive-attribute'][contains(.,'Carrinho')]
${date}            Get Current Date

*** Keywords ***

Definir repositório para evidências
    Set Screenshot Directory    ./results/${date}

Abrir o navegador
    Open Browser    browser=chrome
    Maximize Browser Window  

Fechar navegador
    Close Browser

Dado que estou na home page Amazon.com
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENULOGIN}    timeout=10

Quando eu acessar a sessão Login
    Click Element    locator=${MENULOGIN} 
    Wait Until Page Contains    text=Fazer login    timeout=10 

E informar os dados de acesso
   Input Text    locator=${CAMPOTEXTOEMAIL}    text=${EMAIL}
   Click Button    locator=${BOTÃOCONFEMAIL}
   Wait Until Page Contains    text=Fazer login    timeout=10     
   Input Password    locator=${CAMPOTEXTOSENHA}    password=${SENHA}
   Click Button    locator=${BOTÃOCONFSENHA}

Então o login será realizado com sucesso
   Wait Until Page Contains    text=Olá, Danielle

E informar os dados de acesso - Email Incorreto
   Input Text    locator=${CAMPOTEXTOEMAIL}    text=${EMAILINCORRETO}
   Click Button    locator=${BOTÃOCONFEMAIL}

E informar os dados de acesso - Senha Incorreta
   Input Text    locator=${CAMPOTEXTOEMAIL}    text=${EMAIL}
   Click Button    locator=${BOTÃOCONFEMAIL}
   Wait Until Page Contains    text=Fazer login    timeout=10     
   Input Password    locator=${CAMPOTEXTOSENHA}    password=${SENHAINCORRETA}
   Click Button    locator=${BOTÃOCONFSENHA}
   
Então o login será apresentada a mensagem de erro - Email
    Wait Until Page Contains    text=Não encontramos uma conta associada a este endereço de e-mail

Então o login será apresentada a mensagem de erro - Senha
    Wait Until Page Contains    text=Sua senha está incorreta

Quando eu pesquisar "${TITLE}" por categoria através da ferramenta de busca
    Click Element    locator=${CATBUSCABELEZA}
    Input Text    locator=//input[contains(@type,'text')]    text=${TITLE}
    Click Element    locator=${BOTÃOPESQUISAR}
    Capture Page Screenshot

E acessar detalhes do produto
    Click Image   locator=${PRODUTOBELEZA}
    Capture Page Screenshot

E selecionar produto para o carrinho
    Click Element    locator=${BOTÃOADDCART}
    Capture Page Screenshot 
    Click Element    locator=${MENUCART}
    Capture Page Screenshot

Então deverá ser apresentado o produto "${TITLE}" e quantidade selecionada na sessão "${TITLE}"
    Title Should Be    title=${TITLE} 
    Wait Until Page Contains Element    locator=//span[@class='a-truncate-cut'][contains(.,'Batom - Nro. 182- Nuts, Koloss')]
    Capture Page Screenshot
    Page Should Contain Element    locator=//span[@class='a-button-text a-declarative'][contains(.,'Qtd:1')]
    Capture Page Screenshot
    Capture Element Screenshot    locator=//span[@class='a-button-text a-declarative'][contains(.,'Qtd:1')]