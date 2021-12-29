/********************************************/
/***     JONAS CAMPOS - SG TRAINEE 2021    **/
/********************************************/

cCorFonteBrancaFundoAzul  := "W+/B+"
cCorFonteBrancaFundoCiano := "W+/BG"

SetColor(cCorFonteBrancaFundoAzul)
clear

set message to 21 center
setmode(25,80)
set scoreboard off

//borders
@ 00,00 to 24,79 double
@ 02,01 to 02,78 double
@ 04,01 to 04,78 double

//title
cTitulo := "Instituto Nacional do Seguro Social -  INSS"
cOrgaoResponsavel := "Ministerio da Economia - Brasil"
cCidade := "Maringa"

@ 01,01 say padC(cTitulo, 70)
@ 03,01 say PadC(cOrgaoResponsavel, 70)

//date
set date to British
set Epoch to 1940
set wrap off

dDataAgora     := date()
dDataAno       := year(dDataAgora)
dDataMes       := month(dDataAgora)
dDataDia       := day(dDataAgora)
dDataDiaSemana := dow(dDataAgora)
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
cMascaraMonetario       := "@E 999,999.99"

//Mensagens padrão
cRodapeSistema          := cCidade + " - " + cDataDiaSemana + ", " + transform(dDataDia, cMascaraTexto) + " de " + cDataMes + " de " + transform(dDataAno, cMascaraAno) + "."
//footer
@ 22,01 to 22,78 double
@ 23,20 say cRodapeSistema

/****************************************************************/
/***                    PROGRAMA PRINCIPAL                     **/
/****************************************************************/
Do while .T.
   @ 05,01 clear to 21,75

   //variaveis de controle
   nCadastrosContador            := 1
   nCadastrosQuantidade          := 0
   nCadastrosCompletos           := 0

   //variaveis de analise estatistica
   nSomaMulheresAdmitidasAte2003 := 0
   nSomaHomensDemitidosEm2015    := 0
   nSomaHomensMais80Anos         := 0
   nTotalHomens                  := 0
   nTotalMulheres                := 0
   nTotalHomensAposentados       := 0
   nTotalMulheresAposentadas     := 0
   nTotalAposentados             := 0
   nTotalHomensRecebemTicket     := 0
   nTotalMulheresPagamIRRF       := 0
   nTotalSalariosAtualizados     := 0
   nSomaSalariosAposentados      := 0
   cPaganteImpostoRendaSimNao    := ""

   //taxas aplicaveis
   nTaxaAdicional                := 0.08
   nTaxaReducao                  := 0.03
   nTaxaRedutoraTicket           := 0.2
   nTaxaRedutoraIRRF             := 0.11

   //Variaveis de tempo para aposentadoria
   nAnosTempoMinimoTrabalho      := 0
   nAnosIdadeMinimaAposentadoria := 0

   @ 05,01 say "Quantos funcionarios serao cadastrados? "
   
   @ 05,42 get nCadastrosQuantidade picture "999" Valid !Empty(nCadastrosQuantidade)
   read

   if lastKey() == 27
      nAlertSair := Alert("Sair do Programa?", {"Sim", "Nao"}, cCorFonteBrancaFundoCiano)
      if nAlertSair == 1
         exit
      endif
   endif

   do while nCadastrosQuantidade >= nCadastrosContador
      cFuncionarioNome           := Space(30)
      cFuncionarioSexo           := Space(1)
      dFuncionarioDataNasc       := cTod("")
      nFuncionarioIdade          := 0
      dFuncionarioDataAdmissao   := cTod("")
      dFuncionarioDataRecisao    := cTod("")
      nValorSalarioBase          := 0
      nValorAdicNoturno          := 0
      nValorAdicInsalubridade    := 0
      nValorSalarioAtual         := 0
      nValorSalarioAposentados   := 0
      nValorTicketAlimentacao    := 0
      nValorMaximoIRRF           := 0

      //labels cadastro      
      @ 06,01 say nCadastrosContador
      @ 07,01 say "Nome: "
      @ 07,39 say "Sexo: "
      @ 07,47 say "Data Nasc.: "
      @ 08,01 say "Data Admissao: "
      @ 08,25 say "Data Recisao: "
      @ 08,55 say "Salario base R$: "
      @ 09,01 say "Adic. Noturno (%) "
      @ 09,23 say "Insalubridade (%) "
      @ 10,01 say "Valor do Ticket Alimentacao: R$"
      @ 10,45 say "Valor do Max. IRRF: R$"
      
      @ 07,07 get cFuncionarioNome           picture  cMascaraTexto        Valid (!Empty(cFuncionarioNome)) color "N/W"
      @ 07,45 get cFuncionarioSexo           picture  cMascaraTexto        Valid (cFuncionarioSexo $ "MF")
      @ 07,58 get dFuncionarioDataNasc                                     Valid (!Empty(dFuncionarioDataNasc) .and. (dFuncionarioDataNasc < dDataAgora))
      @ 08,16 get dFuncionarioDataAdmissao                                 Valid (dFuncionarioDataAdmissao <= dDataAgora) .and. (dFuncionarioDataAdmissao > dFuncionarioDataNasc)
      @ 08,39 get dFuncionarioDataRecisao                                  Valid (dFuncionarioDataRecisao > dFuncionarioDataAdmissao) .and. (dFuncionarioDataRecisao <= dDataAgora)
      @ 08,68 get nValorSalarioBase          picture  cMascaraMonetario
      @ 09,20 get nValorAdicNoturno          picture  cMascaraNumero
      @ 09,40 get nValorAdicInsalubridade    picture  cMascaraNumero
      @ 10,33 get nValorTicketAlimentacao    picture  cMascaraMonetario
      @ 10,68 get nValorMaximoIRRF           picture  cMascaraMonetario
      read

      if lastKey() == 27
         nAlertSair := alert("O que deseja fazer:",{"Retomar lancamento", "Cancelar cadastro", "Processar informacoes"} , cCorFonteBrancaFundoCiano)
         if nAlertSair == 1
            @ 07,01 clear to 10,78
            loop
         elseif nAlertSair == 2
            nCadastrosQuantidade := 0
            @ 05,01 clear to 10,78
            exit
         else
            nPromptOpcao := 3
            @ 07,01 clear to 10,78
            exit
         endIf
      endif
      
      nCadastrosCompletos++
      
      //*************************
      // calculos estatisticos
      //*************************

      //Calculos Salario Atual
      nValorAdicNoturno          := nValorAdicNoturno / 100
      nValorAdicInsalubridade    := nValorAdicInsalubridade / 100
      nValorSalarioAtual         := nValorSalarioBase + (nValorSalarioBase * nValorAdicNoturno) + (nValorSalarioBase * nValorAdicInsalubridade) + nValorTicketAlimentacao

      //Pagante Imposto de Renda?
      if nValorSalarioAtual > nValorMaximoIRRF
         cPaganteImpostoRendaSimNao := "SIM"
      else
         cPaganteImpostoRendaSimNao := "NAO"
      endif

      //Calculos de idade
      nFuncionarioIdade := Year( Date() ) - Year( dFuncionarioDataNasc )
      if ( Month( dFuncionarioDataNasc ) > Month( Date() ) ) .or. ( Month( dFuncionarioDataNasc ) == Month( Date() ) .and. Day( dFuncionarioDataNasc ) > Day( Date() ) )
         nFuncionarioIdade--
      endif
      
      //Calculos Tempo de Trabalho
      nFuncionarioAnoRecisao        := Year( dFuncionarioDataRecisao )
      nFuncionarioAnoAdmissao       := Year( dFuncionarioDataAdmissao )
      nTempoAnosTrabalho            := nFuncionarioAnoRecisao - nFuncionarioAnoAdmissao
      if Month( dFuncionarioDataRecisao ) > Month( dFuncionarioDataRecisao) .or. ( Month( dFuncionarioDataRecisao ) == Month( dFuncionarioDataRecisao ) .and. Day( dFuncionarioDataRecisao ) > Day( dFuncionarioDataRecisao ) )
         nTempoAnosTrabalho--
      endif
            
      //definir idade e tempo de trabalho minimos com base no sexo
      //analises das variaveis dependentes do sexo do funcionario
      if cFuncionarioSexo == "M"
         nTotalHomens++
         nAnosTempoMinimoTrabalho      := 30
         nAnosIdadeMinimaAposentadoria := 65
         //Homens com mais de 80 anos      
         if nFuncionarioIdade > 80
            nSomaHomensMais80Anos += 1
         endif
         //Homens demitidos em 2015
         if Year(dFuncionarioDataRecisao) == 2015
            nSomaHomensDemitidosEm2015++
         endif
         //Homens que recebem ticket
         if !Empty(nValorTicketAlimentacao)
            nTotalHomensRecebemTicket++
         endif
      else
         nTotalMulheres++
         nAnosTempoMinimoTrabalho      := 25
         nAnosIdadeMinimaAposentadoria := 60
         //Mulheres Admitidas antes 2003
         if Year(dFuncionarioDataAdmissao) < 2003
            nSomaMulheresAdmitidasAte2003++
         endif
         //Mulheres que pagam IRRF
         if nValorSalarioAtual > nValorMaximoIRRF
            nTotalMulheresPagamIRRF++
         endif
      endif
   
      //calculo aposentados (tempo aposentadoria + idade) -> caso aposentado, calcular salario aposentadoria
      if (nTempoAnosTrabalho >= nAnosTempoMinimoTrabalho) .and. (nFuncionarioIdade >= nAnosIdadeMinimaAposentadoria)
      
         //calculos salariais (adicionais sobre slari base)
         if Year(dFuncionarioDataAdmissao) <= 2005
            nValorSalarioAposentados += nValorSalarioBase * nTaxaAdicional
         elseif Year(dFuncionarioDataRecisao) == 2006   
            nValorSalarioAposentados += nValorSalarioBase * nTaxaAdicional
         endif    
         
         //calculos salariais (redudores de salario)
         if Year(dFuncionarioDataAdmissao) <= 2009
            nValorSalarioAposentados -= nValorSalarioBase * nTaxaReducao
         elseif Year(dFuncionarioDataRecisao) == 2010   
            nValorSalarioAposentados -= nValorSalarioBase * nTaxaReducao
         endif
         
         //atualiza salario do funcionario
         nTotalSalariosAtualizados := nValorSalarioBase + nValorSalarioAposentados
         
         //Redutores caso receba Ticket
         if !Empty(nValorTicketAlimentacao)
            nTotalSalariosAtualizados := nTotalSalariosAtualizados - (nTotalSalariosAtualizados * nTaxaRedutoraTicket)
         endif

         //Redutores caso faixa ultrapasse valor IRRF
         if nTotalSalariosAtualizados > nValorMaximoIRRF
            nTotalSalariosAtualizados := nTotalSalariosAtualizados - (nTotalSalariosAtualizados * nTaxaRedutoraIRRF)
         endif

         //somatorio de todas as aposentadorias (acrescido de ticket)
         nSomaSalariosAposentados += nTotalSalariosAtualizados + nValorTicketAlimentacao

         //Analise Homens/Mulheres aposentadas
         if cFuncionarioSexo == "M"
            nTotalHomensAposentados++
         else
            nTotalMulheresAposentadas++
         endif
      endif
      //fim da analise estatistica

      //metricas do ultimo funcionario cadastrado
      @ 12,01 say "Funcionario " + AllTrim(cFuncionarioNome) + ", trabalhou por " + AllTrim(Str(nTempoAnosTrabalho)) + " anos."
      @ 13,01 say "Sua idade hoje e " + AllTrim(Str(nFuncionarioIdade)) + " anos."
      @ 15,01 say "Salario Atual (Salario Base + Ad. Noturno + Insalubridade + Ticket):" 
      @ 16,01 say "R$" + AllTrim(transform( nValorSalarioAtual, cMascaraMonetario ))
      @ 16,15 say "Paga imposto de renda? " + cPaganteImpostoRendaSimNao
      
      @ 18,01 say PadC("Cadastro salvo com sucesso!", 60)
      @ 19,01 say PadC("Digite <qualquer tecla> para continuar...", 60)
      Inkey(0)

      @ 07,01 clear to 19,78

      nCadastrosContador++ 
   endDo

   //********************
   //* Quadro Analitico *
   //********************

   if !Empty(nCadastrosQuantidade)
      
      nTotalAposentados                      := nTotalHomensAposentados + nTotalMulheresAposentadas
      cTotalPercentualHomensAposentados      := AllTrim( Str( ( nTotalHomensAposentados / nTotalAposentados)   * 100 ) )
      cTotalPercentualMulheresAposentadas    := AllTrim( Str( ( nTotalMulheresAposentadas / nTotalAposentados) * 100 ) )
      nTotalPercentualMulheresPagamIRRF      := AllTrim( Str( ( nTotalMulheresPagamIRRF / nTotalMulheres )     * 100 ) )
      nTotalPercentualHomensRecebemTicket    := AllTrim( Str( ( nTotalHomensRecebemTicket / nTotalHomens )     * 100 ) )

      @ 05,01 clear to 10,78
      @ 06,05 to 19,75 Double
   
      @ 08,07 say "Mulheres admitidas ate 2003......:  " + AllTrim( Transform( nSomaMulheresAdmitidasAte2003, cMascaraNumero ) )
      @ 09,07 say "Homens demiditos em 2015.........:  " + AllTrim( Str( nSomaHomensDemitidosEm2015 ) )
      @ 10,07 say "Homens com mais de 80 anos.......:  " + AllTrim( Transform( nSomaHomensMais80Anos, cMascaraNumero ) )
      @ 11,07 say "Proporcao de entrevistados.......:  " + AllTrim( Str( nTotalHomens ) ) + " Homens e " + AllTrim( Str( nTotalMulheres ) ) + " Mulheres"
      @ 12,07 say "Total de aposentados.............:  " + AllTrim( Str ( nTotalAposentados) )
      @ 13,07 say "Total (%) de Homens aposentados..:  " + cTotalPercentualHomensAposentados
      @ 14,07 say "Total (%) de Mulheres aposentadas:  " + cTotalPercentualMulheresAposentadas
      @ 15,07 say "Soma de todos as aposentadorias..:  " + AllTrim( Transform( nSomaSalariosAposentados, cMascaraMonetario ) )
      @ 16,07 say "(%) Mulheres que pagam IRRF......:  " + nTotalPercentualMulheresPagamIRRF
      @ 17,07 say "(%) Homens que recebem Ticket....:  " + nTotalPercentualHomensRecebemTicket
   endif

   @ 21,15 say "Pressione qualquer tecla pra voltar ao inicio..."
   Inkey(0)
endDo
