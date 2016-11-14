
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