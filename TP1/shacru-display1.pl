:- include('shacru-logic.pl').
:- use_module(library(lists)).
:- use_module(library(sets)).

getPiece(Board, X, Y, Owner, Direction):-
	NewX is X-1,
	NewY is Y-1,
	nth0(NewY, Board, Line, _),
	nth0(NewX, Line, Cell, _),
	nth0(0, Cell, Owner, _),
	nth0(1, Cell, Direction, _).


startingBoard:-[	[[2, 9],[0, 0],[1, 8],[0, 0],[0, 0],[0, 0],[2, 8],[0, 0],[0, 0]],
				[[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
				[[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
				[[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
				[[1, 6],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[2, 4]],
				[[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
				[[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
				[[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
				[[0, 0],[0, 0],[1, 2],[0, 0],[0, 0],[0, 0],[2, 2],[0, 0],[1, 1]]
].


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

	printIntermediate(_) :-
	write('-----'),
	write(' ').

	printIntermediateLine(1):-
		write('-----').

	printIntermediateLine(NumberofCells):-
		NumberofCells > 0,
		printIntermediate(9),
		N is NumberofCells-1,
		printIntermediateLine(N).

printDirection(0):-write('Pass').
printDirection(1):-write('NW').
printDirection(2):-write('N').
printDirection(3):-write('NE').
printDirection(4):-write('W').
printDirection(5):-write('Pass').
printDirection(6):-write('E').
printDirection(7):-write('SW').
printDirection(8):-write('S').
printDirection(9):-write('SE').

	convertDirections(1,[1, 1]):- 
		write('1::').
	convertDirections(1,[1, 2]):- 
		write(':|:').
	convertDirections(1,[1, 3]):-
		write('::a').
	convertDirections(1,[2, 1]):-
		write('a**').
	convertDirections(1,[2, 2]):-
		write('*|*').
	convertDirections(1,[2, 3]):-
		write('**/').
	convertDirections(1, [_, _]):-
		write('   ').

	convertDirections(2,[1, 4]):-
		write('<1:').
	convertDirections(2,[1, 6]):-
		write(':1>').
	convertDirections(2,[1, _]):-
		write(':1:').
	convertDirections(2,[2, 4]):-
		write('<2*').
	convertDirections(2,[2, 6]):-
		write('*2>').
	convertDirections(2,[2, _]):-
		write('*2*').
	convertDirections(2, [_, _]):-
		write('   ').

	convertDirections(3,[1, 7]):-
		write('/::').
	convertDirections(3,[1, 8]):-
		write(':|:').
	convertDirections(3,[1, 9]):-
		write('::a').
	convertDirections(3,[2, 7]):-
		write('/**').
	convertDirections(3,[2, 8]):-
		write('*|*').
	convertDirections(3,[2, 9]):-
		write('**a').
	convertDirections(3, [_, _]):-
		write('   ').

	possiblePositions(Direction, PossiblePositions):- 
		Direction == 0 ; Direction == 5,
		PossiblePositions = [0].
	possiblePositions(Direction, PossiblePositions):- 
		Direction == 1,
		PossiblePositions = [4, 1, 2].
	possiblePositions(Direction, PossiblePositions):- 
		Direction == 2,
		PossiblePositions = [1, 2, 3].
	possiblePositions(Direction, PossiblePositions):- 
		Direction == 3,
		PossiblePositions = [2, 3, 6].
	possiblePositions(Direction, PossiblePositions):- 
		Direction == 4,
		PossiblePositions = [7, 4, 1].
	possiblePositions(Direction, PossiblePositions):- 
		Direction == 6,
		PossiblePositions = [3, 6, 9].
	possiblePositions(Direction, PossiblePositions):- 
		Direction == 7,
		PossiblePositions = [8, 7, 4].
	possiblePositions(Direction, PossiblePositions):- 
		Direction == 8,
		PossiblePositions = [9, 8, 7].
	possiblePositions(Direction, PossiblePositions):- 
		Direction == 9,
		PossiblePositions = [6, 9, 8].

printLine(_, [], _).
printLine(LineNumber, [Pair], _Counter):-
	convertDirections(LineNumber, Pair).
printLine(LineNumber, [Pair|Rest], 3):-
	convertDirections(LineNumber, Pair),
	write(' | '),
	printLine(LineNumber, Rest, 1).
printLine(LineNumber, [Pair|Rest], Counter):-
	NewCounter is Counter + 1,
	convertDirections(LineNumber, Pair),
	write(' | '),
	printLine(LineNumber, Rest, NewCounter).
	
printRow(Row):-
	write('| '), printLine(1, Row, 1), write(' |'), nl,
	write('| '), printLine(2, Row, 1), write(' |'), nl, 
	write('| '), printLine(3, Row, 1), write(' |'), nl.

displayBoard([], _).
displayBoard([Row], _Counter):-
	printRow(Row).
displayBoard([Row|Rest], 3):-
	printRow(Row),
	write('|'),
	printTop(9),nl,
	displayBoard(Rest, 1).
displayBoard([Row|Rest], Counter):-
	NewCounter is Counter + 1,
	printRow(Row),
	write('|'),
	printIntermediateLine(9),
	write('|'),nl,
	displayBoard(Rest, NewCounter).	

printBoard:-
	write('|'),
	printTop(9),nl,
	T=	[[[2, 0],[0, 0],[1, 0],[1, 2],[1, 2],[0, 0],[2, 0],[2, 0],[1, 3]],
		[[0, 0],[2, 0],[1, 0],[1, 0],[1, 0],[2, 0],[2, 0],[1, 0],[2, 0]],
		[[0, 0],[2, 0],[1, 0],[1, 0],[1, 0],[2, 0],[2, 0],[1, 0],[2, 0]],
		[[0, 0],[2, 0],[1, 0],[0, 0],[1, 0],[2, 0],[2, 0],[1, 0],[2, 0]],
		[[1, 0],[1, 0],[2, 0],[1, 9],[2, 0],[1, 0],[2, 0],[1, 0],[2, 0]],
		[[2, 4],[2, 0],[1, 0],[2, 0],[2, 0],[1, 0],[1, 0],[2, 0],[2, 6]],
		[[0, 0],[0, 0],[2, 0],[1, 0],[1, 0],[2, 0],[1, 0],[2, 0],[2, 6]],
		[[0, 0],[0, 0],[2, 0],[1, 0],[1, 0],[1, 0],[2, 0],[1, 0],[2, 9]],
		[[0, 0],[0, 0],[1, 0],[2, 0],[2, 0],[2, 0],[2, 0],[0, 0],[1, 0]]],
	displayBoard(T, 1),
	write('|'),
	printTop(9),nl.
printBoard(T):-
	write('|'),
	printTop(9),nl,
	displayBoard(T, 1),
	write('|'),
	printTop(9).
	
	drawPiece(Owner, Dir, Counter):-
		convertDirections(Owner, Dir, Tiles),
		nth0(Counter, Tiles, Tile,_),
		write(Tile),
		NewCounter is Counter+1,
		drawPiece(Owner,Dir, NewCounter).

	printElement(Board, X, Y):-
		getPiece(Board, X, Y, Owner, Direction),
		%write(Owner).
		drawPiece(Owner, Direction, 0).

showMovePiece([X, Y], Direction):-
	T=	[[[0, 0],[0, 0],[2, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
		[[0, 0],[1, 9],[2, 1],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
		[[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
		[[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
		[[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
		[[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
		[[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
		[[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
		[[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]]],
movePiece(T, [X, Y], Direction, NewT),
printBoard(NewT).