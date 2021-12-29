/********************************************/
/***     JONAS CAMPOS - SG TRAINEE 2021    **/
/********************************************/

set message to 21 center
setmode(25,80)
set scoreboard off

cCorPretoVerde := 'G/N+'
cCorPretoAmarelo := 'GR+/N+'
SetColor(cCorPretoVerde)
clear

//bordas e cores
@ 00,00 to 24,79 double
@ 02,01 to 02,78 double
@ 04,01 to 04,78 double


//title
cTitulo := 'Asistencia Tecnica SG'
cCidade := 'Maringa'
@ 01,01 say padC(cTitulo, 70)

//date
set date to British
set Epoch to 1940
set wrap off

dDataAgora     := date()
nDataAno       := year(dDataAgora)
nDataMes       := month(dDataAgora)
nDataDia       := day(dDataAgora)
nDataDiaSemana := dow(dDataAgora)
cDataMes       := ''
cDataDiaSemana := ''

//Tratamento para exibicao dos dias da semana e mes por extenso
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

//Mascaras
cMascaraTexto          := '@!'
cMascaraNumero         := '99'
cMascaraNumeroDecimal  := '99.99'
cMascaraAno            := '@E 9999'
cMascaraMonetario      := '@E 9,999.99'
cMascaraCNPJ           := "@E 99,999,999/9999-99"
cMascaraNota           := "999999999"
cMascaraTelefone       := "@E 99999-9999"

//footer
@ 22,01 to 22,78 double
@ 23,20 say cCidade + ' - ' + cDataDiaSemana + ', ' + transform(nDataDia, cMascaraTexto) + ' de ' + cDataMes + ' de ' + transform(nDataAno, cMascaraAno) + '.'

//prompts-navigation
nPromptOpcao         := 1
nPromptEspacamento   := 3

cPrompt1             := 'Efetuar Venda'
cPrompt1Message      := 'Inicia uma nova venda'
cPrompt1Col          := 15

cPrompt2             := 'Sair'
cPrompt2Message      := 'Sair do sistema'
cPrompt2Col          := len(cPrompt1) + cPrompt1Col  + nPromptEspacamento

/*************************/
/*** PROGRAMA PRINCIPAL **/
/*************************/

//dados para login
cLoginUser           := "SUPER"
cSenhaUser           := '123mudar'
lLoginOk             := .f.
//variaveis de controle
nOrdemServicoNumero  := 1

Do while .T.

   //tela de login
   if Empty(lLoginOk)
      cLogin                  := Space( 5 )
      cSenha                  := Lower( Space( 8 )  )
      nCompraGarantiaTotal    := 0
      nCompraTotal            := 0
      nOpcaoSair              := 0
      cReiniciarPrograma      := 'Nao'
      
      @ 05,01 say 'Login: '
      @ 05,20 say 'Senha: '

      cPedidoLiberado          := 'Nao'
      cVendaGarantia           := 'Nao'

      @ 05,08 get cLogin picture '@!'
      @ 05,27 get cSenha picture '@' color "w/W"
      read

      if !( AllTrim(cLogin) == cLoginUser ) .or. !( AllTrim(cSenha) == cSenhaUser )
         Alert('Usuriario e/ou senha invalidos.', , cCorPretoVerde )
         @ 05,01 clear to 05,50
         loop
      else
         lLoginOk := .t.
         @ 05,01 clear to 05,50
      endif

      if LastKey() == 27
         nOpcaoSair := Alert( 'Sair do sistema?', { 'Sim', 'Nao' }, cCorPretoVerde )
         if nOpcaoSair == 1 // sair programa
            exit
         endif

      endif
   endif
   // fim tela login

   //dados do cliente
   cClienteNome                  := space(50)
   cClienteEndereco              := space(50)
   cClienteBairro                := space(50)
   cClienteReferencia            := space(50)
   nClienteLimiteCredito         := 0
   nClienteLimiteCreditoCadastro := nClienteLimiteCredito
   nClienteTelefone              := 0

   //dados equipamento
   cEquipamentoDescricao         := space(50)
   dEquipamentoDataCompra        := ctod("")
   nEquipamentoTempoUso          := 0
   dCompraData                   := dDataAgora
   lGarantiaProduto              := .t.
   lGarantiaServico              := .t.

   //dados de entrega e atendimento
   cOpcaoEntregaDomicilio        := space(01)
   nTaxaEntrega                  := 0.03
   cTecnicoNome                  := space(40)

   @ 03,cPrompt1Col prompt cPrompt1 message cPrompt1Message
   @ 03,cPrompt2Col prompt cPrompt2 message cPrompt2Message
   menu to nPromptOpcao

   if nPromptOpcao == 1     //cadastro
     
      @ 05,01 say 'O.S....: ' + AllTrim(  Transform( nOrdemServicoNumero, '999999' ) ) color cCorPretoAmarelo
      @ 05,12 say 'Nome do tecnico...: '
      @ 07,01 say "Cliente................:"
      @ 08,01 say "Limite cliente........R$"
      @ 08,35 say "Data compra.:" 
      @ 08,60 say "Data OS.: "  + dTOc(dDataAgora)
      @ 09,01 say "Equipamento............:"
      @ 10,01 say "Entrega domicilio [S]/[N]:"
      
      @ 05,35 get cTecnicoNome             picture cMascaraTexto        Valid( !Empty( cTecnicoNome ) )                                    color cCorPretoAmarelo
      @ 07,21 get cClienteNome             picture cMascaraTexto        Valid( !Empty( cClienteNome ) )                                    color cCorPretoAmarelo
      @ 08,21 get nClienteLimiteCredito    picture cMascaraMonetario                                                                       color cCorPretoAmarelo
      @ 08,50 get dEquipamentoDataCompra                                Valid( !Empty( dCompraData ) .and. (dCompraData <= dDataAgora ) )  color cCorPretoAmarelo
      @ 09,21 get cEquipamentoDescricao    picture cMascaraTexto        Valid( !Empty( cEquipamentoDescricao ))                            color cCorPretoAmarelo
      @ 10,28 get cOpcaoEntregaDomicilio   picture cMascaraTexto        Valid( cOpcaoEntregaDomicilio $ 'SN' )                             color cCorPretoAmarelo
      read

      //caso escollha entraga domicilio
      if cOpcaoEntregaDomicilio == "S"
         @ 11,02 say "Endereco........:"
         @ 12,02 say "Bairro..........:"
         @ 13,02 say "Referencia......:"
         @ 14,02 say "Telefone........:"

         @ 11,20 get cClienteEndereco   picture cMascaraTexto     Valid( !Empty( cClienteEndereco ) )       color cCorPretoAmarelo
         @ 12,20 get cClienteBairro     picture cMascaraTexto     Valid( !Empty( cClienteBairro) )          color cCorPretoAmarelo
         @ 13,20 get cClienteReferencia picture cMascaraTexto     Valid( !Empty( cClienteReferencia ) )     color cCorPretoAmarelo
         @ 14,20 get nClienteTelefone   picture cMascaraTelefone                                            color cCorPretoAmarelo
         read
      endif
   
      if cOpcaoEntregaDomicilio == "N"
         nTaxaEntrega := 0
      endif
      
      //equip tempo comtra
      nEquipamentoTempoUso := year(dEquipamentoDataCompra) - year(dDataAgora)

      if month(dDataAgora) > month(dEquipamentoDataCompra) .or. (month(dDataAgora) == month(dEquipamentoDataCompra) .and. day(dDataAgora) > day(dEquipamentoDataCompra))
         nEquipamentoTempoUso++
      endif

      if nEquipamentoTempoUso >= 1
         lGarantiaServico := .f.
         if nEquipamentoTempoUso >= 2
         lGarantiaProduto := .f.
         endif
      endif

      @ 15,30 say "Cliente cadastrado com sucesso!"
      @ 16,30 say "Pressione qualquer tecla para continuar..."
      Inkey(0)
 
      //modulo lancamento de pedidos
      nOSValorTotal                 := 0
      nOSValorTotalGarantia         := 0
      nOSValorTotalComissao         := 0
      nOSValorTotalPagar            := 0
      //line controls
      nLinhaInicialModuloPedido     := 8
      nLinhaFinalModuloPedido       := 18
      nLinhaPedido                  := nLinhaInicialModuloPedido
      //price calc
      nProdutoValorTotal            := 0
      nProdutoValorTotalBruto       := 0
      nProdutoValorTotalDesconto    := 0
      nProdutoValorTotalGarantia    := 0
      nProdutoValorTotalComissao    := 0
      nProdutoItemTotal             := 0
      nProdutoComissaoTecnico       := 0.02
      //price service
      nServicoValorTotal            := 0
      nServicoValorParcial          := 0
      nServicoValorTotalDesconto    := 0
      nServicoValorTotalGarantia    := 0
      nServicoValorTotalComissao    := 0
      nServicoItemTotal             := 0


      @ 05,01 clear to 21,78

      @ 07,01 to 18,78
      @ 19,01 to 19,78

      @ 05,02 say "Tipo lancamento: Produto[P] | Servico[S]"
      @ 07,02 say "Produto/Servico"
      @ 07,31 say "Quant." 
      @ 07,40 say "Preco(R$)" 
      @ 07,51 say "Desc(%)"
      @ 07,60 say "Comissao"
      @ 07,70 say "Total"
      //RODAPE
      @ 20,02 say "Valor total OS:"
      @ 20,30 say "Valor c/ garantia:"

      do while  .t.
         cOSTipo := Space( 01 )

         @ 05,43 get cOSTipo picture cMascaraTexto valid cOSTipo $ "PS" color cCorPretoAmarelo
         read

         if LastKey() == 27
            nOpcaoSairTelaLancamentos := Alert( 'O que deseja?', { 'Faturar O.S.', 'Cancelar O.S.' }, cCorPretoVerde )
            if nOpcaoSairTelaLancamentos == 1
               exit
            else
               @ 05,01 clear to 20,79
               exit
            endif
         endif

         if nLinhaPedido == nLinhaFinalModuloPedido
            nLinhaPedido := nLinhaInicialModuloPedido
         endif

         //produto
         cProdutoDescricao          := space(30)
         nProdutoQuantidade         := 0
         nProdutoPrecoUnitario      := 0
         nProdutoDesconto           := 0
         nProdutoValor              := 0
         nProdutoValorSub           := 0
         nProdutoValorDesconto      := 0
         nProdutoValorGarantia      := 0
         //servico
         cServicoDescricao          := space(30)
         nServicoDesconto           := 0
         nServicoComissaoTecnico    := 0
         nServicoValor              := 0
         nServicoValorSub           := 0
         nServicoValorDesconto      := 0
         nServicoValorGarantia      := 0
         nServicoValorComissao      := 0
         nServicoValorFinal         := 0

         if cOSTipo == "P"

            @ nLinhaPedido,02 get cProdutoDescricao     picture cMascaraTexto       Valid( !Empty( cProdutoDescricao ) )                          color cCorPretoAmarelo
            @ nLinhaPedido,31 get nProdutoQuantidade    picture cMascaraNumero      Valid( nProdutoQuantidade > 0    )                            color cCorPretoAmarelo
            @ nLinhaPedido,38 get nProdutoPrecoUnitario picture cMascaraMonetario   Valid( nProdutoPrecoUnitario > 0 )                            color cCorPretoAmarelo
            @ nLinhaPedido,55 get nProdutoDesconto      picture "99"                Valid( nProdutoDesconto >= 0 .and. nProdutoDesconto <= 100 )  color cCorPretoAmarelo
            read

            nProdutoValorSub           := nProdutoQuantidade * nProdutoPrecoUnitario
            nProdutoValorDesconto      := nProdutoValorSub   * ( nProdutoDesconto / 100 )
            nProdutoValorTotal         := nProdutoValorSub  - nProdutoValorDesconto
            nProdutoValor              := ( nProdutoValorSub  - nProdutoValorDesconto ) * ( 1 + nTaxaEntrega )
            nProdutoValorTotalBruto    += nProdutoValorSub
            nProdutoValorTotalDesconto += nProdutoValorDesconto

            if !Empty( lGarantiaProduto )
               nProdutoValorGarantia      := nProdutoValor
               nProdutoValorTotalGarantia += nProdutoValorGarantia
            else
               nProdutoValorTotalComissao += nProdutoValor * nProdutoComissaoTecnico
            endif

            nProdutoValorTotal += nProdutoValor - nProdutoValorGarantia
            nOSValorTotal      += nProdutoValor
            nOSValorTotalPagar += nProdutoValor - nProdutoValorGarantia

            @ nLinhaPedido ,70 say RTrim( Transform( nProdutoValorTotal,cMascaraMonetario ) ) color cCorPretoAmarelo

            nProdutoItemTotal++
            nLinhaPedido++

         else
            @ nLinhaPedido ,02 get cServicoDescricao       picture cMascaraTexto     Valid( !Empty( cServicoDescricao ) )                                         color cCorPretoAmarelo
            @ nLinhaPedido ,38 get nServicoValor           picture cMascaraMonetario Valid( nServicoValor > 0 )                                                   color cCorPretoAmarelo
            @ nLinhaPedido ,55 get nServicoDesconto        picture "99"              Valid( nServicoDesconto >= 0 .and. nServicoDesconto <= 100 )                 color cCorPretoAmarelo
            @ nLinhaPedido ,60 get nServicoComissaoTecnico picture cMascaraMonetario Valid( nServicoComissaoTecnico >= 0 .and. nServicoComissaoTecnico <= 100 )   color cCorPretoAmarelo
            read

            nServicoValorSub           := nServicoValor
            nServicoValorDesconto      := nServicoValorSub * ( nServicoDesconto / 100 )
            nServicoValorFinal         := nServicoValorSub - nServicoValorDesconto
            nServicoValor              := ( nServicoValorSub - nServicoValorDesconto ) * ( 1 + nTaxaEntrega )
            nServicoValorParcial       += nServicoValorSub
            nServicoValorTotalDesconto += nServicoValorDesconto

            if !Empty( nServicoComissaoTecnico )
               nServicoValorComissao      := nServicoValor * ( nServicoComissaoTecnico / 100 )
               nServicoValorTotalComissao += nServicoValorComissao
            endif

            if !Empty( lGarantiaServico )
               nServicoValorGarantia      := nServicoValor
               nServicoValorTotalGarantia += nServicoValorGarantia
            endif

            nServicoValorTotal += nServicoValor - nServicoValorGarantia
            nOSValorTotal      += nServicoValor
            nOSValorTotalPagar += nServicoValor - nServicoValorGarantia

            @ nLinhaPedido,70 say RTrim( Transform( nServicoValorFinal, cMascaraMonetario ) ) color cCorPretoAmarelo

            nServicoItemTotal++
            nLinhaPedido++

         endif

         nClienteLimiteCredito -= ( nServicoValorFinal + nProdutoValorTotal )

         If nClienteLimiteCredito < 0
            cLogin := space(10)
            cSenha := space(10)
            cLoginSupervisor := Space(10)
            cSenhaSupervisor := "LIBERAR123"

            @ 21,15 say "Login:" color "W/R"
            @ 21,35 say "Senha:" color "W/R"

            @ 21,22 get cLogin picture "@!"  color "W/R"
            @ 21,42 get cSenha color "R/R"
            read

            if !(alltrim(cSenha) == cSenhaSupervisor)

               alert("Valor excede limite de credito")
               @ nLinhaPedido,02 clear to nLinhaPedido,77
               @ 21,10 clear to 21,78

               //nClienteLimiteCredito := nClienteLimiteCredito + (nServicoValor + nProdutoValor)
               nClienteLimiteCredito := nClienteLimiteCreditoCadastro

               nProdutoValorTotalBruto       -= nProdutoValorSub
               nProdutoValorTotalDesconto    -= nProdutoValorDesconto
               nProdutoValorTotalGarantia    -= nProdutoValorGarantia
               nProdutoValorTotal            -= nProdutoValor - nProdutoValorGarantia

               nServicoValorTotal            -= nServicoValorTotal
               nServicoValorTotalDesconto    -= nServicoValorDesconto
               nServicoValorTotalComissao    -= nServicoValorComissao
               nServicoValorTotalGarantia    -= nServicoValorGarantia
               nServicoValorTotal            -= nServicoValor - nServicoValorGarantia

               nProdutoItemTotal--
               nServicoItemTotal--

               nOSValorTotalPagar -= ( nProdutoValorSub - nProdutoValorDesconto ) * ( 1 + nTaxaEntrega )
               nOSValorTotalPagar -= ( nServicoValorSub - nServicoValorDesconto ) * ( 1 + nTaxaEntrega )
               nLinhaPedido--
               @ nLinhaPedido,02 clear to nLinhaPedido,70
               loop
            endif
            Alert("Liberado pelo Supervisor.")

            nClienteLimiteCreditoAtualizar := Alert("Atualizar limite de credito?", {"Sim", "Nao"}, cCorPretoVerde)
            if nClienteLimiteCreditoAtualizar == 1
               
               if !Empty(nClienteLimiteCredito)
                  nClienteLimiteCreditoCadastro :=  100
               endif
               
               nClienteLimiteCreditoCadastro *= 2
               nClienteLimiteCredito         := nClienteLimiteCreditoCadastro

               Alert("Limite de credito atualizado para R$ " + AllTrim(transform(nClienteLimiteCredito, cMascaraMonetario)))
            endif

            @ 21,10 clear to 21,78
         endIf

         nOSValorTotalComissao := nProdutoValorTotalComissao + nServicoValorTotalComissao

         @ 20,17 say  transform(nOSValorTotal, cMascaraMonetario)          color cCorPretoAmarelo
         @ 20,48 say  transform(nOSValorTotalPagar, cMascaraMonetario)     color cCorPretoAmarelo

      enddo

      if nOpcaoSairTelaLancamentos == 2
         loop
      endif
      /******************************************************************************/
      //VERIFICACAO VALOR A PAGAR

      nOpcaoPagamento := 0

      @ 05,01 clear to 21,78

      if !empty(nOSValorTotalPagar)

         /******************************************************************************/
         //GARANTIA COBRE
         do while .t.

            @ 06,01 clear to 19,75

            nPagamentoCNPJ     := 0
            nPagamentoNota     := 0
            dPagamentoNotaData := dDataAgora

            @ 06,01 say padc("CONSERTO COBERTO PELA GARANTIA",77) color cCorPretoVerde
            @ 08,02 say "CNPJ.......:"
            @ 09,02 say "Numero nota:"
            @ 10,02 say "Data nota..:"

            @ 08,14 get nPagamentoCNPJ     picture cMascaraCNPJ valid nPagamentoCNPJ > 0
            @ 09,14 get nPagamentoNota     picture cMascaraNota valid nPagamentoNota > 0
            @ 10,14 get dPagamentoNotaData                      valid !empty(dPagamentoNotaData)
            read

            if lastkey() == 27
               nOpcaoPagamentoCancelar := alert("Cancelar Faturamento?",{"Sim","Nao"})
               if nOpcaoPagamentoCancelar == 1
                  exit
               endif
               loop
            endif
            
            @ 12,10 say "Pressione Qualquer tecla para continuar..."
            Inkey(0)
            
            @ 06,01 clear to 19,75
            nOrdemServicoNumero++
       
            exit
         enddo

      else
         //Alert("Nao cobre garantia...")
         @ 06,01 clear to 19,75

         //pagamento nao covbertp pela garantia

         cPagamentoFormaDinheiro := space(01)
         cPagamentoFormaCartao   := space(01)
         cPagamentoFormaCheque   := space(01)
         nPagamentoForma         := 0
         cPagamentoFormaUtilizada:= ""

         do while .t.

            cPagamentoForma             := space(01)
            nPagamentoValorRecebido     := 0
            nPagamentoValorTroco        := 0

            @ 05,02 say "Total a pagar.............................................:R$" + transform(nOSValorTotal,cMascaraMonetario)
            @ 06,02 say "Forma de pagamento: Dinheiro-[D] | Cartao-[C] | Cheque-[Q]:"
            @ 07,02 say "Valor recebido.............................................R$"
            @ 08,02 say "Troco......................................................R$"

            @ 06,64 get cPagamentoForma         picture cMascaraTexto            valid cPagamentoForma $"DCQ"
            @ 07,64 get nPagamentoValorRecebido picture cMascaraMonetario valid nPagamentoValorRecebido > 0
            read

            if lastkey() == 27
               nOpcaoPagamentoCancelar := alert("Cancelar Faturamento?",{"Sim","Nao"})
               if nOpcaoPagamento == 1
                  exit
               endif
               loop
            endif

            if cPagamentoForma $ cPagamentoFormaUtilizada
               alert("Forma de pagamento ja utilizada. Escolha outra forma para o pagamento")
               loop
            endif

            if len(cPagamentoFormaUtilizada) == 2 .and. nPagamentoValorRecebido < nOSValorTotal
               alert("Insira um valor IGUAL ou MAIOR que o total devido.")
               loop
            endif

            //Alert(str(nPagamentoValorRecebido))
            //Alert(str(nOSValorTotalPagar))

            if nPagamentoValorRecebido >= nOSValorTotal
               nPagamentoValorTroco := nPagamentoValorRecebido - nOSValorTotal

               @ 08,62 say transform(nPagamentoValorTroco,cMascaraMonetario)
               @ 10,02 say "O.S. numero " + AllTrim(Str(nOrdemServicoNumero)) +  " finalizada com sucesso."
               @ 11,02 say "Agradecemos a preferencia"
               @ 12,02 say "pressione qualquer tecla iniciar nova O.S."
               nOrdemServicoNumero++
               Inkey(0)
               @ 05,02 clear to 13,70
               exit

            else
               cPagamentoFormaUtilizada += cPagamentoForma
               nOSValorTotal -= nPagamentoValorRecebido
               loop
            endif

            inkey(0)
            exit

         enddo
         
      endif


   elseif nPromptOpcao == 2 .or. lastKey() == 27 //remover or
      
      nAlertSair := alert('Sair do sistema?',{'Sim', 'Nao'} )
      if nAlertSair == 2
         loop
      endIf

      exit
   endIf


endDo