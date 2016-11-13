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


getLine(Board, Line, LineNumber):- getLine(Board, Line, LineNumber, 1). % Iterator = 1

getLine([], _, _, _):-
	write('Position non-existent, try choosing a LINE between 1 and 9'), nl, fail.

getLine([Line|_Rest], ResultLine, LineNumber, LineNumber):- % When Iterator = LineNumber
	ResultLine = Line.
getLine([_Line|Rest], ResultLine, LineNumber, Iterator):- % Iterates across the lines of the board
	IteratorPlus is Iterator + 1,
	getLine(Rest, ResultLine, LineNumber, IteratorPlus).


getLineElement(Line, Tile, ColumnNumber):- getLineElement(Line, Tile, ColumnNumber, 1).
getLineElement([], _, _, _):-
	write('Column not existent'), nl, fail.
getLineElement([Element|_Rest], Tile, ColumnNumber, ColumnNumber):-
	Tile = Element.
getLineElement([_Element|Rest], Tile, ColumnNumber, Iterator):-
	IteratorPlus is Iterator + 1,
	getLineElement(Rest, Tile, ColumnNumber, IteratorPlus).

	
getTile(Board, Tile, [X, Y]):-
	getLine(Board, Line, Y), !, % - Avoids redoing getLine
	getLineElement(Line, Tile, X),
	write(Tile), nl.

getDirection(Board, [X, Y], Direction):-
	getTile(Board, [_TilePlayer, TileDirection], [X, Y]),
	Direction = TileDirection.
	
setDirection(Board, [X, Y], Direction, NewBoard):-
	Direction > -1, Direction < 10,
	getTile(Board, [TilePlayer, _TileDirection], [X, Y]),
	changeTile(Board, [X, Y], [TilePlayer, Direction], NewBoard).
	
% -----------------------------------------------
% -----------------------------------------------	

validMove(Board, Player, [_X, _Y], Direction):- %Checks if moving a player's piece in the Direction is a valid move.
	%TODO getTile to get the Player color automatically???
	switchTileCoordinate(Direction, [_X, _Y], [NextX, NextY]),
	NextX > 0, NextY > 0,
	NextX < 10, NextY < 10,
	getTile(Board, [NextTilePlayer, NextTileDirection], [NextX, NextY]), % Gets the next tile acording to the direction given
	!, (NextTilePlayer =:= Player ; NextTilePlayer =:= 0), % The next tile must be the from the players color, or no color
	NextTileDirection =:= 0. % The next tile must not have any piece there
% jogadasValidas(Tabuleiro, Jogador, Peca, []).


getValidMoves(Board, Player, [X, Y], Result):- 
	Y > 0, X > 0,
	Y < 10, X < 10,
	getValidMoves(Board, Player, [X, Y], [], 1, Result).
getValidMoves(_Board, _Player, [_X, _Y], DirectionsList, 10, Result):- %Ending condition (Iterator == 10)
	Result = DirectionsList.
	
getValidMoves(Board, Player, [X, Y], DirectionsList, Iterator, Result):- % Iterator is the directions
	IteratorPlus is Iterator + 1,
	\+validMove(Board, Player, [X, Y], Iterator),
	getValidMoves(Board, Player, [X, Y], DirectionsList, IteratorPlus, Result).
	
getValidMoves(Board, Player, [X, Y], DirectionsList, Iterator, Result):- % Iterator is the directions
	IteratorPlus is Iterator + 1,
	validMove(Board, Player, [X, Y], Iterator),
	append(DirectionsList, [Iterator], NewDirectionsList),
	getValidMoves(Board, Player, [X, Y], NewDirectionsList, IteratorPlus, Result).

% Obtains the list of Directions that the piece can move in
getMovingDirections(Board, [X, Y], Directions):-
	getTile(Board, [TilePlayer, TileDirection], [X, Y]),
	TileDirection \= 0, %It must have a piece in the tile
	getValidMoves(Board, TilePlayer, [X, Y], ValidMovesList), %Get all the valid tiles around the [X, Y] tile
	possiblePositions(TileDirection, NearDirectionsList), %Get the near possible directions to move the piece
	list_to_set(NearDirectionsList, NearDirectionsSet),
	list_to_set(ValidMovesList, ValidMovesSet),
	intersection(NearDirectionsSet, ValidMovesSet, Directions). %Get the near possible directions to move the piece that are valid
	
% -----------------------------------------------
% -----------------------------------------------
changeLine(Board, NewLine, LineNumber, Result):- 
	length(NewLine, 9),
	LineNumber < 10,
	LineNumber > 0,
	changeLine(Board, [], LineNumber, NewLine, 1, Result).
changeLine(RemainderOfBoard, NewBoard, LineNumber, _, Iterator, Result):-
	Iterator > LineNumber,
	LineNumber < 10,
	append(NewBoard, RemainderOfBoard, Result).
changeLine([Line | Rest], NewBoard, LineNumber, NewLine, Iterator, Result):-
	Iterator < LineNumber,
	LineNumber > 0,
	IteratorPlus is Iterator + 1,
	append(NewBoard, [Line], NewBoardPlus),
	changeLine(Rest, NewBoardPlus, LineNumber, NewLine, IteratorPlus, Result).
changeLine([_Line | Rest], NewBoard, LineNumber, NewLine, Iterator, Result):-
	LineNumber =:= Iterator,
	IteratorPlus is Iterator + 1,
	append(NewBoard, [NewLine], NewBoardPlus), %Adds line to the NewBoard
	changeLine(Rest, NewBoardPlus, LineNumber, NewLine, IteratorPlus, Result).

	
changeElement(Line, NewElement, ColumnNumber, Result):-
	length(NewElement, 2),
	ColumnNumber > 0,
	ColumnNumber < 10,
	changeElement(Line, [], NewElement, ColumnNumber, 1, Result).
changeElement([_Element | Rest], TempLine, NewElement, ColumnNumber, Iterator, Result):-
	Iterator =:= ColumnNumber,
	append(TempLine, [NewElement], TempLinePlus),
	append(TempLinePlus, Rest, Result).
changeElement([Element | Rest], TempLine, NewElement, ColumnNumber, Iterator, Result):-
	Iterator < ColumnNumber,
	IteratorPlus is Iterator + 1,
	append(TempLine, [Element], TempLinePlus),
	changeElement(Rest, TempLinePlus, NewElement, ColumnNumber, IteratorPlus, Result).
	
	
changeTile(Board, [X, Y], [TilePlayer, TileDirection], ResultBoard):-
	TileDirection > -1, TileDirection < 10,
	getLine(Board, TargetLine, Y), % Gets line to change
	changeElement(TargetLine, [TilePlayer, TileDirection], X, ResultLine), %Changes the line
	changeLine(Board, ResultLine, Y, ResultBoard). %Changes the board


movePiece(Board, [X, Y], Direction, NewBoard):-
	getTile(Board, [TilePlayer, TileDirection], [X, Y]),!, %get old Tile
	TilePlayer \= 0, !,						%if it is 0, then there is no piece
	TileDirection \= 0, TileDirection \= 5, !,%if it is 0 or 5, there is no piece
	getMovingDirections(Board, [X, Y], ValidDirections),!, %get valid directions to move
	memberchk(Direction, ValidDirections), %check if direction is a valid direction
	switchTileCoordinate(Direction, [X, Y], [NewX, NewY]), %Get the new Tile
	changeTile(Board, [NewX, NewY], [TilePlayer, Direction], TempBoard), %Place the marker and the piece in the new Tile
	setDirection(TempBoard, [X, Y], 0, NewBoard).