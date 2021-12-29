/********************************************/
/***     JONAS CAMPOS - SG TRAINEE 2021    **/
/********************************************/

clear

set message to 21 center
setmode(25,80)
set scoreboard off


//borders
@ 00,00 to 24,79 double
@ 02,01 to 02,78 double
@ 04,01 to 04,78 double

//title
cTitulo := 'Frutaria do Jonas Brother'
cCidade := 'Maringa'
@ 01,01 say padC(cTitulo, 70)

//date
set date to British
set Epoch to 1930
set wrap off

dDataAgora := date()

nDataAno := year(dDataAgora)
nDataMes := month(dDataAgora)
nDataDia := day(dDataAgora)
nDataDiaSemana := dow(dDataAgora)

cDataMes := ''
cDataDiaSemana := ''

if nDataMes == 1
   cDataMes := "janeiro"
elseif nDataMes == 2
   cDataMes := "fevereiro"
elseif nDataMes == 3
   cDataMes := "marco"
elseif nDataMes == 4
   cDataMes := "abril"
elseif nDataMes == 5
   cDataMes := "maio"
elseif nDataMes == 6
   cDataMes := "junho"
elseif nDataMes == 7
   cDataMes := "julho"
elseif nDataMes == 8
   cDataMes := "agosto"
elseif nDataMes == 9
   cDataMes := "setembro"
elseif nDataMes == 10
   cDataMes := "outubro"
elseif nDataMes == 11
   cDataMes := "novembro"
elseif nDataMes == 12
   cDataMes := "dezembro"
endif

if nDataDiaSemana == 1
   cDataDiaSemana := "Domingo"
elseif nDataDiaSemana == 2
   cDataDiaSemana := "Segunda-feira"
elseif nDataDiaSemana == 3
   cDataDiaSemana := "Terca-feira"
elseif nDataDiaSemana == 4
   cDataDiaSemana := "Quarta-feira"
elseif nDataDiaSemana == 5
   cDataDiaSemana := "Quinta-feira"
elseif nDataDiaSemana == 6
   cDataDiaSemana := "Sexta-feira"
elseif nDataDiaSemana == 7
   cDataDiaSemana := "Sabado"
endif


//set color to W/B

//Mascaras
cMascaraTexto := '@!'
cMascaraAno := '@E 9999'

//footer
@ 22,01 to 22,78 double
@ 23,20 say cCidade + ' - ' + cDataDiaSemana + ', ' + transform(nDataDia, cMascaraTexto) + ' de ' + cDataMes + ' de ' + transform(nDataAno, cMascaraAno) + '.'

//prompts-navigation
nPromptOpcao := 1
nPromptEspacamento := 3

cPrompt1 := 'Efetuar Pedidos'
cPrompt1Message := 'Fazer novo Pedido'
cPrompt1Col = 30

cPrompt2 := 'Sair'
cPrompt2Message := 'Sai do sistema'
cPrompt2Col := cPrompt1Col + len(cPrompt1) + nPromptEspacamento

//tela login
cLogin            := Space( 5 )
cSenha            := Lower( Space( 8 )  )
nVendasPDV        := 0

cLoginUsuarioAtivo := 'ADMIN'
cSenhaUsuarioAtivo := '123'

//Tela de vendas
nVendaNumero := 1

// produtos cadastrados
nProduto1Codigo    := 3500
cProduto1Descricao := "BANANA PRATA"
nProduto1Valor     := 3.50
nProduto1TaxaDescontoMax  := 0.18
nProduto1DescontoMaxReais := nProduto1Valor - ( nProduto1Valor * nProduto1TaxaDescontoMax )
nProduto1Estoque   := 125.00

nProduto2Codigo    := 4501
cProduto2Descricao := "PERA ARGENTINA"
nProduto2Valor     := 7.00
nProduto2TaxaDescontoMax  := 0.16
nProduto2DescontoMaxReais := nProduto2Valor - ( nProduto2Valor * nProduto2TaxaDescontoMax )
nProduto2Estoque   := 119.50

nProduto3Codigo    := 7001
cProduto3Descricao := "BATATA PERUANA"
nProduto3Valor     := 2.00
nProduto3TaxaDescontoMax  := 0.09
nProduto3DescontoMaxReais := nProduto3Valor - ( nProduto3Valor * nProduto3TaxaDescontoMax )
nProduto3Estoque   := 865.00

nProduto4Codigo    := 6002
cProduto4Descricao := "ABACATE NEGRO"
nProduto4Valor     := 1.99
nProduto4TaxaDescontoMax  := 0.03
nProduto4DescontoMaxReais := nProduto4Valor - ( nProduto4Valor * nProduto4TaxaDescontoMax )
nProduto4Estoque   := 200

//controle de retorno para estoque
nProduto1ControleEstoque := 0
nProduto2ControleEstoque := 0
nProduto3ControleEstoque := 0
nProduto4ControleEstoque := 0

//programa principal
Do while .T.
   
   //tela de login
   @ 05,01 say 'Login: '
   @ 05,20 say 'Senha: '

   @ 05,08 get cLogin picture '@!'  Valid( Alltrim( cLogin ) $ cLoginUsuarioAtivo)
   @ 05,27 get cSenha picture '@!'  Valid( Alltrim( cSenha ) $ cSenhaUsuarioAtivo)
   read

   if lastkey() == 27
      nOpcaoSair := alert("Deseja sair do programa?",{"Sim","Nao"})
      if nOpcaoSair == 1
         exit
      endif
      loop
   endif


   @ 05,01 clear to 05,70

   //menu principal
   @ 03,cPrompt1Col prompt cPrompt1 message cPrompt1Message
   @ 03,cPrompt2col prompt cPrompt2 message cPrompt2Message
   menu to nPromptOpcao

   if lastKey() == 27
     //tratar aqui

   endIf

   if nPromptOpcao == 2 .or. lastKey() == 27
      nAlertSair := alert('Sair do sistema?',{'Sim', 'Nao'} )
      if nAlertSair == 2
         loop
      endIf
      exit

   else

      cClienteNome       := space(30)
      dVendaData          := dDataAgora
      nClienteLimiteCredito := 0
      
      @ 05,00 say padc("Venda:" + transform(nVendaNumero,"99"),78)
      @ 06,01 say "Cliente....:"
      @ 07,01 say "Data venda.:"
      @ 08,01 say "Limite.....:"

      @ 06,13 get cClienteNome       picture "@!"              valid !empty(cClienteNome)
      @ 07,13 get dVendaData                                    valid !empty(dVendaData)
      @ 08,13 get nClienteLimiteCredito picture "@E 9,999,999.99" valid nClienteLimiteCredito > 0
      read
      
      //if laskety

      nLinha                  := 11
      nLinhaCabecalho := 10
      nVendaValorTotalPagar := 0
      nProduto1Venda        := 0
      nProduto2Venda        := 0
      nProduto3Venda        := 0

      //tela de produtos
      do while .t.

         @ nLinhaCabecalho,01 say 'Cod '
         @ nLinhaCabecalho,06 say 'Descricao'
         @ nLinhaCabecalho,21 say 'Valor Un.'
         @ nLinhaCabecalho,35 say 'Quant.'
         @ nLinhaCabecalho,42 say 'Desconto (%)'
         @ nLinhaCabecalho,56 say 'SubTotal'
         @ nLinhaCabecalho,66 say 'Total'
         @ nLinhaCabecalho,72 say 'Estoque'
         @ 23,10 say "Total pagar:"

         nProdutoCodigo     := 0
         cProdutoDescricao  := space(30)
         nProdutoQuantidade := 0
         nProdutoValor      := 0
         nProdutoDesconto   := 0
         nProdutoDescontoMax := 0
         nProdutoValorTotal := 0
         nProdutoEstoque    := 0
 
         //

         if nLinha == 20
            nLinha := 11
            @ 11,01 clear to 20,78
         endif

         @ nLinha,01 get nProdutoCodigo     picture "9999"      valid( !empty(nProdutoCodigo))
         read

         if nProdutoCodigo == nProduto1Codigo
            cProdutoDescricao    := cProduto1Descricao
            nProdutoValor        := nProduto1Valor
            nProdutoEstoque      := nProduto1Estoque
            nProdutoDescontoMax  := nProduto1TaxaDescontoMax

         elseif nProdutoCodigo == nProduto2Codigo
            cProdutoDescricao    := cProduto2Descricao
            nProdutoValor        := nProduto2Valor
            nProdutoEstoque      := nProduto2Estoque
            nProdutoDescontoMax  := nProduto2TaxaDescontoMax

         elseif nProdutoCodigo == nProduto3Codigo
            cProdutoDescricao    := cProduto3Descricao
            nProdutoValor        := nProduto3Valor
            nProdutoEstoque      := nProduto3Estoque
            nProdutoDescontoMax  := nProduto3TaxaDescontoMax

         elseif nProdutoCodigo == nProduto4Codigo
            cProdutoDescricao    := cProduto4Descricao
            nProdutoValor        := nProduto4Valor
            nProdutoEstoque      := nProduto4Estoque
            nProdutoDescontoMax  := nProduto4TaxaDescontoMax
         else
            alert("Produto nao encontrado")
            loop
         endif

         @ nLinha,06 say cProdutoDescricao
         @ nLinha,21 say transform(nProdutoValor  ,"@E 999.99")
         @ nLinha,72 say transform(nProdutoEstoque,"@E 999.99")

         @ nLinha, 35 get nProdutoQuantidade   picture '999.99' Valid nProdutoQuantidade > 0         //Valid nQuantidade <= nEstoque .and. nQuantidade > 0         
         @ nLinha, 42 get nProdutoDesconto picture "99" valid( nProdutoDesconto / 100 )   <= nProdutoDescontoMax
         read

         if nProdutoCodigo == nProduto1Codigo
            nProduto1ControleEstoque += nProdutoQuantidade
         elseif nProdutoCodigo == nProduto2Codigo
               nProduto2ControleEstoque += nProdutoQuantidade
         elseif nProdutoCodigo == nProduto3Codigo
               nProduto3ControleEstoque += nProdutoQuantidade
         elseif nProdutoCodigo == nProduto4Codigo
               nProduto4ControleEstoque += nProdutoQuantidade
         endif
         
         //nProdutoEstoque -= n
         
         nLinha++

      enddo

   endIf



endDo


//area util linha 04-18


