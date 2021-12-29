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
cTitulo := 'Utilitarios'
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


/*************************/
/*** PROGRAMA PRINCIPAL **/
/*************************/

//prompts-navigation
nPromptOpcao         := 1
nPromptEspacamento   := 3

cPrompt1             := 'Jogar'
cPrompt1Message      := 'Jogo da Velha. Um classico...'
cPrompt1Col          := 15

cPrompt2             := 'Calendario'
cPrompt2Message      := 'Nao perca nenhum compromisso...'
cPrompt2Col          := len(cPrompt1) + cPrompt1Col  + nPromptEspacamento

cPrompt3             := 'Senha'
cPrompt3Message      := 'Verifique a forca de sua senha...'
cPrompt3Col          := len(cPrompt2) + cPrompt2Col + nPromptEspacamento

/**/

do while .T.
   @ 03,cPrompt1Col prompt cPrompt1 message cPrompt1Message
   @ 03,cPrompt2Col prompt cPrompt2 message cPrompt2Message
   @ 03,cPrompt3Col prompt cPrompt3 message cPrompt3Message
   menu to nPromptOpcao

   
   do while .t.
   
      if nPromptOpcao == 1     //jogo
    
      cNomeJogador1 := Space(15)
      cNomeJogador2 := Space(15)
      cOpcaoJogador1:= SPace(1)
      cEscolhaJogador1 := ''
      cEscolhaJogador2 := ''
      cJogadasDisponiveis := '-----'
      cJogadaLinha1Coluna1 := cJogadasDisponiveis
      cJogadaLinha2Coluna1 := cJogadasDisponiveis
      cJogadaLinha3Coluna1 := cJogadasDisponiveis
      cJogadaLinha1Coluna2 := cJogadasDisponiveis
      cJogadaLinha2Coluna2 := cJogadasDisponiveis
      cJogadaLinha3Coluna2 := cJogadasDisponiveis
      cJogadaLinha1Coluna3 := cJogadasDisponiveis
      cJogadaLinha2Coluna3 := cJogadasDisponiveis
      cJogadaLinha3Coluna3 := cJogadasDisponiveis


      @ 05,02 say 'Nome Jogador 1: '
      @ 06,02 say 'Nome Jogador 2: '
      @ 07, 01 say "Escolha de marcador jogador 1 -  [X] ou [O]: "
      
      @ 05,17 get cNomeJogador1 picture cMascaraTexto valid(!Empty(cNomeJogador1))
      @ 06,17 get cNomeJogador2 picture cMascaraTexto valid(!Empty(cNomeJogador2))
      @ 07,46 get cOpcaoJogador1 picture cMascaraTexto valid(cOpcaoJogador1 $ 'XO')
      read

      if LastKey() == 27
         nOpcaoVoltarMenu := alert('Voltar ao menu principal?',{'Sim', 'Nao'})
         if nOpcaoVoltarMenu == 1
            @ 05,01 clear to 20,70
            exit
         else
            @ 05,01 clear to 20,70
            loop
         endif
      endif
      
      if cOpcaoJogador1 == 'X'
         cEscolhaJogador1 := 'X'
         cEscolhaJogador2 := 'O'
      else
         cEscolhaJogador1 := 'O'
         cEscolhaJogador2 := 'X'
      endif

      @ 05,02 clear to 08,70
      cVezJogador := cNomeJogador1
      nJogadasDisponiveis := 9
      
      do while .t. //jogo principal tela escolha
      
          @ 08, 02 say 'Vez do Jogador   ' + cVezJogador

         @ 10,30                             prompt cJogadaLinha1Coluna1
         @ 11,30                             prompt cJogadaLinha2Coluna1
         @ 12,30                             prompt cJogadaLinha3Coluna1
         @ 10,30+Len(cJogadasDisponiveis)    prompt cJogadaLinha1Coluna2
         @ 11,30+Len(cJogadasDisponiveis)    prompt cJogadaLinha2Coluna2
         @ 12,30+Len(cJogadasDisponiveis)    prompt cJogadaLinha3Coluna2
         @ 10,30+Len(cJogadasDisponiveis)*2  prompt cJogadaLinha1Coluna3
         @ 11,30+Len(cJogadasDisponiveis)*2  prompt cJogadaLinha2Coluna3
         @ 12,30+Len(cJogadasDisponiveis)*2  prompt cJogadaLinha3Coluna3
         menu to nPromptTelaJogo

         if nPromptTelaJogo == 1

            if cJogadaLinha1Coluna1 == cJogadasDisponiveis
               if cVezJogador == cNomeJogador1
                  cJogadaLinha1Coluna1 := AllTrim(cEscolhaJogador1)
               else
                  cJogadaLinha1Coluna1 := AllTrim(cEscolhaJogador2)
               endif

            else
               Alert('Escolha outra casa!')
               loop
            endif

         elseif nPromptTelaJogo == 2
           
            if cJogadaLinha2Coluna1 == cJogadasDisponiveis
                if cVezJogador == cNomeJogador1
                  cJogadaLinha2Coluna1 := AllTrim(cEscolhaJogador1)
               else
                  cJogadaLinha2Coluna1 := AllTrim(cEscolhaJogador2)
               endif
            else
               Alert('Escolha outra casa!')
               loop
            endif

         elseif nPromptTelaJogo == 3

            if cJogadaLinha3Coluna1 == cJogadasDisponiveis
               if cVezJogador == cNomeJogador1
                  cJogadaLinha3Coluna1 := AllTrim(cEscolhaJogador1)
               else
                  cJogadaLinha3Coluna1 := AllTrim(cEscolhaJogador2)
               endif

            else
               Alert('Escolha outra casa!')
               loop
            endif

         elseif nPromptTelaJogo == 4
            if cJogadaLinha1Coluna2 == cJogadasDisponiveis
               if cVezJogador == cNomeJogador1
                  cJogadaLinha1Coluna2 := AllTrim(cEscolhaJogador1)
               else
                  cJogadaLinha1Coluna2 := AllTrim(cEscolhaJogador2)
               endif

            else
               Alert('Escolha outra casa!')
               loop
            endif

         elseif nPromptTelaJogo == 5
            if cJogadaLinha2Coluna2 == cJogadasDisponiveis
               if cVezJogador == cNomeJogador1
                  cJogadaLinha2Coluna2 := AllTrim(cEscolhaJogador1)
               else
                  cJogadaLinha2Coluna2 := AllTrim(cEscolhaJogador2)
               endif
            else
               Alert('Escolha outra casa!')
               loop
            endif


         elseif nPromptTelaJogo == 6
            if cJogadaLinha3Coluna2 == cJogadasDisponiveis
               if cVezJogador == cNomeJogador1
                  cJogadaLinha3Coluna2 := AllTrim(cEscolhaJogador1)
               else
                  cJogadaLinha3Coluna2 := AllTrim(cEscolhaJogador2)
               endif
            else
               Alert('Escolha outra casa!')
               loop
            endif

         elseif nPromptTelaJogo == 7
            if cJogadaLinha1Coluna3 == cJogadasDisponiveis
               if cVezJogador == cNomeJogador1
                  cJogadaLinha1Coluna3 := AllTrim(cEscolhaJogador1)
               else
                  cJogadaLinha1Coluna3 := AllTrim(cEscolhaJogador2)
               endif
            else
               Alert('Escolha outra casa!')
               loop
            endif

         elseif nPromptTelaJogo == 8  
            if cJogadaLinha2Coluna3 == cJogadasDisponiveis
               if cVezJogador == cNomeJogador1
                  cJogadaLinha2Coluna3 := AllTrim(cEscolhaJogador1)
               else
                  cJogadaLinha2Coluna3 := AllTrim(cEscolhaJogador2)
               endif
            else
               Alert('Escolha outra casa!')
               loop
            endif
            
         elseif nPromptTelaJogo == 9
            if cJogadaLinha3Coluna3 == cJogadasDisponiveis
               if cVezJogador == cNomeJogador1
                  cJogadaLinha3Coluna3 := AllTrim(cEscolhaJogador1)
               else
                  cJogadaLinha3Coluna3 := AllTrim(cEscolhaJogador2)
               endif
            else
               Alert('Escolha outra casa!')
               loop
            endif

         endif

         nJogadasDisponiveis--

         if cVezJogador == cNomeJogador1
            cVezJogador := cNomeJogador2
         else
            cVezJogador := cNomeJogador1
         endif

         //valida ganhador
         cGanhador := ''

         if (cJogadaLinha1Coluna1 == 'X' .and. cJogadaLinha2Coluna1 == 'X' .and. cJogadaLinha3Coluna1 == 'X') .or. (cJogadaLinha1Coluna2 == 'X' .and. cJogadaLinha2Coluna2 == 'X' .and. cJogadaLinha3Coluna2 == 'X') .or. (cJogadaLinha1Coluna3 == 'X' .and. cJogadaLinha1Coluna3 == 'X' .and. cJogadaLinha3Coluna3 == 'X')
            if cEscolhaJogador1 == 'X'
               cGanhador := cNomeJogador1
            else
               cGanhador := cNomeJogador2
            endif
         endif

         //fazer condicao para todas as colunas
         if nJogadasDisponiveis == 0
            cGanhador := 'Deu velha!'
         endif

         if !Empty(cGanhador)
            Alert('Ganhador: ' + cGanhador)
            @ 10,02 clear to 20,70
            exit
         endif

         @ 10,02 clear to 13,70

      enddo
   
      elseif nPromptOpcao == 2 //calendar
         
         nLinhaInicial := 10
         nColunaInicial:= 10
         nEspacacamento := 3
         nLinhaInicialDias :=  nLinhaInicial + 2
         @ nLinhaInicial,nColunaInicial say "D  S  T  Q  Q  S  S"
         @ nLinhaInicial +1,nColunaInicial + nEspacacamento  to nLinhaInicial +1, nColunaInicial + 19

         cMes  := Space(02)
         cAno  := Space(04)
         @nLinhaInicial-1, nColunaInicial say AllTrim(cDataMes)

         //cMes := '12'
         //cAno := '2021'

         @ 05,05 say "Insira o mes [MM]..."
         @ 06,05 say "Insira o ano [AAAA]"
         
         @ 05,32 get cMes picture "99"
         @ 06,32 get cAno picture "9999"
         read

         if LastKey() == 27
            nOpcaoVoltarMenu := alert('Voltar ao menu principal?',{'Sim', 'Nao'})
            if nOpcaoVoltarMenu == 1
               exit
            else
               @ 03,01 clear to 20,70
               loop
            endif
         endif

         dDataCalendarioTela := cTod("01" + "/" + cMes + "/" + cAno)
         dMesCalendario := month( dDataCalendarioTela )

         nDataMes = month( dDataCalendarioTela )

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

         nMesControleTela := dMesCalendario

         cDataDiaSemanaTelaFormatado := ""

         do while dMesCalendario == nMesControleTela
            nDataDiaSemanaTela := Dow(dDataCalendarioTela)
            //Alert(str(nDataDiaSemanaTela))
            
            if nDataDiaSemanaTela == 1
               nColunaInicial := 10
            elseif nDataDiaSemanaTela == 2
               nColunaInicial := 13
            elseif nDataDiaSemanaTela == 3
               nColunaInicial := 16
            elseif nDataDiaSemanaTela == 4
               nColunaInicial := 19
            elseif nDataDiaSemanaTela == 5
               nColunaInicial := 22
            elseif nDataDiaSemanaTela == 6
               nColunaInicial := 25
            elseif nDataDiaSemanaTela == 7
               nColunaInicial := 28
            endif

            cDataDiaSemanaTelaFormatado := AllTrim((Str(Day(dDataCalendarioTela))))
            //cDataDiaSemanaTelaFormatado+= 

            @nLinhaInicialDias, nColunaInicial say cDataDiaSemanaTelaFormatado
            
            dDataCalendarioTela++
            
            if nColunaInicial == 28
               nLinhaInicialDias++
               nColunaInicial := 10
            endif

            dMesCalendario := month( dDataCalendarioTela )

            @nLinhaInicial-1, nColunaInicial clear to nLinhaInicial-1,50

         enddo
      elseif nPromptOpcao == 3 //validador
         @ 03,01 clear to 20,70
         cValidarCaractereCaixaBaixa := 'abcdefghijklmnopqrstuvwxyz'
         cValidarCaractereCaixaAlta := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 
         cValidarNumerico := '0123456789'
         cValidarEspecial := '!@#$%&*()_+'
         
         do while .t.
            cSenhaUsuario := space(20)
            cSenhaUsuarioSemEspacos = AllTrim(cSenhaUsuario)

            @ 05, 05 say 'Insira sua senha para analise...'

            @ 06,05 get cSenhaUsuario picture '@'
            read

            if LastKey() == 27
               nOpcaoVoltarMenu := alert('Voltar ao menu principal?',{'Sim', 'Nao'})
               if nOpcaoVoltarMenu == 1
                  exit
               else
                  @ 03,01 clear to 20,70
                  loop
               endif
            endif

            cSenhaUsuarioSemEspacos = AllTrim(cSenhaUsuario)

            if Len(cSenhaUsuarioSemEspacos) < 8
               Alert('A senha deve ter no minino 8 digitos!')
               ALERT(STR(Len(cSenhaUsuarioSemEspacos)))
               loop
            elseif (cSenhaUsuarioSemEspacos $ cValidarCaractereCaixaAlta)
               alert('Necessario ao menos uma LETRA MAIUSCULA')
               loop
            elseif (cSenhaUsuarioSemEspacos $ cValidarCaractereCaixaBaixa)
               alert('NECESSARIO AO MENOS UMA letra minuscula')
               loop
            elseif (cSenhaUsuarioSemEspacos $ cValidarEspecial)
               alert('Necessario ao menos um caractere especial')
               loop
            elseif (cSenhaUsuarioSemEspacos $ cValidarNumerico)
               alert('Necessario digitar ao menos um NUMERO')
               loop
            else
               alert('Senha segura. PARABENS')
              EXIT
            endif


         enddo


      endif
   endDo


enddo