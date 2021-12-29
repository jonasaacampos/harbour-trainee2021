/********************************************/
/***     JONAS CAMPOS - SG TRAINEE 2021    **/
/********************************************/

set message to 11 center
setmode(25,80)
set scoreboard off

Set color to R+/N
clear

? '     |/|'
? '     |/|'
? '     |/|'
? '     |/|'
? '     |/|'
? '     |/|'
? '     |/| /¯)'
? '     |/|/\/'
? '     |/|\/'
? '    (¯¯¯)'
? '    (¯¯¯)'
? '    (¯¯¯)'
? '    (¯¯¯)'
? '    (¯¯¯)'
? '    /¯¯/\'
? '   / ,^./\'
? '  / /   \/\'
? ' / /     \/\'
? '( (       )/)'
? '| |       |/|'
? '| |       |/|'
? '| |       |/|'
? '( (       )/)'
? ' \ \     / / '
? '  \ `---` /  '
? '   `-----`   '

? '----------- JOGO DA FORCA-----------'
? 'PRESSIONE QUALQUER TECLA PARA INICIAR'
InKey(0)

do while .t.
   SetColor('W+/R+')
   clear
   cJogadorNome    := Space( 30 )
   cPalavra        := Space( 30 )
   
   
   //validacao para caso usuario entre com caracters nao alfabeticos
   cLetraValida        :='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
   nLetrasInvalidas := 0      //easter egg
   
   @ 01,01 say "Nome:"
   @ 03,01 say "Digite uma palavra para o jogo..."

   @ 01,06 get cJogadorNome   picture "@!" Valid( !Empty( cJogadorNome ) )
   @ 03,34 get cPalavra       picture "@!" Valid( !Empty( cPalavra ) )
   read

   cPalavra := AllTrim(cPalavra)
   nPalavraTamanho := Len( cPalavra )
   clear

   if lastkey() == 27
      nAlerOpcaoSair := Alert( "Finalizar jogo?",{ "Sim","Nao" } )
      
      if nAlerOpcaoSair == 1
         exit
      endif

      loop
   endif
   
   @ 03,61 prompt "Facil  "   message "Para quem quer uma colher de cha"
   @ 04,61 prompt "Medio  "   message "Pra ja entende do jogo"
   @ 05,61 prompt "Dificil"   message "Pra quem nao teme o perigo"
   @ 06,61 prompt "Sair   "   message "Finaliza jogo"
   menu to nPromptEscolhaDificuldade
    
   //*DICAS* para usuario inserir/
    if nPromptEscolhaDificuldade == 1
      cDica1 := Space(20)
      cDica2 := Space(20)
      cDica3 := Space(20)
      
      @ 01,01 say 'Dica 1: '
      @ 02,01 say 'Dica 2: '
      @ 03,01 say 'Dica 3: '

      @ 01,09 get cDica1 picture '@'
      @ 02,09 get cDica2 picture '@'
      @ 03,09 get cDica3 picture '@'
      read

      if lastkey() == 27
         
         nAlerOpcaoVoltar := Alert( "Voltar para menu?", { "Sim","Nao" } )
         
         if nAlerOpcaoVoltar == 1
            exit
         endif

         loop
      endif

   endif

   nTentativasErro      := 0
   cLetrasUtilizadas      := ""
   nTentativasCorretas  := 0
   cLetra               := Space( 1 )
   clear

   @ 15,10 say Replicate( "_", nPalavraTamanho )
   @ 17,10 say "Letra:"

   do while .t.
      nPalavraTamanho := Len( cPalavra )
   
   if nPromptEscolhaDificuldade == 1

      if nTentativasErro = 2
         Alert( "DICA: " + cDica1 )
      elseif nTentativasErro = 4
         Alert( "DICA: " + cDica2 )
      elseif nTentativasErro = 6
         Alert( "DICA: " + cDica3 )
      endif

   endif

      @ 01,01 say cLetrasUtilizadas
      
      @ 17,17 get cLetra picture "@!" valid !Empty( cLetra )
      read

      if lastkey() == 27

         nAlerOpcaoReiniciar  := Alert( "Reniciar jogo?", { "Sim", "Nao"} )
         
         if nAlerOpcaoReiniciar == 1
            exit
         endif
         
         loop
      endif

      //validador letras e easter egg...
      if !(cLetra $ cLetraValida)
         Alert('Caracter Invalido!')
         nLetrasInvalidas++
         loop
      endif

      //letras utilizadas
      if cLetra $ cLetrasUtilizadas
         Alert( "Ja tentou esta letra!" )
         loop
      else
         cLetrasUtilizadas += " " + cLetra
      endif
      
      //verifica palavra
      if cLetra $ cPalavra
         do while nPalavraTamanho > 0

            if cLetra $  Substr( cPalavra, nPalavraTamanho, 1 )
               @ 15,nPalavraTamanho say cLetra
               nTentativasCorretas++
            endif
            nPalavraTamanho--

         enddo
      else
         nTentativasErro++
         @ 01,60 say 'Erros ate agora: ' + AllTrim( Str( nTentativasErro ) )

         if nTentativasErro = 1
            @ 20,45 say "'''''''|_`-' `-' |''''''''|"
            @ 21,45 say "|''|''''''''\ \       '''|''|"
            @ 22,45 say "| |        \ \        | |"
            @ 23,45 say ": :         \ \       : : "
            @ 24,45 say ". .          `'       . ."
         elseif nTentativasErro = 2
            @ 15,45 say "| |          ||'||"
            @ 16,45 say "| |          || ||"
            @ 17,45 say "| |          || ||"
            @ 18,45 say "| |          || ||"
            @ 19,45 say "| |         / | | \"   
         elseif nTentativasErro = 3
            @ 15,45 say "| |          ||"
            @ 16,45 say "| |          ||"
            @ 17,45 say "| |          ||"
            @ 18,45 say "| |          ||"
            @ 19,45 say "| |         / |"
         elseif nTentativasErro = 4
            @ 10,45 say "| |         .-`--'."
            @ 11,45 say "| |        /Y . . Y\"
            @ 12,45 say "| |       // |   | \\"
            @ 13,45 say "| |      //  | . |  \\"
            @ 14,45 say "| |     ')   |   |   (`"
         elseif nTentativasErro = 5
            @ 10,45 say "| |         .-`-"
            @ 11,45 say "| |        /Y . "
            @ 12,45 say "| |       // |  "
            @ 13,45 say "| |      //  | "
            @ 14,45 say "| |     ')   | "
         elseif nTentativasErro = 6
            @ 02,45 say "___________.._______"
            @ 03,45 say "| .__________))______|"
            @ 04,45 say "| | / /      ||"
            @ 05,45 say "| |/ /       ||"
            @ 06,45 say "| | /        ||.-''."
            @ 07,45 say "| |/         |/  _  \"
            @ 08,45 say "| |          ||  `/  |"
            @ 09,45 say "| |          (\\`_.'"
            @ 10,45 say "| |         .-`--'."
            
            Inkey(0)
            Alert( "VACILOU PERDEU! Tente em um nivel mais facil..." )
            exit
         endif
      endif

      if nTentativasCorretas = Len( cPalavra )
         Alert( "Voce venceu. DESTA vez..." )
         exit
      endif

   enddo

   nOpcaoReiniciarJogo := Alert( "Jogar novamente?", { 'Sim', 'Nao' } )
   
   if nOpcaoReiniciarJogo == 1
      clear
   else
      clear
      exit
   endif

enddo

? 'Pressione qualquer tecla para sair...'
Inkey(0)
