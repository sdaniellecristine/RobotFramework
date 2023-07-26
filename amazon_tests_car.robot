*** Settings ***

Documentation    Essa suíte de teste é responsável por validar o menu Carrinho.

Resource         amazon_resources.robot
Test Setup       Abrir o navegador
Test Teardown    Fechar navegador

 


*** Test Cases ***
Pré-Requisitos
    Definir repositório para evidências

Caso de Teste 01 - Adicionar produto no Carrinho 
    Dado que estou na home page Amazon.com
    Quando eu pesquisar "Baton 182" por categoria através da ferramenta de busca
    E acessar detalhes do produto
    E selecionar produto para o carrinho
    Então deverá ser apresentado o produto "Batom - Nro. 182- Nuts, Koloss" e quantidade selecionada na sessão "Carrinho de compras da Amazon.com" 