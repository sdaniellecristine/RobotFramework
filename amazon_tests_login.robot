*** Settings ***

Documentation    Essa suíte de teste é responsável por validar o menu Login + Acessos.

Resource         amazon_resources.robot
Test Setup       Abrir o navegador
Test Teardown    Fechar navegador

*** Test Cases ***
Pré-Requisitos
    Definir repositório para evidências
    
Caso de Teste 01 - Login com Sucesso
    Dado que estou na home page Amazon.com
    Quando eu acessar a sessão Login
    E informar os dados de acesso
    Então o login será realizado com sucesso
    Capture Page Screenshot

Caso de Teste 02 - Login sem Sucesso - Email Incorreto
    Dado que estou na home page Amazon.com
    Quando eu acessar a sessão Login
    E informar os dados de acesso - Email Incorreto
    Então o login será apresentada a mensagem de erro - Email
    Capture Page Screenshot

Caso de Teste 03 - Login sem Sucesso - Senha Incorreta
    Dado que estou na home page Amazon.com
    Quando eu acessar a sessão Login
    E informar os dados de acesso - Senha Incorreta
    Então o login será apresentada a mensagem de erro - Senha
    Capture Page Screenshot