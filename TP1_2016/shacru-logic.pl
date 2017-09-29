
%%%%%%%%%%%%%%%%%%%%Checks if moving a player's piece in the Direction is a valid move by using switchTileCoordinate and getTile to check the next position%%%%%%%%%%%%%%%%%%%

validMove(Board, Player, [_X, _Y], Direction):- 
	switchTileCoordinate(Direction, [_X, _Y], [NextX, NextY]),
	NextX > 0, NextY > 0,
	NextX < 10, NextY < 10,
	% Used to make sure its within bounds,
	getTile(Board, [NextTilePlayer, NextTileDirection], [NextX, NextY]),!,
	% Gets the next tile acording to the direction, 
	(NextTilePlayer =:= Player ; NextTilePlayer =:= 0), 
	% The next tile must belong to the player or be empty, checks arithmetically
	NextTileDirection =:= 0. 
	%The next tile must not have any other piece.


getValidMoves(Board, Player, [X, Y], Result):- 
	Y > 0, X > 0,
	Y < 10, X < 10,
	getValidMoves(Board, Player, [X, Y], [], 1, Result).

getValidMoves(_Board, _Player, [_X, _Y], DirectionsList, 10, Result):- %Ends if the Counter reaches 10.
	Result = DirectionsList.
	
getValidMoves(Board, Player, [X, Y], DirectionsList, Counter, Result):- % Counter is the directions
	NewCounter is Counter + 1,
	\+validMove(Board, Player, [X, Y], Counter),  %negation by failure
	getValidMoves(Board, Player, [X, Y], DirectionsList, NewCounter, Result).
	
getValidMoves(Board, Player, [X, Y], DirectionsList, Counter, Result):- 
	NewCounter is Counter + 1,
	validMove(Board, Player, [X, Y], Counter),
	append(DirectionsList, [Counter], NewDirectionsList),
	getValidMoves(Board, Player, [X, Y], NewDirectionsList, NewCounter, Result).

% Obtains the list of Directions that the piece can move in
getMovingDirections(Board, [X, Y], Directions):-
	getTile(Board, [TilePlayer, TileDirection], [X, Y]),
	TileDirection \= 0, %It must have a piece in the tile, doesnt unify with 0
	getValidMoves(Board, TilePlayer, [X, Y], ValidMovesList), %Get all the valid tiles around the [X, Y] tile
	possiblePositions(TileDirection, NearDirectionsList), %Get the near possible directions to move the piece
	list_to_set(NearDirectionsList, NearDirectionsSet),
	list_to_set(ValidMovesList, ValidMovesSet),
	intersection(NearDirectionsSet, ValidMovesSet, Directions). %Get the near possible directions to move the piece that are valid
	
%%%%%%%%%%%%%%%%% Test predicate to move Pieces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

movePieceTest(Board, [X, Y], Direction, NewBoard):-
	getTile(Board, [TilePlayer, TileDirection], [X, Y]),!, %get old Tile
	TilePlayer \= 0, !,						%if it is 0, then there is no piece
	TileDirection \= 0, TileDirection \= 5, !,%if it is 0 or 5, there is no new Direction
	getMovingDirections(Board, [X, Y], ValidDirections),!, %get valid directions to move
	memberchk(Direction, ValidDirections), %check if direction is a valid direction by using memberchck
	switchTileCoordinate(Direction, [X, Y], [NewX, NewY]), %Get the new Tile
	changeTile(Board, [NewX, NewY], [TilePlayer, Direction], TempBoard), %Place the marker and the piece in the new Tile
	setDirection(TempBoard, [X, Y], 0, NewBoard).

%%%%%%%%%%%%%%%% Piece Rotation and Area Checking %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
checkSectorChange([X, Y], [NewX, NewY]):-
	(X =:= 3, NewX =:= 4);
	(X =:= 4, NewX =:= 3);
	(X =:= 6, NewX =:= 7);
	(X =:= 7, NewX =:= 6);
	(Y =:= 3, NewY =:= 4);
	(Y =:= 4, NewY =:= 3);
	(Y =:= 6, NewY =:= 7);
	(Y =:= 7, NewY =:= 6).
	
%Returns a "boolean" to check if a piece has changed or not.
checkSectorChange([X, Y], Direction, HasChanged):-
	switchTileCoordinate(Direction, [X, Y], [ResX, ResY]),
	checkSectorChange([X, Y], [ResX, ResY]),
	HasChanged = 1.
checkSectorChange([X, Y], Direction, HasChanged):-
	switchTileCoordinate(Direction, [X, Y], [ResX, ResY]),
	\+checkSectorChange([X, Y], [ResX, ResY]),
	HasChanged = 0.

rotatePiece(Board, [X, Y], 1, NewBoard):- % CounterClockWise
	getTile(Board, [TilePlayer, TileDirection], [X, Y]),!, %get Tile
	write('Got tile'), nl,
	TilePlayer \= 0, !,						%if it is 0, then there is no piece
	TileDirection \= 0, TileDirection \= 5, !,%if it is 0 or 5, there is no piece
	possiblePositions(TileDirection, [CounterClockWise, _Same, _ClockWise]),
	setDirection(Board, [X, Y], CounterClockWise, NewBoard),
	write('Rotate Piece done'), nl.
	
rotatePiece(Board, [X, Y], 2, NewBoard):- % Same direction basicly doesnt do anything. (Stays the same)
	getTile(Board, [TilePlayer, TileDirection], [X, Y]),!, %get old Tile
	TilePlayer \= 0, !,						%if it is 0, then there is no piece
	TileDirection \= 0, TileDirection \= 5, !,%if it is 0 or 5, there is no piece
	possiblePositions(TileDirection, [_CounterClockWise, Same, _ClockWise]),
	setDirection(Board, [X, Y], Same, NewBoard).
	
rotatePiece(Board, [X, Y], 3, NewBoard):- % ClockWise
	getTile(Board, [TilePlayer, TileDirection], [X, Y]),!, %get old Tile
	TilePlayer \= 0, !,						%if it is 0, then there is no piece
	TileDirection \= 0, TileDirection \= 5, !,%if it is 0 or 5, there is no piece
	possiblePositions(TileDirection, [_CounterClockWise, _Same, ClockWise]),
	setDirection(Board, [X, Y], ClockWise, NewBoard).
	
rotatePiece(_, _, _, _):- fail .

%%%%%%%%%%%%%%%%%%%%%%%%%%% Checks if the next Tile has a marker, to be able to move in, in case its from the same player %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nextTileHasMarker(Board, [X,Y], Direction):-
	switchTileCoordinate(Direction, [X, Y], [NewX, NewY]),!,
	getTile(Board, [TilePlayer, _TileDirection], [NewX, NewY]),!,
	TilePlayer \= 0.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Used to get the player pieces%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	 

getPlayerPieces(Board, Player, Pieces, PiecesLength):-
	Player > 0, Player < 5,
	getPlayerPieces(Board, Player, 1, [], Pieces, 0, PiecesLength).
getPlayerPieces([], _, _, TempPieces, Pieces, TempPiecesLength, PiecesLength):-
	Pieces = TempPieces,
	PiecesLength = TempPiecesLength.
getPlayerPieces([Line | Rest], Player, ActualY, TempPieces, Pieces, TempPiecesLength, PiecesLength):-
	getPlayerPiecesLine(Line, Player, [1, ActualY], [], Pieces1, 0, PiecesLength1),
	ActualYPlus is ActualY + 1,
	TempPiecesLengthPlus is PiecesLength1 + TempPiecesLength,
	append(TempPieces, Pieces1, TempPiecesPlus),
	getPlayerPieces(Rest, Player, ActualYPlus, TempPiecesPlus, Pieces, TempPiecesLengthPlus, PiecesLength).

getPlayerPiecesLine([], _, _, TempPieces, Pieces, TempPiecesLength, PiecesLength):-
	Pieces = TempPieces,
	PiecesLength = TempPiecesLength.
getPlayerPiecesLine([[TilePlayer, _TileDirection] | Rest], Player, [ActualX, ActualY], TempPieces, Pieces, TempPiecesLength, PiecesLength):-
	TilePlayer \= Player,
	ActualXPlus is ActualX + 1,
	getPlayerPiecesLine(Rest, Player, [ActualXPlus, ActualY], TempPieces, Pieces, TempPiecesLength, PiecesLength).
getPlayerPiecesLine([[TilePlayer, _TileDirection] | Rest], Player, [ActualX, ActualY], TempPieces, Pieces, TempPiecesLength, PiecesLength):-
	TilePlayer =:= Player,
	append(TempPieces, [[ActualX, ActualY]], TempPiecesPlus),
	ActualXPlus is ActualX + 1,
	PiecesLengthPlus is TempPiecesLength + 1,
	getPlayerPiecesLine(Rest, Player, [ActualXPlus, ActualY], TempPiecesPlus, Pieces, PiecesLengthPlus, PiecesLength).

%%%%%%%%%%%%%%%%%% Check if a piece can move by checking if the getMovingDirections predicate returns %%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
pieceCanMove(Board, [X, Y]):-
	getMovingDirections(Board, [X, Y], Directions),
	!,
	Directions \= []. %If it is empty, the piece cant move to any valid tile


%%%%%%%%%%%%%% Predicates used to get the pieces the player can posibly move %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
getPlayerMovingPieces(Board, Player, Pieces, PiecesLength):- %Only return the pieces of the player that can move
	getPlayerPieces(Board, Player, AllPieces, _AllPiecesLength),
	getPlayerMovingPiecesAux(Board, AllPieces, Pieces, PiecesLength).
	
getPlayerMovingPiecesAux(Board, AllPieces, MovingPieces, MovingPiecesLength):-
	getPlayerMovingPiecesAux(Board, AllPieces, [], MovingPieces, 0, MovingPiecesLength).
	
getPlayerMovingPiecesAux(_Board, [], TempMovingPieces, MovingPieces, TempMovingPiecesLength, MovingPiecesLength):-
	MovingPieces = TempMovingPieces,
	MovingPiecesLength = TempMovingPiecesLength.
getPlayerMovingPiecesAux(Board, [Piece | Rest], TempMovingPieces, MovingPieces, TempMovingPiecesLength, MovingPiecesLength):-
	pieceCanMove(Board, Piece),
	append(TempMovingPieces, [Piece], TempMovingPiecesPlus),
	TempMovingPiecesLengthPlus is TempMovingPiecesLength + 1,
	getPlayerMovingPiecesAux(Board, Rest, TempMovingPiecesPlus, MovingPieces, TempMovingPiecesLengthPlus, MovingPiecesLength).
	
getPlayerMovingPiecesAux(Board, [Piece | Rest], TempMovingPieces, MovingPieces, TempMovingPiecesLength, MovingPiecesLength):-
	\+pieceCanMove(Board, Piece),
	getPlayerMovingPiecesAux(Board, Rest, TempMovingPieces, MovingPieces, TempMovingPiecesLength, MovingPiecesLength).