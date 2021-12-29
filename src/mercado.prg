setmode(25,80)
Set ScoreBoard off

Set date to British
Set epoch to 1930
//BORDAS DO PROGRAMA (e cores)
nLinhaTabela             := 5
Set Color to w+/G+
clear
//Bordas tabela de dados
@ 03,01 to 12,76 Double
/****************************************/
/*            PROGRAMA PRINCIPAL        */
/****************************************/
Do while .t.
   //dados do cliente
   cNomeCliente             := Space( 40 )
   //dados do vendedor
   cNomeVendedor            := Space( 20 )
   dDataVenda               := Date()
   nComissaoVendedor        := 0
   nTotalComissaoVendedor   := 0
   //Dados do produto
   nCodigoProduto           := 0
   cNomeProduto             := Space( 9 )
   cDescricaoProduto        := Space( 10 )
   nQuantidade              := 0
   nValorProduto            := 0
   nDesconto                := 0
   //fechamento de caixa
   lVendaCancelada          := .F.
   nQuantProdutosCarrinho   := 0
   nQuantProdutosTotal      := 0
   nTotalCompra             := 0
   nTotalCompraComDesconto  := 0
   nSubTotal                := 0
   nTotalComDesconto        := 0
   cFormaPagamento          := Space( 1 )
   nValorPago               := 0
   nValorPendente           := 0
   nValorTroco              := 0
   nQuantParcelas           := 0
   nValorParcela            := 0
   dDataParcela             := 0
   nIteracao                := 0
   nLinhaParcela            := 15
   nColunaParcela           := 1

   //CABECALHO
   @ 01,01 say 'Nome do cliente:'
   @ 02,01 say 'Data da venda:'
   @ 02,25 say 'Vendedor:'
   @ 02,55 say 'Comissao (%):'

   @ 01,20 get cNomeCliente         picture '@!'
   @ 02,16 get dDataVenda
   @ 02,35 get cNomeVendedor        picture '@!'
   @ 02,68 get nComissaoVendedor    picture '99'
   read

   @ 04,02 say 'Cod.'
   @ 04,07 say PadC( 'Produto', 10)
   @ 04,20 say PadC( 'Descricao', 10)
   @ 04,32 say 'Quant.'
   @ 04,42 say 'Valor'
   @ 04,50 say 'Desc(%)'
   @ 04,59 say 'Total'
   @ 04,65 say 'Total/Desc.'

   //insercao de produtos no carrinho
   do while nQuantProdutosCarrinho < 5
      nCodigoProduto        := 0
      cNomeProduto          := Space( 9 )
      cDescricaoProduto     := Space( 10 )
      nQuantidade           := 0
      nValorProduto         := 0
      nDesconto             := 0

      @ nLinhaTabela,02 get nCodigoProduto         picture '99'
      @ nLinhaTabela,07 get cNomeProduto           picture '@!'
      @ nLinhaTabela,20 get cDescricaoProduto      picture '@!'
      @ nLinhaTabela,35 get nQuantidade            picture '99'
      @ nLinhaTabela,42 get nValorProduto          picture '999.99'
      @ nLinhaTabela,52 get nDesconto              picture '99'
      read

      if LastKey() == 27
         nOpcaoSair := Alert( 'Finalizar/Cancelar venda?', {'Finalizar', 'Continuar', 'Cancelar'} )
         if nOpcaoSair == 1
            @ 13,01 say 'Total items carrinho: ' + AllTrim( Str( nQuantProdutosTotal ) )
            exit
         elseif nOpcaoSair == 2
            loop
         elseif nOpcaoSair == 3
            clear
            lVendaCancelada := .T. 
            exit
         endif
      endif

      nQuantProdutosTotal++
      nSubTotal                := nValorProduto * nQuantidade
      nTotalComDesconto        := nSubTotal - ((nDesconto / 100) * nSubTotal)

      @ nLinhaTabela,57 say Transform( nSubTotal, '@E 999.99' )
      @ nLinhaTabela,67 say Transform( nTotalComDesconto, '@E 999.99' )

      nTotalCompra            += nSubTotal
      nTotalCompraComDesconto += nTotalComDesconto
      nLinhaTabela++
      nQuantProdutosCarrinho++

      @ 12,20 say 'Total: '                  + Transform( nTotalCompra, '@E 999.99'  )
      @ 12,40 say 'Total com desconto: '     + Transform( nTotalCompraComDesconto, '@E 999.99' )
      @ 13,01 say 'Total items carrinho: '   + AllTrim( Str( nQuantProdutosTotal ) )
   enddo
   
   //fechamento de caixa
   if !lVendaCancelada
      @ 15,01 say 'Forma de Pagamento: a vista (V) // a prazo (P):'

      @ 15,50 get cFormaPagamento          picture '@!' Valid cFormaPagamento $ 'VP'
      read

      //pagamento a vista
      if cFormaPagamento == 'V'
         @ 18,01 say 'Valor pago: '

         @ 18,15 get nValorPago            picture '@E 999,99'
         read

         if nValorPago < nTotalCompraComDesconto
            nValorPendente += nTotalCompraComDesconto - nValorPago
            @ 15,01 clear to 18,30
            nValorRecebidoControle := 0

            do while nValorPendente > 0
               cFormaPagamento := ''
               @ 15,01 say 'Faltam R$' + Transform( nValorPendente, '@E9,999.99') + ' Para finalizar o pagamento'
               @ 18,01 say 'Valor recebido: '
               @ 19,01 get nValorRecebidoControle      picture '999.99'
               read 
               
               if LastKey() == 27
                  nOpcaoSair := Alert('Cancelar Pagamentos',{'Sim'}, {'Nao'})
                  if nOpcaoSair == 1
                     exit
                  else
                     loop
                  endif
               endif   

               if  nValorRecebidoControle > nValorPendente
                  nValorTroco := nValorRecebidoControle - nValorPendente
                  nValorPago := 0
                  @ 18,25 say 'Voltar troco de R$' + Transform( nValorTroco, '@E9.999,99' )
               endif
               nValorPendente -= nValorRecebidoControle

            enddo
         elseif nValorPago > nTotalCompraComDesconto
            nValorTroco := nValorPago - nTotalCompraComDesconto
            nValorPago := 0
            @ 18,25 say 'Voltar troco de R$' + Transform( nValorTroco, '@E9.999,99' )
         endif

         @ 19,25 say 'Obrigado pela preferencia, volte sempre!'
      endif
      //pagamento a prazo
      if cFormaPagamento == 'P'
         @ 18,01 say 'Quantidade de parcelas: '

         @ 18,25 get nQuantParcelas                 picture '99'     Valid nQuantParcelas <= 10 .or. nQuantParcelas > 0
         read

         nValorParcela := nTotalCompraComDesconto / nQuantParcelas
         @ 15,01 clear to 18,50
         dDataParcela := dDataVenda

         Do while nIteracao < nQuantParcelas
            nIteracao++
            @ nLinhaParcela,nColunaParcela say 'Parcela ' + AllTrim( Str ( nIteracao ) ) + '| R$: ' + AllTrim(Transform( nValorParcela, '@E99.99' )) + '|' + dToc( dDataParcela ) + ' |'
            dDataParcela += 30
            nLinhaParcela++
            if nIteracao == 5
               nColunaParcela := 40
               nLinhaParcela  := 15           
            endif

            if nIteracao == 10
               nColunaParcela := 34
            endif
         enddo
      endif

      //calcular comissao vendedor
      nTotalComissaoVendedor := ( nTotalCompra / 100 ) * nComissaoVendedor
      @ 22,01 say 'Comissao do vendedor ' + AllTrim( cNomeVendedor ) + ' R$: ' + Transform( nTotalComissaoVendedor, '@E 999.99' )
      @ 23,40 say 'volte Sempre'

      Inkey(0)
      clear
   endif   
//fim fechamento de caixa
enddo