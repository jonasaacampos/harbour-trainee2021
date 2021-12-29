set message to 21 center
setmode(25,80)
set scoreboard on

cCorPretoVerde := 'G/N'
SetColor(cCorPretoVerde)
clear

//bordas e cores
@ 00,00 to 24,79 double
@ 02,01 to 02,78 double
@ 04,01 to 04,78 double


//title
cTitulo := 'Nome programa'
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
cMascaraTexto           := '@!'
cMascaraNumero          := '99'
cMascaraNumeroDecimal   := '99.99'
cMascaraAno             := '@E 9999'
cMascaraMonetario       := '@E 9,999.99'

//footer
@ 22,01 to 22,78 double
@ 23,20 say cCidade + ' - ' + cDataDiaSemana + ', ' + transform(nDataDia, cMascaraTexto) + ' de ' + cDataMes + ' de ' + transform(nDataAno, cMascaraAno) + '.'

//prompts-navigation
nPromptOpcao         := 1
nPromptEspacamento   := 3

cPrompt1             := 'Efetuar Venda'
cPrompt1Message      := 'Inicia uma nova venda'
cPrompt1Col          := 15
lPrompt1Preenchido   := .f.

cPrompt2             := 'Garantia de Fabrica'
cPrompt2Message      := 'Registra produto para garantia do fabricante'
cPrompt2Col          := len(cPrompt1) + cPrompt1Col  + nPromptEspacamento
lPrompt2Preenchido   := .f.

cPrompt3             := 'Sair'
cPrompt3Message      := 'Sai do sistema'
cPrompt3Col          := cPrompt2Col + len(cPrompt2) + nPromptEspacamento

/*************************/
/*** PROGRAMA PRINCIPAL **/
/*************************/


//dados para login
cLoginUser := "SUPER"
cSenhaUser := '123mudar'

Do while .T.

   //tela de login
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
   @ 05,27 get cSenha picture '@'
   read

   if !( cLogin == cLoginUser ) .or. !( cSenha == cSenhaUser )//alltrim
      Alert('Usuriario e/ou senha invalidos.', , cCorPretoVerde)
      @ 05,01 clear to 05,30
   endif

   if LastKey() == 27
      nOpcaoSair := Alert( 'Sair do sistema?', { 'Sim', 'Nao' } )
      if nOpcaoSair == 1 // sair programa
         exit
      endif
   endif



   @ 03,cPrompt1Col prompt cPrompt1 message cPrompt1Message
   @ 03,cPrompt2Col prompt cPrompt2 message cPrompt2Message
   @ 03,cPrompt3Col prompt cPrompt3 message cPrompt3Message
   menu to nPromptOpcao

   if nPromptOpcao == 1     //cadastro
      if lPrompt1Preenchido == .T.
         alert('Cadastro ja preenchido. Conclua as etapas ou reinicie o sistema.')
         loop
      endif


   elseif nPromptOpcao == 2 //lanca notas
      if lPrompt1Preenchido == .f.
         alert('Preencha o cadastro do aluno para continuar...')
         loop
      endif

   elseif nPromptOpcao == 3 .or. lastKey() == 27 //remover or
      nAlertSair := alert('Sair do sistema?',{'Sim', 'Nao'} )
      if nAlertSair == 2
         loop
      endIf
      exit
   endIf

endDo