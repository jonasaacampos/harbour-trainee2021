/********************************************/
/***     JONAS CAMPOS - SG TRAINEE 2021    **/
/********************************************/
clear
set message to 21 center
setmode(25,80)
set scoreboard on

//bordas e cores (cores == fonte/fundo)
@ 00,00 to 24,79 double
@ 03,01 to 03,78 double

cCorAzulBranco       := "W+/B"
cCorPretoBranco      := "N/W+"
cCorBrancoPreto      := "W+/N"
cCorVerdePreto       := "G+/N"
cCorVermelhoBranco   := "R+/W"
cCorVerdeBranco      := "G/W"

//title
cTitulo              := "Escola Rural"
cCidade              := "Maringa"
cEndereco            := "Avenida dos Confidentes, 450. Zona Rural"

@ 01,01 say padC(cTitulo, 70)
@ 02,01 say PadC(cEndereco + " - " + cCidade + ".", 80)

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

//Tratamento para exibicao dos dias da semana e mes por extenso
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
cMascaraMonetario       := "@E 9,999.99"

//footer
@ 22,01 to 22,78 double
@ 23,20 say cCidade + " - " + cDataDiaSemana + ", " + transform(dDataDia, cMascaraTexto) + " de " + cDataMes + " de " + transform(dDataAno, cMascaraAno) + "."

/****************************************************************/
/***                    PROGRAMA PRINCIPAL                     **/
/****************************************************************/

cNomealuno                 := Space(30)
cCurso                     := Space(20)
dDataNasc                  := cTod("")
nTelefone                  := Space(16)
cEndereco                  := Space(40)
nValorMensalidade          := 0
nSerie                     := 0
nAnoLetivo                 := dDataAno
cAlunoBolsa                := Space( 1 )
lConselhoReprovado         := .F.
cVotoConselho1             := Space( 1 )
cVotoConselho2             := Space( 1 )
cVotoConselho3             := Space( 1 )
nVotoNaoConselho           := 0

//Variaveis Analiticas
nTaxaMensalidade           := 0.1 //10%
nTaxaValorAdicional        := 12
nValorMensalidadeAcrescimo := 0
cDPMaterias                := ""
nDPQuantidade              := 0
nValorNovaMensalidade      := 0
cAprovadoReprovado         := ""
cMediaStatusCor            := ""
nDescontoBolsaParcial      := 0.5
nDescontoBolsaIntegral     := 0.98
nValorBolsa                := 0
nValorMensalidadeProximoAno:= 0

//cadastro do aluno
@ 04,01 say "Aluno: "
@ 04,45 say "Data Nasc.: "
@ 05,01 say "Curso: "
@ 05,30 say "Serie: "
@ 05,45 say "Ano Letivo"
@ 06,01 say "Endereco: "
@ 06,55 say "R$ Mensalidade: "
@ 07,01 say "Bolsista [I/P/S] ? [I] - Integral | [P] - Parcial | [S] - Sem bolsa: "

@ 04,07 get cNomealuno           picture cMascaraTexto      Valid !Empty(cNomealuno)         color cCorBrancoPreto
@ 04,55 get dDataNasc                                                                        color cCorBrancoPreto
@ 05,07 get cCurso               picture cMascaraTexto      Valid !Empty(cCurso)             color cCorBrancoPreto
@ 05,38 get nSerie               picture '9'                Valid !Empty(nSerie)             color cCorBrancoPreto
@ 05,60 get nAnoLetivo           picture '9999'                                              color cCorBrancoPreto
@ 06,11 get cEndereco            picture cMascaraTexto                                       color cCorBrancoPreto
@ 06,69 get nValorMensalidade    picture cMascaraMonetario  Valid !Empty(nValorMensalidade)  color cCorBrancoPreto
@ 07,71 get cAlunoBolsa          picture '@!'               Valid cAlunoBolsa $ 'IPS'
read


//Materia 1
//Variaveis para lancamento notas e faltas
cMateria                         := Space(10)
nMateriaNotaBimestre1            := 0
nMateriaNotaBimestre2            := 0
nMateriaNotaBimestre3            := 0
nMateriaNotaBimestre4            := 0
nMateriaFaltasBimestre1          := 0
nMateriaFaltasBimestre2          := 0
nMateriaFaltasBimestre3          := 0
nMateriaFaltasBimestre4          := 0
nMateriaMedia                    := 0
nMateriaFaltas                   := 0
nQuantidadeFaltasReprovacao      := 12
nQuantidadeMinimaFaltasConselho  := nQuantidadeFaltasReprovacao
nQuantidadeMaximaFaltasConselho  := 15

//Variaveis controle coluna
nColuna                 := 10
nColunaLabel            := 1
nColunaInput            := 5
nContador               := 1

//Lancamento de notas (labels)
@ 08,nColuna      say "Materia " + Transform(nContador, "9")
@ 09,nColuna+13   say "F"
@ 10,nColuna      say "Bim.1: "
@ 11,nColuna      say "Bim.2: "
@ 12,nColuna      say "Bim.3: "
@ 13,nColuna      say "Bim.4: "
@ 14,nColuna      say "Faltas: "
@ 15,nColuna      say "Media: "

//Lancamento de notas (inputs)
@ 09,nColuna      get cMateria                  picture cMascaraTexto            Valid !Empty(cMateria)                                           
@ 10,nColuna+6    get nMateriaNotaBimestre1     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre1 >=0 .and. nMateriaNotaBimestre1 <=10)       
@ 10,nColuna+13   get nMateriaFaltasBimestre1   picture "99"                     Valid(nMateriaFaltasBimestre1 >= 0)                                     
@ 11,nColuna+6    get nMateriaNotaBimestre2     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre2 >=0 .and. nMateriaNotaBimestre2 <=10)       
@ 11,nColuna+13   get nMateriaFaltasBimestre2   picture "99"                     Valid(nMateriaFaltasBimestre2 >= 0)                                     
@ 12,nColuna+6    get nMateriaNotaBimestre3     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre3 >=0 .and. nMateriaNotaBimestre3 <=10)       
@ 12,nColuna+13   get nMateriaFaltasBimestre3   picture "99"                     Valid(nMateriaFaltasBimestre3 >= 0)                                     
@ 13,nColuna+6    get nMateriaNotaBimestre4     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre4 >=0 .and. nMateriaNotaBimestre4 <=10)       
@ 13,nColuna+13   get nMateriaFaltasBimestre4   picture "99"                     Valid(nMateriaFaltasBimestre4 >= 0)                                     
read

//Calculos de Analise
nMateriaMedia  := (nMateriaNotaBimestre1 + nMateriaNotaBimestre2 + nMateriaNotaBimestre3 + nMateriaNotaBimestre4)/4
nMateriaFaltas := nMateriaFaltasBimestre1 + nMateriaFaltasBimestre2 + nMateriaFaltasBimestre3 + nMateriaFaltasBimestre4 

//votacao conselho
if (nMateriaFaltas >= nQuantidadeMinimaFaltasConselho .and. nMateriaFaltas <= nQuantidadeMaximaFaltasConselho) .and. nMateriaMedia > 6
   Alert('Passar pelo conselho de Classe!')
   @ 17,01 say 'Voto conselhelho n1: Reprovar Aluno? [S/N]:'
   @ 18,01 say 'Voto conselhelho n2: Reprovar Aluno? [S/N]:'
   @ 19,01 say 'Voto conselhelho n3: Reprovar Aluno? [S/N]:'

   @ 17,45 get cVotoConselho1 picture cMascaraTexto Valid cVotoConselho1 $ 'SN'
   @ 18,45 get cVotoConselho2 picture cMascaraTexto Valid cVotoConselho2 $ 'SN'
   @ 19,45 get cVotoConselho3 picture cMascaraTexto Valid cVotoConselho3 $ 'SN'
   read
   
   if cVotoConselho1 == 'N'
      nVotoNaoConselho++
   endif

   if cVotoConselho2 == 'N'
      nVotoNaoConselho++
   endif

   if cVotoConselho2 == 'N'
      nVotoNaoConselho++
   endif

   @ 17,01 clear to 19,46
endif

if (nMateriaMedia < 6) .or. (nMateriaFaltas > nQuantidadeMaximaFaltasConselho) .or. (nVotoNaoConselho >= 2)
   nDPQuantidade++
   cDPMaterias += allTrim(cMateria) + '   '
   nValorMensalidadeAcrescimo += (nValorMensalidade * nTaxaMensalidade) + nTaxaValorAdicional
endif

if nMateriaMedia < 6
   cMediaStatusCor := cCorVermelhoBranco
else
   cMediaStatusCor := cCorVerdeBranco
endif

@ 14,nColuna+7 say AllTrim(Transform(nMateriaFaltas, "99"))
@ 15,ncoluna+7 say allTrim(Transform(nMateriaMedia, cMascaraNumeroDecimal)) color cMediaStatusCor

cVotoConselho1    := Space(1)
cVotoConselho2    := Space(1)
cVotoConselho3    := Space(1)
nVotoNaoConselho  := 0



//Materia 2
nColuna += 20
nContador++

cMateria                := Space(10)
nMateriaNotaBimestre1   := 0
nMateriaNotaBimestre2   := 0
nMateriaNotaBimestre3   := 0
nMateriaNotaBimestre4   := 0
nMateriaFaltasBimestre1 := 0
nMateriaFaltasBimestre2 := 0
nMateriaFaltasBimestre3 := 0
nMateriaFaltasBimestre4 := 0
nMateriaMedia           := 0
nMateriaFaltas          := 0

//Lancamento de notas (labels)
@ 08,nColuna      say "Materia " + Transform(nContador, "9")
@ 09,nColuna+13   say "F"
@ 10,nColuna      say "Bim.1: "
@ 11,nColuna      say "Bim.2: "
@ 12,nColuna      say "Bim.3: "
@ 13,nColuna      say "Bim.4: "
@ 14,nColuna      say "Faltas: "
@ 15,nColuna      say "Media: "
//Lancamento de notas (inputs)
@ 09,nColuna      get cMateria                  picture cMascaraTexto            Valid !Empty(cMateria)
@ 10,nColuna+6    get nMateriaNotaBimestre1     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre1 >=0 .and. nMateriaNotaBimestre1 <=10)
@ 10,nColuna+13   get nMateriaFaltasBimestre1   picture "99"                     Valid(nMateriaFaltasBimestre1 >= 0)
@ 11,nColuna+6    get nMateriaNotaBimestre2     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre2 >=0 .and. nMateriaNotaBimestre2 <=10)
@ 11,nColuna+13   get nMateriaFaltasBimestre2   picture "99"                     Valid(nMateriaFaltasBimestre2 >= 0)
@ 12,nColuna+6    get nMateriaNotaBimestre3     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre3 >=0 .and. nMateriaNotaBimestre3 <=10)
@ 12,nColuna+13   get nMateriaFaltasBimestre3   picture "99"                     Valid(nMateriaFaltasBimestre3 >= 0)
@ 13,nColuna+6    get nMateriaNotaBimestre4     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre4 >=0 .and. nMateriaNotaBimestre4 <=10)
@ 13,nColuna+13   get nMateriaFaltasBimestre4   picture "99"                     Valid(nMateriaFaltasBimestre4 >= 0)
read

//Calculos de Analise
nMateriaMedia  := (nMateriaNotaBimestre1 + nMateriaNotaBimestre2 + nMateriaNotaBimestre3 + nMateriaNotaBimestre4)/4
nMateriaFaltas := nMateriaFaltasBimestre1 + nMateriaFaltasBimestre2 + nMateriaFaltasBimestre3 + nMateriaFaltasBimestre4 

//votacao conselho
if (nMateriaFaltas >= nQuantidadeMinimaFaltasConselho .and. nMateriaFaltas <= nQuantidadeMaximaFaltasConselho) .and. nMateriaMedia > 6
   Alert('Passar pelo conselho de Classe!')
   @ 17,01 say 'Voto conselhelho n1: Reprovar Aluno? [S/N]:'
   @ 18,01 say 'Voto conselhelho n2: Reprovar Aluno? [S/N]:'
   @ 19,01 say 'Voto conselhelho n3: Reprovar Aluno? [S/N]:'

   @ 17,45 get cVotoConselho1 picture cMascaraTexto Valid cVotoConselho1 $ 'SN'
   @ 18,45 get cVotoConselho2 picture cMascaraTexto Valid cVotoConselho2 $ 'SN'
   @ 19,45 get cVotoConselho3 picture cMascaraTexto Valid cVotoConselho3 $ 'SN'
   read
   
   if cVotoConselho1 == 'N'
      nVotoNaoConselho++
   endif

   if cVotoConselho2 == 'N'
      nVotoNaoConselho++
   endif

   if cVotoConselho2 == 'N'
      nVotoNaoConselho++
   endif

   @ 17,01 clear to 19,46
endif

if (nMateriaMedia < 6) .or. (nMateriaFaltas > nQuantidadeMaximaFaltasConselho) .or. (nVotoNaoConselho >= 2)
   nDPQuantidade++
   cDPMaterias += allTrim(cMateria) + '   '
   nValorMensalidadeAcrescimo += (nValorMensalidade * nTaxaMensalidade) + nTaxaValorAdicional
endif

if nMateriaMedia < 6
   cMediaStatusCor := cCorVermelhoBranco
else
   cMediaStatusCor := cCorVerdeBranco
endif

@ 14,nColuna+7 say AllTrim(Transform(nMateriaFaltas, "99"))
@ 15,ncoluna+7 say allTrim(Transform(nMateriaMedia, cMascaraNumeroDecimal)) color cMediaStatusCor

cVotoConselho1    := Space(1)
cVotoConselho2    := Space(1)
cVotoConselho3    := Space(1)
nVotoNaoConselho  := 0

//Materia 3
nColuna += 20
nContador++

cMateria                := Space(10)
nMateriaNotaBimestre1   := 0
nMateriaNotaBimestre2   := 0
nMateriaNotaBimestre3   := 0
nMateriaNotaBimestre4   := 0
nMateriaFaltasBimestre1 := 0
nMateriaFaltasBimestre2 := 0
nMateriaFaltasBimestre3 := 0
nMateriaFaltasBimestre4 := 0
nMateriaMedia           := 0
nMateriaFaltas          := 0

//Lancamento de notas (labels)
@ 08,nColuna      say "Materia " + Transform(nContador, "9")
@ 09,nColuna+13   say "F"
@ 10,nColuna      say "Bim.1: "
@ 11,nColuna      say "Bim.2: "
@ 12,nColuna      say "Bim.3: "
@ 13,nColuna      say "Bim.4: "
@ 14,nColuna      say "Faltas: "
@ 15,nColuna      say "Media: "
//Lancamento de notas (inputs)
@ 09,nColuna      get cMateria                  picture cMascaraTexto            Valid !Empty(cMateria)
@ 10,nColuna+6    get nMateriaNotaBimestre1     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre1 >=0 .and. nMateriaNotaBimestre1 <=10)
@ 10,nColuna+13   get nMateriaFaltasBimestre1   picture "99"                     Valid(nMateriaFaltasBimestre1 >= 0)
@ 11,nColuna+6    get nMateriaNotaBimestre2     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre2 >=0 .and. nMateriaNotaBimestre2 <=10)
@ 11,nColuna+13   get nMateriaFaltasBimestre2   picture "99"                     Valid(nMateriaFaltasBimestre2 >= 0)
@ 12,nColuna+6    get nMateriaNotaBimestre3     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre3 >=0 .and. nMateriaNotaBimestre3 <=10)
@ 12,nColuna+13   get nMateriaFaltasBimestre3   picture "99"                     Valid(nMateriaFaltasBimestre3 >= 0)
@ 13,nColuna+6    get nMateriaNotaBimestre4     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre4 >=0 .and. nMateriaNotaBimestre4 <=10)
@ 13,nColuna+13   get nMateriaFaltasBimestre4   picture "99"                     Valid(nMateriaFaltasBimestre4 >= 0)
read

//Calculos de Analise
nMateriaMedia  := (nMateriaNotaBimestre1 + nMateriaNotaBimestre2 + nMateriaNotaBimestre3 + nMateriaNotaBimestre4)/4
nMateriaFaltas := nMateriaFaltasBimestre1 + nMateriaFaltasBimestre2 + nMateriaFaltasBimestre3 + nMateriaFaltasBimestre4 

//votacao conselho
if (nMateriaFaltas >= nQuantidadeMinimaFaltasConselho .and. nMateriaFaltas <= nQuantidadeMaximaFaltasConselho) .and. nMateriaMedia > 6
   Alert('Passar pelo conselho de Classe!')
   @ 17,01 say 'Voto conselhelho n1: Reprovar Aluno? [S/N]:'
   @ 18,01 say 'Voto conselhelho n2: Reprovar Aluno? [S/N]:'
   @ 19,01 say 'Voto conselhelho n3: Reprovar Aluno? [S/N]:'

   @ 17,45 get cVotoConselho1 picture cMascaraTexto Valid cVotoConselho1 $ 'SN'
   @ 18,45 get cVotoConselho2 picture cMascaraTexto Valid cVotoConselho2 $ 'SN'
   @ 19,45 get cVotoConselho3 picture cMascaraTexto Valid cVotoConselho3 $ 'SN'
   read
   
   if cVotoConselho1 == 'N'
      nVotoNaoConselho++
   endif

   if cVotoConselho2 == 'N'
      nVotoNaoConselho++
   endif

   if cVotoConselho2 == 'N'
      nVotoNaoConselho++
   endif

   @ 17,01 clear to 19,46
endif

if (nMateriaMedia < 6) .or. (nMateriaFaltas > nQuantidadeMaximaFaltasConselho) .or. (nVotoNaoConselho >= 2)
   nDPQuantidade++
   cDPMaterias += allTrim(cMateria) + '   '
   nValorMensalidadeAcrescimo += (nValorMensalidade * nTaxaMensalidade) + nTaxaValorAdicional
endif

if nMateriaMedia < 6
   cMediaStatusCor := cCorVermelhoBranco
else
   cMediaStatusCor := cCorVerdeBranco
endif

@ 14,nColuna+7 say AllTrim(Transform(nMateriaFaltas, "99"))
@ 15,ncoluna+7 say allTrim(Transform(nMateriaMedia, cMascaraNumeroDecimal)) color cMediaStatusCor

cVotoConselho1    := Space(1)
cVotoConselho2    := Space(1)
cVotoConselho3    := Space(1)
nVotoNaoConselho  := 0

//limpeza de tela para lancamento da segunda metade das disciplinas
@ 17,10 say 'Pressione qualquer tecla para lancar o restante das disciplinas...'
Inkey(0)

@ 08,01 clear to 17,79

//Materia 4
nColuna  := 10
nContador++

cMateria                := Space(10)
nMateriaNotaBimestre1   := 0
nMateriaNotaBimestre2   := 0
nMateriaNotaBimestre3   := 0
nMateriaNotaBimestre4   := 0
nMateriaFaltasBimestre1 := 0
nMateriaFaltasBimestre2 := 0
nMateriaFaltasBimestre3 := 0
nMateriaFaltasBimestre4 := 0
nMateriaMedia           := 0
nMateriaFaltas          := 0

//Lancamento de notas (labels)
@ 08,nColuna      say "Materia " + Transform(nContador, "9")
@ 09,nColuna+13   say "F"
@ 10,nColuna      say "Bim.1: "
@ 11,nColuna      say "Bim.2: "
@ 12,nColuna      say "Bim.3: "
@ 13,nColuna      say "Bim.4: "
@ 14,nColuna      say "Faltas: "
@ 15,nColuna      say "Media: "
//Lancamento de notas (inputs)
@ 09,nColuna      get cMateria                  picture cMascaraTexto            Valid !Empty(cMateria)
@ 10,nColuna+6    get nMateriaNotaBimestre1     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre1 >=0 .and. nMateriaNotaBimestre1 <=10)
@ 10,nColuna+13   get nMateriaFaltasBimestre1   picture "99"                     Valid(nMateriaFaltasBimestre1 >= 0)
@ 11,nColuna+6    get nMateriaNotaBimestre2     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre2 >=0 .and. nMateriaNotaBimestre2 <=10)
@ 11,nColuna+13   get nMateriaFaltasBimestre2   picture "99"                     Valid(nMateriaFaltasBimestre2 >= 0)
@ 12,nColuna+6    get nMateriaNotaBimestre3     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre3 >=0 .and. nMateriaNotaBimestre3 <=10)
@ 12,nColuna+13   get nMateriaFaltasBimestre3   picture "99"                     Valid(nMateriaFaltasBimestre3 >= 0)
@ 13,nColuna+6    get nMateriaNotaBimestre4     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre4 >=0 .and. nMateriaNotaBimestre4 <=10)
@ 13,nColuna+13   get nMateriaFaltasBimestre4   picture "99"                     Valid(nMateriaFaltasBimestre4 >= 0)
read

//Calculos de Analise
nMateriaMedia  := (nMateriaNotaBimestre1 + nMateriaNotaBimestre2 + nMateriaNotaBimestre3 + nMateriaNotaBimestre4)/4
nMateriaFaltas := nMateriaFaltasBimestre1 + nMateriaFaltasBimestre2 + nMateriaFaltasBimestre3 + nMateriaFaltasBimestre4 

//votacao conselho
if (nMateriaFaltas >= nQuantidadeMinimaFaltasConselho .and. nMateriaFaltas <= nQuantidadeMaximaFaltasConselho) .and. nMateriaMedia > 6
   Alert('Passar pelo conselho de Classe!')
   @ 17,01 say 'Voto conselhelho n1: Reprovar Aluno? [S/N]:'
   @ 18,01 say 'Voto conselhelho n2: Reprovar Aluno? [S/N]:'
   @ 19,01 say 'Voto conselhelho n3: Reprovar Aluno? [S/N]:'

   @ 17,45 get cVotoConselho1 picture cMascaraTexto Valid cVotoConselho1 $ 'SN'
   @ 18,45 get cVotoConselho2 picture cMascaraTexto Valid cVotoConselho2 $ 'SN'
   @ 19,45 get cVotoConselho3 picture cMascaraTexto Valid cVotoConselho3 $ 'SN'
   read
   
   if cVotoConselho1 == 'N'
      nVotoNaoConselho++
   endif

   if cVotoConselho2 == 'N'
      nVotoNaoConselho++
   endif

   if cVotoConselho2 == 'N'
      nVotoNaoConselho++
   endif

   @ 17,01 clear to 19,46
endif

if (nMateriaMedia < 6) .or. (nMateriaFaltas > nQuantidadeMaximaFaltasConselho) .or. (nVotoNaoConselho >= 2)
   nDPQuantidade++
   cDPMaterias += allTrim(cMateria) + '   '
   nValorMensalidadeAcrescimo += (nValorMensalidade * nTaxaMensalidade) + nTaxaValorAdicional
endif

if nMateriaMedia < 6
   cMediaStatusCor := cCorVermelhoBranco
else
   cMediaStatusCor := cCorVerdeBranco
endif

@ 14,nColuna+7 say AllTrim(Transform(nMateriaFaltas, "99"))
@ 15,ncoluna+7 say allTrim(Transform(nMateriaMedia, cMascaraNumeroDecimal)) color cMediaStatusCor

cVotoConselho1    := Space(1)
cVotoConselho2    := Space(1)
cVotoConselho3    := Space(1)
nVotoNaoConselho  := 0

//Materia 5
nColuna  += 20
nContador++

cMateria                := Space(10)
nMateriaNotaBimestre1   := 0
nMateriaNotaBimestre2   := 0
nMateriaNotaBimestre3   := 0
nMateriaNotaBimestre4   := 0
nMateriaFaltasBimestre1 := 0
nMateriaFaltasBimestre2 := 0
nMateriaFaltasBimestre3 := 0
nMateriaFaltasBimestre4 := 0
nMateriaMedia           := 0
nMateriaFaltas          := 0

//Lancamento de notas (labels)
@ 08,nColuna      say "Materia " + Transform(nContador, "9")
@ 09,nColuna+13   say "F"
@ 10,nColuna      say "Bim.1: "
@ 11,nColuna      say "Bim.2: "
@ 12,nColuna      say "Bim.3: "
@ 13,nColuna      say "Bim.4: "
@ 14,nColuna      say "Faltas: "
@ 15,nColuna      say "Media: "
//Lancamento de notas (inputs)
@ 09,nColuna      get cMateria                  picture cMascaraTexto            Valid !Empty(cMateria)
@ 10,nColuna+6    get nMateriaNotaBimestre1     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre1 >=0 .and. nMateriaNotaBimestre1 <=10)
@ 10,nColuna+13   get nMateriaFaltasBimestre1   picture "99"                     Valid(nMateriaFaltasBimestre1 >= 0)
@ 11,nColuna+6    get nMateriaNotaBimestre2     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre2 >=0 .and. nMateriaNotaBimestre2 <=10)
@ 11,nColuna+13   get nMateriaFaltasBimestre2   picture "99"                     Valid(nMateriaFaltasBimestre2 >= 0)
@ 12,nColuna+6    get nMateriaNotaBimestre3     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre3 >=0 .and. nMateriaNotaBimestre3 <=10)
@ 12,nColuna+13   get nMateriaFaltasBimestre3   picture "99"                     Valid(nMateriaFaltasBimestre3 >= 0)
@ 13,nColuna+6    get nMateriaNotaBimestre4     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre4 >=0 .and. nMateriaNotaBimestre4 <=10)
@ 13,nColuna+13   get nMateriaFaltasBimestre4   picture "99"                     Valid(nMateriaFaltasBimestre4 >= 0)
read

//Calculos de Analise
nMateriaMedia  := (nMateriaNotaBimestre1 + nMateriaNotaBimestre2 + nMateriaNotaBimestre3 + nMateriaNotaBimestre4)/4
nMateriaFaltas := nMateriaFaltasBimestre1 + nMateriaFaltasBimestre2 + nMateriaFaltasBimestre3 + nMateriaFaltasBimestre4 

//votacao conselho
if (nMateriaFaltas >= nQuantidadeMinimaFaltasConselho .and. nMateriaFaltas <= nQuantidadeMaximaFaltasConselho) .and. nMateriaMedia > 6
   Alert('Passar pelo conselho de Classe!')
   @ 17,01 say 'Voto conselhelho n1: Reprovar Aluno? [S/N]:'
   @ 18,01 say 'Voto conselhelho n2: Reprovar Aluno? [S/N]:'
   @ 19,01 say 'Voto conselhelho n3: Reprovar Aluno? [S/N]:'

   @ 17,45 get cVotoConselho1 picture cMascaraTexto Valid cVotoConselho1 $ 'SN'
   @ 18,45 get cVotoConselho2 picture cMascaraTexto Valid cVotoConselho2 $ 'SN'
   @ 19,45 get cVotoConselho3 picture cMascaraTexto Valid cVotoConselho3 $ 'SN'
   read
   
   if cVotoConselho1 == 'N'
      nVotoNaoConselho++
   endif

   if cVotoConselho2 == 'N'
      nVotoNaoConselho++
   endif

   if cVotoConselho2 == 'N'
      nVotoNaoConselho++
   endif

   @ 17,01 clear to 19,46
endif

if (nMateriaMedia < 6) .or. (nMateriaFaltas > nQuantidadeMaximaFaltasConselho) .or. (nVotoNaoConselho >= 2)
   nDPQuantidade++
   cDPMaterias += allTrim(cMateria) + '   '
   nValorMensalidadeAcrescimo += (nValorMensalidade * nTaxaMensalidade) + nTaxaValorAdicional
endif

if nMateriaMedia < 6
   cMediaStatusCor := cCorVermelhoBranco
else
   cMediaStatusCor := cCorVerdeBranco
endif

@ 14,nColuna+7 say AllTrim(Transform(nMateriaFaltas, "99"))
@ 15,ncoluna+7 say allTrim(Transform(nMateriaMedia, cMascaraNumeroDecimal)) color cMediaStatusCor

cVotoConselho1    := Space(1)
cVotoConselho2    := Space(1)
cVotoConselho3    := Space(1)
nVotoNaoConselho  := 0

//Materia 6
nColuna  += 20
nContador++

cMateria                := Space(10)
nMateriaNotaBimestre1   := 0
nMateriaNotaBimestre2   := 0
nMateriaNotaBimestre3   := 0
nMateriaNotaBimestre4   := 0
nMateriaFaltasBimestre1 := 0
nMateriaFaltasBimestre2 := 0
nMateriaFaltasBimestre3 := 0
nMateriaFaltasBimestre4 := 0
nMateriaMedia           := 0
nMateriaFaltas          := 0

//Lancamento de notas (labels)
@ 08,nColuna      say "Materia " + Transform(nContador, "9")
@ 09,nColuna+13   say "F"
@ 10,nColuna      say "Bim.1: "
@ 11,nColuna      say "Bim.2: "
@ 12,nColuna      say "Bim.3: "
@ 13,nColuna      say "Bim.4: "
@ 14,nColuna      say "Faltas: "
@ 15,nColuna      say "Media: "
//Lancamento de notas (inputs)
@ 09,nColuna      get cMateria                  picture cMascaraTexto            Valid !Empty(cMateria)
@ 10,nColuna+6    get nMateriaNotaBimestre1     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre1 >=0 .and. nMateriaNotaBimestre1 <=10)
@ 10,nColuna+13   get nMateriaFaltasBimestre1   picture "99"                     Valid(nMateriaFaltasBimestre1 >= 0)
@ 11,nColuna+6    get nMateriaNotaBimestre2     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre2 >=0 .and. nMateriaNotaBimestre2 <=10)
@ 11,nColuna+13   get nMateriaFaltasBimestre2   picture "99"                     Valid(nMateriaFaltasBimestre2 >= 0)
@ 12,nColuna+6    get nMateriaNotaBimestre3     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre3 >=0 .and. nMateriaNotaBimestre3 <=10)
@ 12,nColuna+13   get nMateriaFaltasBimestre3   picture "99"                     Valid(nMateriaFaltasBimestre3 >= 0)
@ 13,nColuna+6    get nMateriaNotaBimestre4     picture cMascaraNumeroDecimal    Valid(nMateriaNotaBimestre4 >=0 .and. nMateriaNotaBimestre4 <=10)
@ 13,nColuna+13   get nMateriaFaltasBimestre4   picture "99"                     Valid(nMateriaFaltasBimestre4 >= 0)
read

//Calculos de Analise
nMateriaMedia  := (nMateriaNotaBimestre1 + nMateriaNotaBimestre2 + nMateriaNotaBimestre3 + nMateriaNotaBimestre4)/4
nMateriaFaltas := nMateriaFaltasBimestre1 + nMateriaFaltasBimestre2 + nMateriaFaltasBimestre3 + nMateriaFaltasBimestre4 

//votacao conselho
if (nMateriaFaltas >= nQuantidadeMinimaFaltasConselho .and. nMateriaFaltas <= nQuantidadeMaximaFaltasConselho) .and. nMateriaMedia > 6
   Alert('Passar pelo conselho de Classe!')
   @ 17,01 say 'Voto conselhelho n1: Reprovar Aluno? [S/N]:'
   @ 18,01 say 'Voto conselhelho n2: Reprovar Aluno? [S/N]:'
   @ 19,01 say 'Voto conselhelho n3: Reprovar Aluno? [S/N]:'

   @ 17,45 get cVotoConselho1 picture cMascaraTexto Valid cVotoConselho1 $ 'SN'
   @ 18,45 get cVotoConselho2 picture cMascaraTexto Valid cVotoConselho2 $ 'SN'
   @ 19,45 get cVotoConselho3 picture cMascaraTexto Valid cVotoConselho3 $ 'SN'
   read
   
   if cVotoConselho1 == 'N'
      nVotoNaoConselho++
   endif

   if cVotoConselho2 == 'N'
      nVotoNaoConselho++
   endif

   if cVotoConselho2 == 'N'
      nVotoNaoConselho++
   endif

   @ 17,01 clear to 19,46
endif

if (nMateriaMedia < 6) .or. (nMateriaFaltas > nQuantidadeMaximaFaltasConselho) .or. (nVotoNaoConselho >= 2)
   nDPQuantidade++
   cDPMaterias += allTrim(cMateria) + '   '
   nValorMensalidadeAcrescimo += (nValorMensalidade * nTaxaMensalidade) + nTaxaValorAdicional
endif

if nMateriaMedia < 6
   cMediaStatusCor := cCorVermelhoBranco
else
   cMediaStatusCor := cCorVerdeBranco
endif

@ 14,nColuna+7 say AllTrim(Transform(nMateriaFaltas, "99"))
@ 15,ncoluna+7 say allTrim(Transform(nMateriaMedia, cMascaraNumeroDecimal)) color cMediaStatusCor

cVotoConselho1    := Space(1)
cVotoConselho2    := Space(1)
cVotoConselho3    := Space(1)
nVotoNaoConselho  := 0


//limpeza para analise do desempenho do aluno
@ 17,10 say 'Pressione qualquer tecla para verificar o desempenho do aluno...'
Inkey(0)

@ 08,01 clear to 17,79

//Analise das notas e situacao do aluno
if (nDPQuantidade <= 2 .and. cAlunoBolsa == 'S') .or. (nDPQuantidade <= 1 .and. cAlunoBolsa == 'P') .or. (nDPQuantidade == 0 .and. cAlunoBolsa == 'I')
   cAprovadoReprovado := "APROVADO"
else
   cAprovadoReprovado := "REPROVADO"
endif

@ 10,20 say "O Aluno foi " + allTrim(cAprovadoReprovado)
@ 11,20 say "O aluno foi reprovado em " + allTrim(str(nDPQuantidade)) + " materias."

if cAprovadoReprovado == "APROVADO"
   if Empty(nDPQuantidade)
      @ 12,20 say "Aprovado sem Dependencias! Parabens!"
      @ 13,20 say "Valor da mensalidade sera o mesmo que o atual"
   else
      @ 12,20 say "Dependencias em: " + allTrim(cDPMaterias)
      @ 13,20 say "Mensalidade proximo ano (SEM  BOLSA): R$" +  Transform(nValorMensalidadeAcrescimo + nValorMensalidade, "@E 99,999.99")
   endif

   if cAlunoBolsa == 'I'
      nValorBolsa += nValorMensalidade * nDescontoBolsaIntegral
   elseif cAlunoBolsa == 'P'
      nValorBolsa += nValorMensalidade * nDescontoBolsaParcial
   endif
endif

nValorMensalidadeProximoAno := allTrim(Transform((nValorMensalidade - nValorBolsa) + nValorMensalidadeAcrescimo, cMascaraMonetario))

@ 14,20 say 'VALOR da Bolsa proximo ano: R$ ' + Alltrim(Transform( nValorBolsa, cMascaraMonetario))
@ 15,20 say 'Valor Adicional DP: ' + allTrim(transform(nValorMensalidadeAcrescimo, cMascaraMonetario))
@ 16,20 say 'Total Mensalidade proximo ano: R$ ' + nValorMensalidadeProximoAno

@ 20,01 say "Pressione qualquer tecla para sair..."
Inkey(0)