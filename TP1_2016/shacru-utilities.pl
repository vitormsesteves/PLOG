% -- Interface Outputs -- %

panelName:-  write('|-----------------------------------------------------|'), nl,
             write('|                      SHACRU                         |'), nl,
             write('|-----------------------------------------------------|'), nl,
             printBoard.

menu:- write('                      1. Play'), nl,
       write('                      2. Exit'), nl.

readChoice(Number):-
      Number > 2,
      write('  Try again and choose one of the correct options'),
      nl,
      start.
readChoice(1):- 
      game.
readChoice(2):- 
      write(' Play again later, Cya!').

askForRotation(Orientation):-
      write('Do you which to rotate your Piece?'),nl,
      write('1 - Anticlockwise; 2 - Dont Rotate ; 3 - Clockwise'), nl,
      read(OrientationTemp), nl,
      OrientationTemp > 0, OrientationTemp < 4,
      Orientation = OrientationTemp.

turn(Board, Player, NewBoard):-
      printBoard(Board),
      write('Player '), write(Player), write(' turn: '), nl,
      choosePiece(Board, Player, PieceChosen),
      moveAPiece(Board, PieceChosen, NewBoard1, Direction, HasChangedArea),
      write('Sector Change' ), write(HasChangedArea), nl,
      rotateAPiece(NewBoard1, PieceChosen, HasChangedArea, Direction, NewBoard),
      write('turn: Rotated piece'), nl .

gameCycle(Board, [[ActualPlayer, IsAbleToPlay] | RemainingPlayerList], Winner, FinalWinner):-
      Winner =:= 0,
      turn(Board, ActualPlayer, NewBoard),
      updatePlayerList(NewBoard, ActualPlayer, [[ActualPlayer, IsAbleToPlay] | RemainingPlayerList], NewPlayerList),
      write('gameCycle: updated player list'), nl,
      checkEndGameAux(NewPlayerList, NewWinner),
      gameCycle(NewBoard, NewPlayerList, NewWinner, FinalWinner).
gameCycle(Board, _, Winner, FinalWinner):-
      Winner \= 0,
      printBoard(Board).

createPlayerList(NumPlayers, PlayerList):- 
      NumPlayers > 1, NumPlayers < 5, 
      createPlayerList(NumPlayers, 1, [], PlayerList).
createPlayerList(NumPlayers, Iterator, TempList, PlayerList):-
      NumPlayers =:= Iterator,
      append(TempList, [[Iterator, 1]], PlayerList).
createPlayerList(NumPlayers, Iterator, TempList, PlayerList):-
      NumPlayers \= Iterator,
      IteratorPlus is Iterator + 1,
      append(TempList, [[Iterator, 1]], TempListPlus),
      createPlayerList(NumPlayers, IteratorPlus, TempListPlus, PlayerList).

updatePlayerList(Board, Player, [ActualPlayerElem | Rest], NewPlayerList):-
      getPlayerMovingPieces(Board, Player, _Pieces, PiecesLength),
      updatePlayerListAux(PiecesLength, [ActualPlayerElem | Rest], NewPlayerList). %Passes to the next player, and updates if he can move any piece
      
updatePlayerListAux(PiecesLength, [[PlayerNumber, _IsAbleToPlay] | Rest], NewPlayerList):-
      PiecesLength > 0,
      append(Rest, [[PlayerNumber, 1]], NewPlayerList).
updatePlayerListAux(PiecesLength, [[PlayerNumber, _IsAbleToPlay] | Rest], NewPlayerList):-
      PiecesLength =:= 0,
      write('Cant move more'), nl, 
      append(Rest, [[PlayerNumber, 0]], NewPlayerList).

game :-
      createBoard(NumPlayers, Board),
      createPlayerList(NumPlayers, PlayerList),
      gameCycle(Board, PlayerList, 0, FinalWinner),
      nl, nl.

moveAPiece(Board, [], NewBoard, _, HasChangedArea):- %In case the player chooses to pass the turn
      NewBoard = Board,
      HasChangedArea = 0.

moveAPiece(Board, [X, Y], NewBoard, Direction, HasChangedArea):- %No marker -> Increases score
      getTile(Board, [_, TileDirection], [X, Y]),
      TileDirection \= 0, %It must have a piece in the tile
      displayDirectionsToMove(Board, [X, Y]),
      read(Direction),
      checkSectorChange([X, Y], Direction, HasChangedArea),
      moveAPieceAux(Board, [X, Y], Direction, NewBoard).
      
moveAPieceAux(Board, [_X, _Y], 0, NewBoard):- %In case of pass
      NewBoard = Board.
moveAPieceAux(Board, [X, Y], Direction, NewBoard):- %No marker -> Increases score
      \+nextTileHasMarker(Board, [X,Y], Direction),
      write('movePieceAux: No Marker'), nl,
      movePiece(Board, [X, Y], Direction, NewBoardTemp), %Checks if no marker
      write('movePieceAux: movedPiece'), nl,
      NewBoard = NewBoardTemp.
moveAPieceAux(Board, [X, Y], Direction, NewBoard):-
      nextTileHasMarker(Board, [X,Y], Direction), %ChecksForMarker
      write('movePieceAux: Has Marker'), nl,
      movePiece(Board, [X, Y], Direction, NewBoardTemp), 
      write('movePieceAux: movedPiece'), nl,
      NewBoard = NewBoardTemp.

displayDirectionsToMove(Board, [X, Y]):-
      getMovingDirections(Board, [X, Y], Directions),
      write('Whats the next direction? '), nl,
      displayDirectionsToMoveAux(Directions).
      
displayDirectionsToMoveAux([]):-
      printDirection(0), write(' - '), write(0).
displayDirectionsToMoveAux([Direction | Rest]):-
      printDirection(Direction), write(' - '), write(Direction),nl,
      displayDirectionsToMoveAux(Rest).
      
rotateAPiece(Board, _, 0, _, NewBoard):-
      NewBoard = Board.
rotateAPiece(Board, Piece, 1, Direction, NewBoard):-
      printBoard(Board),
      switchTileCoordinate(Direction, Piece, NewPiece), %to get the new piece after moveAPiece
      askForRotation(Orientation),
      rotatePiece(Board, NewPiece, Orientation, NewBoard).

choosePiece(Board, Player, Piece):-
      getPlayerMovingPieces(Board, Player, Pieces, PiecesLength),
      write('Which piece do you want to move? '), nl,
      displayPiecesToChoose(Pieces),
      read(PieceChosen),
      PieceChosen > -1, PieceChosen < PiecesLength + 1,
      choosePieceAux(Pieces, PieceChosen, Piece).

choosePieceAux(_, 0, Piece):-
      Piece = [].
choosePieceAux([Piece | _Rest], 1, PieceChosen):-
      PieceChosen = Piece.
choosePieceAux([_Piece | Rest], DecreasingIndex, PieceChosen):-
            DecreasingIndex \= 1,
            DecreasingIndexMinus is DecreasingIndex - 1,
            choosePieceAux(Rest, DecreasingIndexMinus, PieceChosen).

displayPiecesToChoose(Pieces):- 
      displayPiecesToChoose(Pieces, 1).
displayPiecesToChoose([], 1):-
      write('0 - Pass'), nl .
displayPiecesToChoose([], _Iterator).
displayPiecesToChoose([Piece | Rest], Counter):-
      write(Counter), write(' - '), write(Piece), nl,
      NewCounter is Counter + 1,
      displayPiecesToChoose(Rest, NewCounter).

printBoard:-
      write('|'),
      printTop(9),nl,
      T=    [[[2, 0],[0, 0],[1, 0],[1, 2],[1, 2],[0, 0],[2, 0],[2, 0],[1, 3]],
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

showMovePiece([X, Y], Direction):-
      T=    [[[0, 0],[0, 0],[2, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
            [[0, 0],[1, 9],[2, 1],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
            [[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
            [[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
            [[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
            [[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
            [[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
            [[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
            [[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]]],
movePieceTest(T, [X, Y], Direction, NewT),
printBoard(NewT).

showDynamic:-
      write('|'),
      printTop(9),nl,
      T=    [[[2, 0],[0, 0],[1, 0],[1, 2],[1, 2],[0, 0],[2, 0],[2, 0],[1, 3]],
            [[0, 0],[2, 0],[1, 0],[1, 0],[1, 0],[2, 0],[2, 0],[1, 0],[2, 0]],
            [[0, 0],[2, 0],[1, 0],[1, 0],[1, 0],[2, 0],[2, 0],[1, 0],[2, 0]],
            [[0, 0],[2, 0],[1, 0],[0, 0],[1, 0],[2, 0],[2, 0],[1, 0],[2, 0]],
            [[1, 0],[1, 0],[2, 0],[1, 9],[2, 0],[1, 0],[2, 0],[1, 0],[2, 0]],
            [[2, 4],[2, 0],[1, 0],[2, 0],[2, 0],[1, 0],[1, 0],[2, 0],[2, 6]],
            [[0, 0],[0, 0],[2, 0],[1, 0],[1, 0],[2, 0],[1, 0],[2, 0],[2, 6]],
            [[0, 0],[0, 0],[2, 0],[1, 0],[1, 0],[1, 0],[2, 0],[1, 0],[2, 9]],
            [[0, 0],[0, 0],[1, 0],[2, 0],[2, 0],[2, 0],[2, 0],[0, 0],[1, 0]],
            [[0, 0],[0, 0],[1, 0],[2, 0],[2, 0],[2, 0],[2, 0],[0, 0],[1, 0]],
            [[0, 0],[0, 0],[1, 0],[2, 0],[2, 0],[2, 0],[2, 0],[0, 0],[1, 0]]],
      displayBoard(T, 1),
      write('|'),
      printTop(9),nl.
      
createBoard(2, Board):-
      Board = [[[2, 9],[0, 0],[1, 8],[0, 0],[0, 0],[0, 0],[2, 8],[0, 0],[0, 0]],
                  [[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
                  [[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
                  [[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
                  [[1, 6],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[2, 4]],
                  [[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
                  [[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
                  [[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]],
                  [[0, 0],[0, 0],[1, 2],[0, 0],[0, 0],[0, 0],[2, 2],[0, 0],[1, 1]]].