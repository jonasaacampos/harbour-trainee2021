/********************************************/
/***     JONAS CAMPOS - SG TRAINEE 2021    **/
/********************************************/
clear

set message to 21 center
setmode( 25,80 )
set scoreboard off

//borders
@ 00,00 to 24,79 double
@ 02,01 to 02,78 double
@ 04,01 to 04,78 double

//title
cTitulo           := "Restaurante SG"
cOrgaoResponsavel := "Atendimento reduzido em decorrencia das normas sanitarias."
cCidade           := "Maringa"

@ 01,01 say padC( cTitulo, 70 )
@ 03,01 say PadC( cOrgaoResponsavel, 70 )

//date
set date to British
set Epoch to 1940
set wrap off

dDataAgora     := date(  )
dDataAno       := year( dDataAgora )
dDataMes       := month( dDataAgora )
dDataDia       := day( dDataAgora )
dDataDiaSemana := dow( dDataAgora )
cDataMes       := ""
cDataDiaSemana := ""

if dDataMes == 1
   cDataMes := "janeiro"
elseif dDataMes == 2
   cDataMes := "fevereiro"
elseif dDataMes == 3
   cDataMes := "marco"
elseif dDataMes == 4
   cDataMes := "abril"
elseif dDataMes == 5
   cDataMes := "maio"
elseif dDataMes == 6
   cDataMes := "junho"
elseif dDataMes == 7
   cDataMes := "julho"
elseif dDataMes == 8
   cDataMes := "agosto"
elseif dDataMes == 9
   cDataMes := "setembro"
elseif dDataMes == 10
   cDataMes := "outubro"
elseif dDataMes == 11
   cDataMes := "novembro"
elseif dDataMes == 12
   cDataMes := "dezembro"
endif

if dDataDiaSemana == 1
   cDataDiaSemana := "Domingo"
elseif dDataDiaSemana == 2
   cDataDiaSemana := "Segunda-feira"
elseif dDataDiaSemana == 3
   cDataDiaSemana := "Terca-feira"
elseif dDataDiaSemana == 4
   cDataDiaSemana := "Quarta-feira"
elseif dDataDiaSemana == 5
   cDataDiaSemana := "Quinta-feira"
elseif dDataDiaSemana == 6
   cDataDiaSemana := "Sexta-feira"
elseif dDataDiaSemana == 7
   cDataDiaSemana := "Sabado"
endif

//Mascaras
cMascaraTexto           := "@!"
cMascaraNumero          := "99"
cMascaraNumeroDecimal   := "99.99"
cMascaraAno             := "@E 9999"
cMascaraMonetario       := "@E 999.99"

//Mensagens padrão
cRodapeSistema          := cCidade + " - " + cDataDiaSemana + ", " + transform( dDataDia, cMascaraTexto ) + " de " + cDataMes + " de " + transform( dDataAno, cMascaraAno ) + "."
//footer
@ 22,01 to 22,78 double
@ 23,20 say cRodapeSistema

/****************************************************************/
/***                    PROGRAMA PRINCIPAL                     **/
/****************************************************************/

//variaveis controle
nOpcaoMesaIndisponivel        := 0
nLinhaPainelMesaLivreOcupada  := 0
//mesas
cCorMesaLivre                 := "W/G" 
cCorMesaOcupada               := "W/R" 
cStatusCorMesa1               := cCorMesaLivre
cStatusCorMesa2               := cCorMesaLivre
lStatusMesa1Livre             := .t.
lStatusMesa2Livre             := .t.

//Comandas de controle de custo das mesas
nValorTotalMesa1              := 0
nValorTotalMesa2              := 0
nTotalFaturaPendente          := 0

//fechamento de caixa
nTaxaServico                  := 0.1
nValorTaxaServico :=0

//variaveis para analise gerencial
nMesa1QuantidadeAtendimentos           := 0
nMesa2QuantidadeAtendimentos           := 0
nMesa1QuantidadeAtendimentosCancelados := 0
nMesa2QuantidadeAtendimentosCancelados := 0

nMesa1ValorTotalAtendimentos           := 0
nMesa2ValorTotalAtendimentos           := 0
nMesa1ValorTotalAtendimentosCancelados := 0
nMesa2ValorTotalAtendimentosCancelados := 0

nTotalAtendimentos                     := 0
nTotalAtendimentosCancelados           := 0
nTotalValorAtendimentos                := 0

nMesa1ValorTicketMedio                 := 0
nMesa2ValorTicketMedio                 := 0

nMesa1TotalTaxaServico                 := 0
nMesa2TotalTaxaServico                 := 0
nAtendente1GorjetaTotal                := 0
nAtendente2GorjetaTotal                := 0





Do While .t.
   //atendimento
   nMesa                      := 0
   nAtendenteCodigo           := 0
   nProdutoTotal              := 0
   nPedidoTotal               := 0
   lFaturarPedido             := .f.
   //pedido
   nLinhaPedido               := 9

   @ 05,01 say "Mesa......: " 
   @ 06,01 say "Atendente.: "   
   @ 05,20 say "Mesa......: 1" color(  cStatusCorMesa1  )
   @ 06,20 say "Mesa......: 2" color(  cStatusCorMesa2  )

   @ 05,13 get nMesa              picture "9" Valid( ( nMesa >= 1)  .and. ( nMesa <= 2 ) )
   @ 06,13 get nAtendenteCodigo   picture "9" Valid( ( nAtendenteCodigo >= 1)  .and. ( nAtendenteCodigo <= 2 ) )
   read

   if LastKey(  ) == 27
      nOpcaoSair := Alert( "Deseja Sair do Programa?", {"Sim", "Nao"} )
      if nOpcaoSair == 1
         exit
      else
         loop
      endif
   endif

   //confere se mesa esta disponivel...
   if ( nMesa == 1 .and. Empty( lStatusMesa1Livre ) ) .or. ( nMesa ==  2 .and. Empty( lStatusMesa2Livre ) )
      nOpcaoMesaIndisponivel := Alert( "Mesa indisponivel", {"Digitar outra mesa", "Faturar Atendimento", "Cancelar Atendimento"} )
      
      if nOpcaoMesaIndisponivel ==  1
         loop
      elseif nOpcaoMesaIndisponivel == 2 
         lFaturarPedido := .t.
      else
         
         if nMesa == 1
            lStatusMesa1Livre := .t.
            nValorTotalMesa1  := 0
            cStatusCorMesa1   := cCorMesaLivre
            nMesa1QuantidadeAtendimentosCancelados++
         else
            lStatusMesa2Livre := .t.
            nValorTotalMesa2  := 0
            cStatusCorMesa2   := cCorMesaLivre
            nMesa2QuantidadeAtendimentosCancelados++
         endif

         loop

      endif
   endif
   
   //caso mesa esteja disponivel, altera o status da mesma
   if !Empty( lStatusMesa1Livre ) .or. !Empty( lStatusMesa2Livre )
      
      if nMesa == 1
         lStatusMesa1Livre := .f.
         cStatusCorMesa1   := cCorMesaOcupada
      else
         lStatusMesa2Livre := .f.
         cStatusCorMesa2   := cCorMesaOcupada
      endif

   endif

   //tela de faturamento
   if !Empty( lFaturarPedido )
      
      if nMesa == 1
         nTotalFaturaPendente := nValorTotalMesa1
      else
         nTotalFaturaPendente := nValorTotalMesa2
      endif
      
      nOpcaoAceiteTaxaServico := Alert( "Aceita Taxa de Servico ?", { "Sim", "Nao" } )

      nValorTaxaServico := nTotalFaturaPendente * nTaxaServico

      if nOpcaoAceiteTaxaServico == 1
         nTotalFaturaPendente += nValorTaxaServico
         if nAtendenteCodigo == 1
            nAtendente1GorjetaTotal += nValorTaxaServico
         else
            nAtendente2GorjetaTotal += nValorTaxaServico
         endif

      endif

      nValorPagamentoHistorico := nTotalFaturaPendente

      do while .t.
         //variaveis controle de pagamento
         nValorPago           := 0
         nValorTroco          := 0
         cCondicaoPagamento   := Space( 1 )

         @ 09,01 say "Selecione a forma de pagamento: Dinheiro [D] | Cartao [C] | Cheaque [Q]:  "

         @ 09,75 get cCondicaoPagamento picture cMascaraTexto Valid(  cCondicaoPagamento $ "DCQ" )
         read

         if LastKey(  ) == 27
            nAlertSairTelaPagamento := Alert( "Eu gostaria de...", { "Cancelar Pagamento", "Recomecar Pagamento" } )

            if nAlertSairTelaPagamento == 1
               @09,01 clear to 15,78
               exit
            else
               nTotalFaturaPendente := nValorPagamentoHistorico
               @10,01 clear to 15,78
            endif

         endif
         
         @ 11,01 say "Valor Recebido............: R$ "
         @ 12,01 say "Total do Pedido...........: R$ " + Transform( nValorTotalMesa1, cMascaraMonetario ) 
         @ 13,01 say "Valor do Troco............: R$ "
         @ 14,01 say "Pendente de Faturamento...: R$ " + Transform( nTotalFaturaPendente, cMascaraMonetario ) 


         @ 11,33 get nValorPago picture cMascaraMonetario
         read

         if nValorPago >= nTotalFaturaPendente
            
            nValorTroco := nValorPago - nTotalFaturaPendente

            @ 12,31 say Transform( nValorTroco, cMascaraMonetario )
            @ 14,01 say PadC(  "Pressione qualquer tecla para voltar ao programa principal...", 70  )
            Inkey( 0 )

            @09,01 clear to 15,79

            if nMesa == 1
               lStatusMesa1Livre := .t.
               cStatusCorMesa1   := cCorMesaLivre
               nValorTotalMesa1  := 0
            else
               lStatusMesa2Livre := .t.
               cStatusCorMesa2   := cCorMesaLivre
               nValorTotalMesa2  := 0
            endif

            exit

         else
            nTotalFaturaPendente-= nValorPago
         endif
         
      enddo

   endif

   //lancamento do pedido
   do while .t.

      if !Empty( lFaturarPedido )
         exit
      endif

      cProdutoDescricao   := Space( 30 )
      nProdutoQuantidade  :=  0
      nProdutoValor       :=  0
      
      @ 07,01 to 07,78
      @ 08,01 say "Produto"
      @ 08,35 say "Quant."
      @ 08,45 say "Preco( R$ )"
      @ 08,60 say "Total"

      @ nLinhaPedido,01 get cProdutoDescricao   picture cMascaraTexto      Valid( !Empty( cProdutoDescricao ) )
      @ nLinhaPedido,37 get nProdutoQuantidade  picture "99"               Valid( nProdutoQuantidade > 0 )
      @ nLinhaPedido,45 get nProdutoValor       picture cMascaraMonetario  Valid( nProdutoValor > 0 )
      read

      
      if LastKey(  ) =27
         nOpcaoPedido := Alert(  "Selecione uma opcao: ", {"Enviar Pedido para producao", "Continuar Digitando", "Abandonar Digitacao"} )
         if nOpcaoPedido == 1
            Alert( "Pedido enviado para a producao" )
            @ 08,01 clear to 16,75

            if nMesa == 1
               nValorTotalMesa1 := nPedidoTotal
               nMesa1QuantidadeAtendimentos++
               nMesa1ValorTotalAtendimentos += nValorTotalMesa1
            else
               nValorTotalMesa2 := nPedidoTotal
               nMesa2QuantidadeAtendimentos++
               nMesa2ValorTotalAtendimentos += nValorTotalMesa2
            endif
            
            exit
         elseif nOpcaoPedido == 2
            loop
         elseif nOpcaoPedido  == 3
            @ 08,01 clear to 16,75

            if nMesa == 1
               lStatusMesa1Livre := .t.
               cStatusCorMesa1   := cCorMesaLivre
               nMesa1ValorTotalAtendimentosCancelados += nValorTotalMesa1
               nMesa1QuantidadeAtendimentosCancelados++
            elseif nMesa == 2
               lStatusMesa2Livre := .t.
               cStatusCorMesa2   := cCorMesaLivre
               nMesa2ValorTotalAtendimentosCancelados += nValorTotalMesa2
               nMesa2QuantidadeAtendimentosCancelados++
            endif
            
            exit

         endif
      endif

      nProdutoTotal := nProdutoValor * nProdutoQuantidade
      nPedidoTotal  += nProdutoTotal

      @ nLinhaPedido,60 say Transform( nProdutoTotal, "@E 99,999.99" )
      @ 16,30 say "Subtotal...: R$ " + AllTrim( Transform( nPedidoTotal, "@E 99,999.99" ) )

      nLinhaPedido++

      if nLinhaPedido == 15
         nLinhaPedido := 9
         @ 09,01 clear to 15,75
      endif
   enddo
   //fim lancamento produtos  

endDo

do while .t.

   @ 07,01 to 07,79 Double

   //prompts-navigation
   nPromptOpcao := 1
   nPromptEspacamento := 3

   cPrompt1 := 'Estatistica de vendas'
   cPrompt1Message := 'Mostra dados referente a vendas'
   cPrompt1Col = 10

   cPrompt2 := 'Comissao vendedores'
   cPrompt2Message := 'mostra comissao vendedores'
   cPrompt2Col := len(cPrompt1) + cPrompt1Col  + nPromptEspacamento

   @ 08,cPrompt1Col prompt cPrompt1 message cPrompt1Message
   @ 08,cPrompt2Col prompt cPrompt2 message cPrompt2Message
   menu to nPromptOpcao

   if LastKey ( ) == 27
      nOpcasSair := Alert ('Fechar Programa?',{"Sim", 'Nao'})
      if nOpcaoSair == 1
         exit
      endif
   endif

   @ 10,05 to 19,75 Double

   nTotalAtendimentos                     := nMesa1QuantidadeAtendimentos + nMesa2QuantidadeAtendimentos
   nTotalAtendimentosCancelados           := nMesa1QuantidadeAtendimentosCancelados + nMesa2QuantidadeAtendimentosCancelados
   nTotalValorAtendimentos                := nMesa1ValorTotalAtendimentos  + nMesa2ValorTotalAtendimentos 
   
   nMesa1ValorTicketMedio := nMesa1ValorTotalAtendimentos / nMesa1QuantidadeAtendimentos
   nMesa2ValorTicketMedio := nMesa2ValorTotalAtendimentos / nMesa2QuantidadeAtendimentos
   nValorTicketMedioTotal := (nMesa1ValorTicketMedio + nMesa2ValorTicketMedio) / nTotalAtendimentos

   nValorTotalAtendentesGorjeta := nAtendente1GorjetaTotal + nAtendente2GorjetaTotal

   if nPromptOpcao == 1 //vendas
      @ 11,06 clear to 16,74
      @ 10,30 say 'Dados sobre as vendas'
      @ 11,40 say '     Mesa 01    Mesa 02     Total'
      @ 12,06 say 'Quantidade Atendimentos.............:     ' + AllTrim(Transform(nMesa1QuantidadeAtendimentos, '9')) + Str(nMesa2QuantidadeAtendimentos) + Str(nTotalAtendimentos)
      @ 13,06 say 'Quantidade Atendimentos Cancelados..:     ' + AllTrim(Transform(nMesa1QuantidadeAtendimentosCancelados, '9')) + Str(nMesa2QuantidadeAtendimentosCancelados) + Str(nTotalAtendimentosCancelados)
      @ 14,06 say 'Valor dos atendimentos..............:     ' + AllTrim(Transform(nMesa1ValorTotalAtendimentos, cMascaraMonetario))+ '   ' +transform(nMesa2ValorTotalAtendimentos, cMascaraMonetario)+ '   ' +Transform(nTotalValorAtendimentos, cMascaraMonetario)
      @ 15,06 say 'Valor Ticket Medio..................:     ' + AllTrim(Transform(nMesa1ValorTicketMedio, cMascaraMonetario))+ '   ' +transform(nMesa2ValorTicketMedio, cMascaraMonetario)+ '   ' +Transform(nValorTicketMedioTotal, cMascaraMonetario)
   else // comissao vendedores
      @ 11,06 clear to 16,74
      @ 10,30 say 'Comissao Vendedores'
      @ 11,20 say '     Vendedor 01   Vendedor 02     Total'
      @ 12,06 say 'Total gorgeta......: ' + Transform(nAtendente1GorjetaTotal, cMascaraMonetario) + '           ' + Transform(nAtendente2GorjetaTotal, cMascaraMonetario) + '      ' + Transform(nValorTotalAtendentesGorjeta, cMascaraMonetario)

   endif

enddo

clear
@ 20,15 say "Obrigado por utilizar as nossas solucoes..."
Inkey(4)
clear