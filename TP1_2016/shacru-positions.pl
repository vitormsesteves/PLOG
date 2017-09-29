%%Poisitions and Directions%%%

%%%%%%%%%%%%%%% Block Used to get Players %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
getPlayer(Board, [X, Y], Player):-
	getTile(Board, [TilePlayer, _TileDirection], [X, Y]),
	Player = TilePlayer.

setPlayer(Board, [X, Y], Player, NewBoard):-
	getTile(Board, [_TilePlayer, TileDirection], [X, Y]),
	changeTile(Board, [X, Y], [Player, TileDirection], NewBoard).

%%%%%%%%%%%%%%%%%%%% Block Used to get Lines %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
getLine(Board, Line, LineNumber):- 
	getLine(Board, Line, LineNumber, 1).

getLine([], _, _, _):-
	write('Position non-existent, try choosing a LINE between 1 and 9, remember: [Columns,Lines]'), nl, fail.

getLine([Line|_Rest], ResultLine, LineNumber, LineNumber):- %when the Counter is equal to Line
	ResultLine = Line.

getLine([_Line|Rest], ResultLine, LineNumber, Counter):- 
	NewCounter is Counter + 1,
	getLine(Rest, ResultLine, LineNumber, NewCounter).

%%%%%%%%%%%%%%%%%%%% Block Used to get Columns %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
getColumn(Line, Tile, ColumnNumber):- 
	getColumn(Line, Tile, ColumnNumber, 1).

getColumn([], _, _, _):-
	write('Position non-existent, try choosing a COLUMN between 1 and 9, remember: [Columns,Lines]'), nl, fail.

getColumn([Element|_Rest], Tile, ColumnNumber, ColumnNumber):-
	Tile = Element.

getColumn([_Element|Rest], Tile, ColumnNumber, Counter):-
	NewCounter is Counter + 1,
	getColumn(Rest, Tile, ColumnNumber, NewCounter).

%%%%%%%%%%%%%%%%%% Block used to get the Tiles %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
getTile(Board, Tile, [X, Y]):-
	getLine(Board, Line, Y), !, 
	getColumn(Line, Tile, X).


%%%%%%%%%%%%%%%%%% Block used to get the Direction of a piece (2nd element of the list), so we can change it%%%%%%%%%%%%%%%%%%%%%%%%	

getDirection(Board, [X, Y], Direction):-
	getTile(Board, [_TilePlayer, TileDirection], [X, Y]),
	Direction = TileDirection.
	
setDirection(Board, [X, Y], Direction, NewBoard):-
	Direction > -1, Direction < 10,
	getTile(Board, [TilePlayer, _TileDirection], [X, Y]),
	changeTile(Board, [X, Y], [TilePlayer, Direction], NewBoard).

%%%%%%%%%%%%%%%%% Block used to Change to a new Line and verifying if it is possible to do that, so we can later validate the Move %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%used to change the board
changeLine(Board, NewLine, LineNumber, Result):- 
	length(NewLine, 9),
	LineNumber < 10,
	LineNumber > 0,
	changeLine(Board, [], LineNumber, NewLine, 1, Result).

changeLine(RemainderOfBoard, NewBoard, LineNumber, _, Counter, Result):-
	Counter > LineNumber,
	LineNumber < 10,
	append(NewBoard, RemainderOfBoard, Result).

changeLine([Line | Rest], NewBoard, LineNumber, NewLine, Counter, Result):-
	Counter < LineNumber,
	LineNumber > 0,
	NewCounter is Counter + 1,
	append(NewBoard, [Line], NewBoardPlus),
	changeLine(Rest, NewBoardPlus, LineNumber, NewLine, NewCounter, Result).

changeLine([_Line | Rest], NewBoard, LineNumber, NewLine, Counter, Result):-
	LineNumber =:= Counter,
	NewCounter is Counter + 1,
	append(NewBoard, [NewLine], NewBoardPlus), %Adds line to the NewBoard
	changeLine(Rest, NewBoardPlus, LineNumber, NewLine, NewCounter, Result).

%%%%%%%%%%%%%%%%% Block used to Change to a new Column and verifying if it is possible to do that, so we can later validate the Move %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%used to switch between lines
changeColumn(Line, NewElement, ColumnNumber, Result):-
	length(NewElement, 2),
	ColumnNumber > 0,
	ColumnNumber < 10,
	changeColumn(Line, [], NewElement, ColumnNumber, 1, Result).
changeColumn([_Element | Rest], TempLine, NewElement, ColumnNumber, Iterator, Result):-
	Iterator =:= ColumnNumber,
	append(TempLine, [NewElement], TempLinePlus),
	append(TempLinePlus, Rest, Result).
changeColumn([Element | Rest], TempLine, NewElement, ColumnNumber, Iterator, Result):-
	Iterator < ColumnNumber,
	IteratorPlus is Iterator + 1,
	append(TempLine, [Element], TempLinePlus),
	changeColumn(Rest, TempLinePlus, NewElement, ColumnNumber, IteratorPlus, Result).
	
%%%%%%%%%%%%%%%%% Block used to Change to a new Tile using the Directions to the new tiles %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
changeTile(Board, [X, Y], [TilePlayer, TileDirection], ResultBoard):-
	TileDirection > -1, TileDirection < 10,
	getLine(Board, TargetLine, Y),
	changeColumn(TargetLine, [TilePlayer, TileDirection], X, ResultLine),
	changeLine(Board, ResultLine, Y, ResultBoard).

%%%%%%%%%%%%%%%%%% Switch the X and Y coordinates based on the Direction, so we can check for valid moves%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switchTileCoordinate(Direction, [X, Y], [NewX, NewY]):-
	Direction == 1,
	NewY is Y - 1, NewX is X - 1.
switchTileCoordinate(Direction, [X, Y], [NewX, NewY]):-
	Direction == 2,
	NewY is Y - 1, NewX is X.
switchTileCoordinate(Direction, [X, Y], [NewX, NewY]):-
	Direction == 3,
	NewY is Y - 1, NewX is X + 1.
switchTileCoordinate(Direction, [X, Y], [NewX, NewY]):-
	Direction == 4,
	NewY is Y, NewX is X - 1.
switchTileCoordinate(Direction, [X, Y], [NewX, NewY]):-
	Direction == 0,
	NewY is Y, NewX is X.
switchTileCoordinate(Direction, [X, Y], [NewX, NewY]):-
	Direction == 5,
	NewY is Y, NewX is X.
switchTileCoordinate(Direction, [X, Y], [NewX, NewY]):-
	Direction == 6,
	NewY is Y, NewX is X + 1.
switchTileCoordinate(Direction, [X, Y], [NewX, NewY]):-
	Direction == 7,
	NewY is Y + 1, NewX is X - 1.
switchTileCoordinate(Direction, [X, Y], [NewX, NewY]):-
	Direction == 8,
	NewY is Y + 1, NewX is X.
switchTileCoordinate(Direction, [X, Y], [NewX, NewY]):-
	Direction == 9,
	NewY is Y + 1, NewX is X + 1.