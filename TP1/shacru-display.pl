printExample(_) :-
	nl,
	write('Information About How a Shacru Board works:'), nl,
			write('\tElements of the game:'), nl,
				write('\t\t[whitespace] -> empty'), nl,
				write('\t\tO -> Occupied Territory marker'), nl,
				write('\t\tN/S/E/W-> Directions and subdirections in which way you can move'), nl,
				write('\t\t\":\"> Player 1 territory'), nl,
				write('\t\t\"*\"-> Player 2 territory'), nl,
				

	write('\tBoard Game Example:'), nl,
				write('\t\t|-----------------------------------------------------|'), nl,
				write('\t\t|NW:: | ::: |     |     |     |     |     |     |     |'), nl,
				write('\t\t| :O: | :O: |     |     |     |     |     |     |     |'), nl,
				write('\t\t| ::: | ::: |     |     |     |     |     |     |     |'), nl,
				write('\t\t|----- ----- -----|----- ----- -----|----- ----- -----|'), nl,
				write('\t\t| ::: | ::: | ::: |     |     |     |     |     |     |'), nl,
				write('\t\t| :O: | :O: | :O: |     |     |     |     |     |     |'), nl,
				write('\t\t| ::: | ::: | ::: |     |     |     |     |     |     |'), nl,
				write('\t\t|----- ----- -----|----- ----- -----|----- ----- -----|'), nl,
				write('\t\t| ::: | ::: | ::: | ::: |     |     | *** | *** | *** |'), nl,
				write('\t\t| :O: | :O: | :O: | :O: |     |     | *O* | *O* | *OE |'), nl,
				write('\t\t| ::: | ::: | ::: | ::: |     |     | *** | *** | *** |'), nl,
				write('\t\t|-----------------------------------------------------|'), nl,
				write('\t\t|     | ::: |     |     |     |     |     | :N: | :N: |'), nl,
				write('\t\t|     | :O: |     |     |     |     |     | :O: | ::: |'), nl,
				write('\t\t|     | ::: |     |     |     |     |     | ::: | ::: |'), nl,	
				write('\t\t|----- ----- -----|----- ----- -----|----- ----- -----|'), nl,
				write('\t\t|     |     |     |     |     |     | *** | ::: |     |'), nl,
				write('\t\t|     |     |     |     |     |     | *O* | :O: |     |'), nl,
				write('\t\t|     |     |     |     |     |     | *** | ::: |     |'), nl,	
				write('\t\t|----- ----- -----|----- ----- -----|----- ----- -----|'), nl,
				write('\t\t|     |     |     |     |     | ::: | *** | ::: |     |'), nl,
				write('\t\t|     |     |     |     |     | :O: | *O* | :O: |     |'), nl,
				write('\t\t|     |     |     |     |     | ::: | *S* | ::: |     |'), nl,
				write('\t\t|-----------------------------------------------------|'), nl,
				write('\t\t| *** | *** |     |     |     | ::: | ::: | ::: |     |'), nl,
				write('\t\t| WO* | *O* |     |     |     | :O: | :O: | :O: |     |'), nl,
				write('\t\t| *** | *** |     |     |     | ::: | ::: | ::: |     |'), nl,
				write('\t\t|----- ----- -----|----- ----- -----|----- ----- -----|'), nl,
				write('\t\t|     |     |     |     | ::: |     |     | *** | *** |'), nl,
				write('\t\t|     |     |     |     | :O: |     |     | *O* | *OE |'), nl,
				write('\t\t|     |     |     |     | ::: |     |     | *** | *** |'), nl,
				write('\t\t|----- ----- -----|----- ----- -----|----- ----- -----|'), nl,
				write('\t\t|     |     |     |     | ::: |     |     |     |     |'), nl,
				write('\t\t|     |     |     |     | :O: |     |     |     |     |'), nl,
				write('\t\t|     |     |     |     | :S: |     |     |     |     |'), nl,
				write('\t\t|-----------------------------------------------------|'), nl.

%traduz o atomo para peca de jogo
translateCodeToChar(-1, ' ').
translateCodeToChar(0, 'O').
translateCodeToChar(1, ':').
translateCodeToChar(2, '*').
translateCodeToChar(11,'NW').
translateCodeToChar(12,'N').
translateCodeToChar(13,'NE').
translateCodeToChar(14,'W').
translateCodeToChar(16,'E').
translateCodeToChar(17,'SW').
translateCodeToChar(18,'S').
translateCodeToChar(19,'SE').
translateCodeToChar(21,'NW').
translateCodeToChar(22,'N').
translateCodeToChar(23,'NE').
translateCodeToChar(24,'W').
translateCodeToChar(26,'E').
translateCodeToChar(27,'SW').
translateCodeToChar(28,'S').
translateCodeToChar(29,'SE').
translateCodeToChar(X, X).

	%Função usada para imprimir a linha inicial do tabuleiro

	printDashLine(1):-
		write('-----').

	printDashLine(_):-
		write('------').

	printTop(0):-
		write('|').
	printTop(N):-
		printDashLine(N),
		Counter is N-1,
		printTop(Counter).




	printFullTile(0).

	printFullTile(NumberofCells):-
		Result is NumberofCells rem 9,
		Result == 0,
		printFullCell(NumberofCells),
		printTop(9).

	printFullTile(NumberofCells):-
		printFullCell(NumberofCells),
		write('|'),
		printIntermediateLine(9),
		write('|').

	printFullCell(0).
	printFullCell(NumberofLines):-
		NumberofLines > 0,
		write('|'),
		printLineCell(9),
		nl,
		N is NumberofLines-1,
		printFullCell(N).

	printLineCell(NumberofCells):-
		printNormalLineofTiles(NumberofCells).

	printClearLine(_) :-
		write('     '),
		write('|').

	printNormalLineofTiles(0).
	printNormalLineofTiles(NumberofCells) :-
		NumberofCells>0,
		printClearLine(_),
		Ncells is NumberofCells-1,
		printNormalLineofTiles(Ncells).


	printIntermediateLine(1):-
		write('-----').

	printIntermediateLine(NumberofCells):-
		NumberofCells > 0,
		printIntermediate(9),
		N is NumberofCells-1,
		printIntermediateLine(N).

	
	printLine(1):-
		write('|'),
		printTop(9).

	printLine(N):-
		Result is N rem 7,
		Result == 0,
		write('|'),
		printTop(9),
		nl.


	printLine(N):-
		Result is N rem 2,
		Result == 1,
		write('|'),
		printIntermediateLine(9),
		write('|'),
		nl.

	printLine(_):-
		printFullCell(3).

	printIntermediate(_) :-
	write('-----'),
	write(' ').

	printFullSector(0).

	printFullSector(NumberofLines):-
		printLine(NumberofLines),
		Counter is NumberofLines-1,
		printFullSector(Counter).

	printBoardAux(0).
	printBoardAux(NumberofLines):-
		printFullSector(6),
		nl,
		Counter is NumberofLines-1,
		printBoardAux(Counter).

	printBoard(_):-
		write('|'),
		printTop(9),
		nl,
		printBoardAux(3).






