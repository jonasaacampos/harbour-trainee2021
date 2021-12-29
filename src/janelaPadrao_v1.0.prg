clear

set message to 21 center
setmode(25,80)
set scoreboard off


//borders
@ 00,00 to 24,79 double
@ 02,01 to 02,78 double
@ 04,01 to 04,78 double

//title
cTitulo := 'Nome programa'
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

cPrompt1 := 'Novo'
cPrompt1Message := 'Message novo..'
cPrompt1Col = 10

cPrompt2 := 'novo2'
cPrompt2Message := 'Mensagem prompt 2'
cPrompt2Col := len(cPrompt1) + cPrompt1Col  + nPromptEspacamento

cPrompt3 := 'novo3'
cPrompt3Message := 'Mensagem prompt 3'
cPrompt3Col := cPrompt2Col + len(cPrompt2) + nPromptEspacamento

cPrompt4 := 'Sair'
cPrompt4Message := 'Sai do sistema'
cPrompt4Col := cPrompt3Col + len(cPrompt3) + nPromptEspacamento

Do while .T.

   @ 03,cPrompt1Col prompt cPrompt1 message cPrompt1Message
   @ 03,cPrompt2Col prompt cPrompt2 message cPrompt2Message
   @ 03,cPrompt3Col prompt cPrompt3 message cPrompt3Message
   @ 03,cPrompt4col prompt cPrompt4 message cPrompt4Message
   menu to nPromptOpcao

   if lastKey() == 27
     //tratar aqui

   endIf

   if nPromptOpcao == 4 .or. lastKey() == 27 //remover or
      nAlertSair := alert('Sair do sistema?',{'Sim', 'Nao'} )
      if nAlertSair == 2
         loop
      endIf
      exit

   elseif nPromptOpcao == 3
      if lastKey() == 27
         nAlertSair := alert('Sair do modulo ' + cPrompt3 + '?',{'Sim', 'Nao'})
         if nAlertSair := 1
            loop
         endIf
      endIf

      inKey()
      ? 'menu 3 ok'
   elseif nPromptOpcao == 2
      ? 'menu 2 ok'
   elseif nPromptOpcao == 1
      ? 'menu 1 ok'
   endIf
endDo


//area util linha 04-18


