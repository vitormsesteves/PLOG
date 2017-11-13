

draw_top_left_coner           :-write('╔').
draw_top_right_coner          :-write('╗').
draw_top_separator            :-write('╦').

draw_center_left_separator    :-write('╠').
draw_center_right_separator   :-write('╣').
draw_center_middle_separator  :-write('╬').

draw_bottom_left_coner        :-write('╚').
draw_bottom_right_coner       :-write('╝').
draw_bottom_separator         :-write('╩').

draw_horizontal_segment       :-write('═').
draw_vertical_segment         :-write('║').

draw_avaliable_move           :-write('●').
draw_unavaliable_move         :-write('○').

draw_crater_piece			  :-write('C').
draw_red_piece                :-write('R').
draw_yellow_piece             :-write('Y').



fill_row(0, Row, NewColumn, _)   :-
	NewColumn = [Row].

fill_row(Dimension, Row, NewColumn, Element)   :-
	append(Row,[Element], New),
	D is Dimension-1,
	fill_row(D, New, NewColumn, ' ').

create_row(Dimension, Row):-
	fill_row(Dimension,[], Row, ' ').



fill_board(0, _, Board, NewBoard):-
	NewBoard = Board.

fill_board(Dimension, Row, Board, NewBoard)   :-
	append(Board,Row, New),
	D is Dimension-1,
	fill_board(D, Row, New, NewBoard).


create_board(Dimension, Board) :-
	create_row(Dimension, Row),
	fill_board(Dimension, Row, [], Board).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%  Draw top line  %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

draw_column_numeration(Dimension, Dimension).
draw_column_numeration(Current_Index, Dimension):-
	write('     '),
	write(Current_Index),
	write('    '),
	Index is Current_Index+1,
	draw_column_numeration(Index, Dimension).
draw_top_line_first_cell:-
	draw_top_left_coner,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_top_separator.

draw_top_line_intermediate_cells(0).

draw_top_line_intermediate_cells(Dimension):-
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_top_separator,
	D is Dimension-1,
	draw_top_line_intermediate_cells(D).

draw_top_line_last_cell:-
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_top_right_coner.

draw_top_line(Dimension):-
	write(' '),
	draw_column_numeration(0, Dimension),
	nl,
	write(' '),
	draw_top_line_first_cell,
	draw_top_line_intermediate_cells(Dimension-2),
	draw_top_line_last_cell,
	nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%  Draw line of cells  %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

draw_row(Row, Row_Number):-
	write(' '),
	draw_row_1(Row),
	nl,
	put(Row_Number),
	draw_row_2(Row),
	nl,
	write(' '),
	draw_row_3(Row),
	nl.


draw_row_1([]):-
	draw_vertical_segment.
draw_row_1([ActualCell|NextCells]):-
	draw_vertical_segment,
	draw_cell_1(ActualCell),
	draw_row_1(NextCells).

draw_row_2([]):-
	draw_vertical_segment.	
draw_row_2([ActualCell|NextCells]):-
	draw_vertical_segment,
	draw_cell_2(ActualCell),
	draw_row_2(NextCells).

draw_row_3([]):-
	draw_vertical_segment.	
draw_row_3([ActualCell|NextCells]):-
	draw_vertical_segment,
	draw_cell_3(ActualCell),
	draw_row_3(NextCells).


draw_cell_1(Cell):-
	proper_length(Cell, 9),
	draw_piece_1(Cell, ' ').
draw_cell_1(Cell):-
	Cell == ' ',
	write('         ').

draw_cell_2(Cell):-
	proper_length(Cell, 9),
	draw_piece_2(Cell, ' ').
draw_cell_2(Cell):-
	Cell == ' ',
	write('         ').
draw_cell_2(Cell):-
	Cell == 'xR',
	write('▒▒▒▒▒▒▒▒▒').
draw_cell_2(Cell):-
	Cell == 'xY',
	write('░░░░░░░░░').

draw_cell_3(Cell):-
	proper_length(Cell, 9),
	draw_piece_3(Cell, ' ').
draw_cell_3(Cell):-
	Cell == ' ',
	write('         ').

%%%%%%%%%%%%%%  Draw piece  %%%%%%%%%%%%%%%%%

draw_avaliable_move(0, CellBackground):-
	write(CellBackground),
	draw_unavaliable_move,
	write(CellBackground).
draw_avaliable_move(1, CellBackground):-
	write(CellBackground),
	draw_avaliable_move,
	write(CellBackground).

draw_piece('C', CellBackground) :-
	write(CellBackground),
	draw_crater_piece,
	write(CellBackground).

draw_piece('R', CellBackground):-
	write(CellBackground),
	draw_red_piece,
	write(CellBackground).

draw_piece('Y', CellBackground):-
	write(CellBackground),
	draw_yellow_piece,
	write(CellBackground).

draw_piece_1(Cell, CellBackground):-
	nth0(0,Cell,Up_left_value),
	draw_avaliable_move(Up_left_value, CellBackground),

	nth0(1,Cell,Up_value),
	draw_avaliable_move(Up_value, CellBackground),

	nth0(2,Cell,Up_right_value),
	draw_avaliable_move(Up_right_value, CellBackground).

draw_piece_2(Cell, CellBackground):-
	nth0(3,Cell,Left_value),
	draw_avaliable_move(Left_value, CellBackground),

	nth0(4,Cell,Piece_value),
	draw_piece(Piece_value, CellBackground),

	nth0(5,Cell,Right_value),
	draw_avaliable_move(Right_value, CellBackground).

draw_piece_3(Cell, CellBackground):-
	nth0(6,Cell,Bottom_left_value),
	draw_avaliable_move(Bottom_left_value, CellBackground),

	nth0(7,Cell,Bottom_value),
	draw_avaliable_move(Bottom_value, CellBackground),

	nth0(8,Cell,Bottom_right_value),
	draw_avaliable_move(Bottom_right_value, CellBackground).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  Draw separator  %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

draw_separator_line(Dimension) :-
	write(' '),
	draw_center_left_separator,
	draw_separator(Dimension),
	draw_center_right_separator,
	nl.

draw_separator(1):-
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment.
draw_separator(Dimension):-
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_center_middle_separator,
	D is Dimension-1,
	draw_separator(D).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%  Draw bottom line  %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

draw_bottom_line_first_cell:-
	draw_bottom_left_coner,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_bottom_separator.

draw_bottom_line_intermediate_cells(0).

draw_bottom_line_intermediate_cells(Dimension):-
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_bottom_separator,
	D is Dimension-1,
	draw_bottom_line_intermediate_cells(D).

draw_bottom_line_last_cell:-
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_horizontal_segment,
	draw_bottom_right_coner.

draw_bottom_line(Dimension):-
	write(' '),
	draw_bottom_line_first_cell,
	draw_bottom_line_intermediate_cells(Dimension-2),
	draw_bottom_line_last_cell,
	nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%  Draw board  %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

draw_board(Board):-
	length(Board,Dimension),
	draw_top_line(Dimension),
	draw_board_row(Board, 97, Dimension),
	draw_bottom_line(Dimension).

draw_board_row([CurrentRow|[]], Row_Number, _):-
	draw_row(CurrentRow, Row_Number).
draw_board_row([CurrentRow|NextRows], Row_Number, Dimension):-
	draw_row(CurrentRow, Row_Number),
	draw_separator_line(Dimension),
	R is Row_Number+1,
	draw_board_row(NextRows, R, Dimension).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%  Init board  %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

initialize_board(Dimension, Board):-
	create_board(Dimension, Board).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  Insert pieces  %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

insert_piece(Board, Row_Index, Column_Index, Element, NewBoard):-
	insert_element(Board, Row_Index, Column_Index, Element, NewBoard).

insert_piece_T(Board,Row_Index,Column_Index,Element,NewBoard):-
	%%0%%

	insert_element(Board,Row_Index,Column_Index,Element,TempBoard),
	
	%%1%%
	Column1 is Column_Index + 1,
	Row1 	is Row_Index + 1, 
	
	insert_element(TempBoard,Row_Index,Column1,Element,TempBoard1),
	insert_element(TempBoard1,Row1,Column1,Element,TempBoard2),
	%%2%%

	Column2 is Column_Index +2, 
	Row2 is Row_Index + 2, 

	insert_element(TempBoard2,Row_Index,Column2,Element,TempBoard3),
	insert_element(TempBoard3,Row2,Column1,Element,NewBoard).

insert_piece_C(Board,Row_Index,Column_Index,Element,NewBoard):-
	%%0%%

	insert_element(Board,Row_Index,Column_Index,Element,TempBoard),
	
	%%1%%
	Column1 is Column_Index + 1,
	Row1 	is Row_Index + 1, 
	
	insert_element(TempBoard,Row_Index,Column1,Element,TempBoard1),
	insert_element(TempBoard1,Row1,Column_Index,Element,TempBoard2),
	%%2%%

	Column2 is Column_Index +2, 
	insert_element(TempBoard2,Row_Index,Column2,Element,TempBoard3),
	insert_element(TempBoard3,Row1,Column2,Element,NewBoard).

remove_piece(Board, Row_Index, Column_Index, NewBoard):-
	nth0(Row_Index, Board, TEMP_Row), 
	nth0(Column_Index, TEMP_Row, Element_To_Remove), 

	proper_length(Element_To_Remove, 2),

	[Cell|_] = Element_To_Remove,

	nth0(Column_Index, TEMP_Row, Element_To_Remove, TEMP_Row_2), 
	nth0(Column_Index, New_Row, Cell, TEMP_Row_2),
	
	nth0(Row_Index, Board, TEMP_Row, TEMP_Board),
	nth0(Row_Index, NewBoard, New_Row, TEMP_Board).

remove_piece(Board, Row_Index, Column_Index, NewBoard):-
	nth0(Row_Index, Board, TEMP_Row), 
	nth0(Column_Index, TEMP_Row, Element_To_Remove), 
	
	nth0(Column_Index, TEMP_Row, Element_To_Remove, TEMP_Row_2), 
	nth0(Column_Index, New_Row, ' ', TEMP_Row_2),
	
	nth0(Row_Index, Board, TEMP_Row, TEMP_Board),
	nth0(Row_Index, NewBoard, New_Row, TEMP_Board).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%  Insert element  %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

insert_element(Board, Row_Index, Column_Index, Element, NewBoard):-
	nth0(Row_Index, Board, TEMP_Row), 
	nth0(Column_Index, TEMP_Row, Element_To_Remove), 
	nth0(Column_Index, TEMP_Row, Element_To_Remove, TEMP_Row_2), 
	nth0(Column_Index, New_Row, Element, TEMP_Row_2),
	
	nth0(Row_Index, Board, TEMP_Row, TEMP_Board),
	nth0(Row_Index, NewBoard, New_Row, TEMP_Board).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  Change pieces  %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

change_position(Board, Row_Initial, Column_Initial, Row_Final, Column_Final, NewBoard, Return):-
	nth0(Row_Initial, Board, TEMP_Row), 
	nth0(Column_Initial, TEMP_Row, Cell),
	proper_length(Cell,2),
	nth0(0,Cell,EndCell),
	nth0(1,Cell,Piece),

	hover_piece(Board, Row_Initial, Column_Initial, Row_Final, Column_Final, Temp_Board0, Return),

	insert_element(Temp_Board0, Row_Final, Column_Final, Piece, Temp_Board),

	insert_element(Temp_Board, Row_Initial, Column_Initial, EndCell, NewBoard).

change_position(Board, Row_Initial, Column_Initial, Row_Final, Column_Final, NewBoard, Return):-
	nth0(Row_Initial, Board, TEMP_Row), 
	nth0(Column_Initial, TEMP_Row, Cell),
	proper_length(Cell,9),

	hover_piece(Board, Row_Initial, Column_Initial, Row_Final, Column_Final, Temp_Board0, Return),

	insert_element(Temp_Board0, Row_Final, Column_Final, Cell, Temp_Board),

	insert_element(Temp_Board, Row_Initial, Column_Initial, ' ', NewBoard).

hover_piece(Board, Row_Initial, Column_Initial, Row_Final, Column_Final, NewBoard, Return):-
	Incremento_R is Row_Final-Row_Initial,
	Incremento_C is Column_Final-Column_Initial,

	\+ Incremento_R==0,
	\+ Incremento_C==0,

	0 is mod(Incremento_R, 2),
	0 is mod(Incremento_C, 2),

	Piece_Between_Row is Row_Initial+Incremento_R/2,
	Piece_Between_Column is Column_Initial+Incremento_C/2,
	eat_piece(Board, Piece_Between_Row, Piece_Between_Column, NewBoard),
	Return = 1.

hover_piece(Board, Row_Initial, Column_Initial, Row_Final, _, NewBoard, Return):-
	Incremento_R is Row_Final-Row_Initial,

	\+ Incremento_R==0,
	0 is mod(Incremento_R, 2),

	Piece_Between_Row is Row_Initial+Incremento_R/2,
	eat_piece(Board, Piece_Between_Row, Column_Initial, NewBoard),
	Return = 1.

hover_piece(Board, Row_Initial, Column_Initial, _, Column_Final, NewBoard, Return):-
	Incremento_C is Column_Final-Column_Initial,

	\+ Incremento_C==0,
	0 is mod(Incremento_C, 2),

	Piece_Between_Column is Column_Initial+Incremento_C/2,
	eat_piece(Board, Row_Initial, Piece_Between_Column, NewBoard),
	Return = 1.
hover_piece(Board, _, _, _, _, NewBoard, Return):-
	NewBoard = Board,
	Return = 0.

eat_piece(Board, Piece_Between_Row, Piece_Between_Column, NewBoard):-
	nl,
	Char_Row is Piece_Between_Row+97,
	write('    The piece '), put(Char_Row), write(Piece_Between_Column), write(' are betwenn initial an end position:'),
	nl,
	write('		1 - Leave'), nl,
	write('		2 - Eat  '), nl,
	read(Option),
	nl,
	resolve_eat_option(Board, Piece_Between_Row, Piece_Between_Column, Option, NewBoard).

resolve_eat_option(Board, _, _, 1, NewBoard):-
	NewBoard = Board.

resolve_eat_option(Board, Piece_Between_Row, Piece_Between_Column, 2, NewBoard):-
	remove_piece(Board, Piece_Between_Row, Piece_Between_Column, NewBoard).

resolve_eat_option(Board, Piece_Between_Row, Piece_Between_Column, _, NewBoard):-
	eat_piece(Board, Piece_Between_Row, Piece_Between_Column, NewBoard).


is_piece(Board, Row_Index, Column_Index):-
	nth0(Row_Index, Board, Element),
	nth0(Column_Index, Element, List),
	proper_length(List,9).

is_piece(Board, Row_Index, Column_Index):-
	nth0(Row_Index, Board, Element),
	nth0(Column_Index, Element, List),
	proper_length(List,2).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%  Pieces manipulation  %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

get_piece(Board, Row_Index, Column_Index, Piece, NewBoard):-
	nth0(Row_Index, Board, TEMP_Row), 
	nth0(Column_Index, TEMP_Row, Piece),

	proper_length(Piece,9),

	nth0(Column_Index, TEMP_Row, Piece, TEMP_Row_2),
	nth0(Column_Index, New_Row, ' ', TEMP_Row_2),
	
	nth0(Row_Index, Board, TEMP_Row, TEMP_Board),
	nth0(Row_Index, NewBoard, New_Row, TEMP_Board).

get_piece(Board, Row_Index, Column_Index, Piece, NewBoard):-
	nth0(Row_Index, Board, TEMP_Row), 
	nth0(Column_Index, TEMP_Row, Cell),

	nth0(1, Cell, Piece),

	proper_length(Piece,9),

	nth0(0, Cell, Type),

	nth0(Column_Index, TEMP_Row, Cell, TEMP_Row_2), 
	nth0(Column_Index, New_Row, Type, TEMP_Row_2),
	
	nth0(Row_Index, Board, TEMP_Row, TEMP_Board),
	nth0(Row_Index, NewBoard, New_Row, TEMP_Board).

piece_type(Board, Row_Index, Column_Index, Type):-
	nth0(Row_Index, Board, TEMP_Row), 
	nth0(Column_Index, TEMP_Row, Element),

	nth0(4, Element, Type).

piece_type(Board, Row_Index, Column_Index, Type):-
	nth0(Row_Index, Board, TEMP_Row), 
	nth0(Column_Index, TEMP_Row, Element),

	nth0(1, Element, Piece),
	nth0(4, Piece, Type).

piece_directions_avaliable(Board, Row_Index, Column_Index, Counter):-
	get_piece(Board, Row_Index, Column_Index, Piece, _),
	nth0(0, Piece, Flag0),
	nth0(1, Piece, Flag1),
	nth0(2, Piece, Flag2),
	nth0(3, Piece, Flag3),
	nth0(5, Piece, Flag5),
	nth0(6, Piece, Flag6),
	nth0(7, Piece, Flag7),
	nth0(8, Piece, Flag8),
	Counter is Flag0 + Flag1 + Flag2 + Flag3 + Flag5 + Flag6 +Flag7 + Flag8.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%   Menu   %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

read_crater(Board, Piece_Row_Index,Piece_Column_Index,NewBoard):-
	write('Select a spot to place the crater(input type ex: b4) :'),
	read(Piece),

	name(Piece,Piece_Str),

	nth0(0, Piece_Str, Temp_R),
	nth0(1, Piece_Str, Temp_C),	

	Piece_Row_Index is Temp_R - 97,
	Piece_Column_Index is Temp_C - 48,
	nl,
	write(Piece_Column_Index),
	write(Piece_Row_Index),
	insert_piece(Board,Piece_Row_Index,Piece_Column_Index,[0,0,0,0,'C',0,0,0,0],NewBoard).

read_crater(Board, Piece_Row_Index,Piece_Column_Index,NewBoard):-
	print_warning('An error ocurred.. Board dont have your piece in that position.', 63),
	nl,
	read_crater(Board, Piece_Row_Index, Piece_Column_Index,NewBoard).

read_piece(Board, Piece_Row_Index, Piece_Column_Index, Type):-
	write('Select a piece to move (input type ex: b4.): '),
	read(Piece),

	name(Piece, Piece_Str),
	
	nth0(0, Piece_Str, Temp_R),
	nth0(1, Piece_Str, Temp_C),	

	Piece_Row_Index is Temp_R - 97,
	Piece_Column_Index is Temp_C - 48,

	is_piece(Board, Piece_Row_Index, Piece_Column_Index),
	piece_type(Board, Piece_Row_Index, Piece_Column_Index, Type).

read_piece(Board, Piece_Row_Index, Piece_Column_Index, Type):-
	print_warning('An error ocurred.. Board dont have your piece in that position.', 63),
	nl,
	read_piece(Board, Piece_Row_Index, Piece_Column_Index, Type).


piece_options(Board, Piece_Row_Index, Piece_Column_Index, Player_Type, NewBoard):-
	Char_Row is Piece_Row_Index+97,
	write('    Piece '), put(Char_Row), write(Piece_Column_Index), write(' options'),
	nl,
	nl,
	write('	1 - Move'),
	nl,
	write('	2 - Add direction'),
	nl,
	write('	3 - Cancel'),
	nl, nl,
	write('	Select an option(input type ex: 1.): '),
	read(Option),
	resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Player_Type, NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Player_Type, NewBoard):-
	Option == 1,
	get_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, List_Of_Moves),
	proper_length(List_Of_Moves, Length),
	Length > 0,
	piece_movement_menu(Board, Piece_Row_Index, Piece_Column_Index, Player_Type, NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Player_Type, NewBoard):-
	Option == 2,
	piece_direction_menu(Board, Piece_Row_Index, Piece_Column_Index, Player_Type, NewBoard).

resolve_piece_option(Board, _, _, Option, Player_Type, NewBoard):-
	Option == 3,
	cancel_option(Board, Player_Type, NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, 1, Player_Type, NewBoard):-
	print_warning('An error occurred.. This piece dont have posible moves.', 55),
	nl,
	piece_options(Board, Piece_Row_Index, Piece_Column_Index, Player_Type, NewBoard).

cancel_option(Board, Player_Type, NewBoard):-
	draw_board(Board),
	Player_Type == 'Y',
	player_yellow_turn(Board, NewBoard).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%     Movement Menu     %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

piece_movement_menu(Board, Row_Index, Column_Index, Player_Type, NewBoard):-
	nl,
	Char_Row is Row_Index+97,
	write('    Piece '), put(Char_Row), write(Column_Index), write(' have the next posible moves'),
	nl,
	nl,
	list_possible_moves(Board, Row_Index, Column_Index),
	nl,
	read_target_position(Board, Row_Index, Column_Index, Row_Final,Column_Final, Player_Type, NewBoard),
	change_position(Board, Row_Index, Column_Index, Row_Final, Column_Final, Temp_Board, Return),
	play_again(Temp_Board, Row_Final, Column_Final, Player_Type, NewBoard, Return).

piece_movement_menu(Board, Row_Index, Column_Index, Player_Type, NewBoard):-
	print_warning('An error occurred.. You cant move that piece.', 45),
	nl,
	piece_options(Board, Row_Index, Column_Index, Player_Type, NewBoard).

play_again(Board, _, _, _, NewBoard, 0):-
	NewBoard = Board.
play_again(Board, Row_Index, Column_Index, Player_Type, NewBoard, 1):-
	get_possible_moves(Board, Row_Index, Column_Index, List_Of_Moves),
	proper_length(List_Of_Moves, Length),
	Length > 0,
	draw_board(Board),
	piece_movement_menu(Board, Row_Index, Column_Index, Player_Type, NewBoard).
play_again(Board, _, _, _, NewBoard, _):-
	NewBoard = Board.

read_target_position(Board, Row_Index, Column_Index, Final_Row_Index, Final_Column_Index, _, _):-
	write('	Select a position to move (input type: d1.): '),
	read(Piece),

	name(Piece, Piece_Str),
	
	nth0(0, Piece_Str, Temp_R),
	nth0(1, Piece_Str, Temp_C),	

	Final_Row_Index is Temp_R - 97,
	Final_Column_Index is Temp_C - 48,
	nl,
	valid_move(Board, Row_Index, Column_Index, Final_Row_Index, Final_Column_Index).

read_target_position(Board, Row_Index, Column_Index, _, _, Player_Type, NewBoard):-
	print_warning('An error ocurred.. You cant move the piece to that position.', 60),
	nl,
	write('Enter a x to continue: '),
	read(_),
	draw_board(Board),
	piece_options(Board, Row_Index, Column_Index, Player_Type, NewBoard).

list_possible_moves(Board, Row_Index, Column_Index):-
	get_possible_moves(Board, Row_Index, Column_Index, List_Of_Moves),
	print_moves(List_Of_Moves).

print_moves([]).
print_moves([Current_Move|Next_Moves]):-
	nth0(0, Current_Move, Temp_R),
	nth0(1, Current_Move, Temp_C),

	R_Char is Temp_R + 97,

	write('	'), put(R_Char), write(Temp_C),
	nl,
	print_moves(Next_Moves).

valid_move(Board, Piece_Row_Index, Piece_Column_Index, Final_Row_Index, Final_Column_Index):-
	get_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, List_Of_Moves),
	search_move(List_Of_Moves, Final_Row_Index, Final_Column_Index, 0).

search_move(_, _, _, 1).
search_move([Current_Move|_], Final_Row_Index, Final_Column_Index, _):-
	nth0(0,Current_Move, Final_Row_Index),
	nth0(1,Current_Move, Final_Column_Index),
	search_move(_, _, _, 1).
search_move([_|Next_Moves], Final_Row_Index, Final_Column_Index, found):-
	search_move(Next_Moves, Final_Row_Index, Final_Column_Index, found).

get_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, List_Of_Moves):-
	get_piece(Board, Piece_Row_Index, Piece_Column_Index, Piece, _),
	up_left_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, [], New_List_Of_Moves),
	up_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, New_List_Of_Moves, New_List_Of_Moves2),
	up_right_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, New_List_Of_Moves2, New_List_Of_Moves3),
	left_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, New_List_Of_Moves3, New_List_Of_Moves4),
	right_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, New_List_Of_Moves4, New_List_Of_Moves5),
	down_left_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, New_List_Of_Moves5, New_List_Of_Moves6),
	down_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, New_List_Of_Moves6, New_List_Of_Moves7),
	down_right_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, New_List_Of_Moves7, List_Of_Moves).

up_left_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(0,Piece,1),
	R_index is Piece_Row_Index-1,
	C_index is Piece_Column_Index-1,
	add_move(Board, R_index, C_index, List_Of_Moves, New_List_Of_Moves).
up_left_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(0,Piece,1),
	R_index is Piece_Row_Index-2,
	C_index is Piece_Column_Index-2,
	add_move(Board, R_index, C_index, List_Of_Moves, New_List_Of_Moves).
up_left_possible_moves(_, _, _, _, List_Of_Moves, New_List_Of_Moves):-
	New_List_Of_Moves = List_Of_Moves.

up_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(1,Piece,1),
	R_index is Piece_Row_Index-1,
	add_move(Board, R_index, Piece_Column_Index, List_Of_Moves, New_List_Of_Moves).
up_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(1,Piece,1),
	R_index is Piece_Row_Index-2,
	add_move(Board, R_index, Piece_Column_Index, List_Of_Moves, New_List_Of_Moves).
up_possible_moves(_, _, _, _, List_Of_Moves, New_List_Of_Moves):-
	New_List_Of_Moves = List_Of_Moves.

up_right_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(2,Piece,1),
	R_index is Piece_Row_Index-1,
	C_index is Piece_Column_Index+1,
	add_move(Board, R_index, C_index, List_Of_Moves, New_List_Of_Moves).
up_right_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(2,Piece,1),
	R_index is Piece_Row_Index-2,
	C_index is Piece_Column_Index+2,
	add_move(Board, R_index, C_index, List_Of_Moves, New_List_Of_Moves).
up_right_possible_moves(_, _, _, _, List_Of_Moves, New_List_Of_Moves):-
	New_List_Of_Moves = List_Of_Moves.

left_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(3,Piece,1),
	C_index is Piece_Column_Index-1,
	add_move(Board, Piece_Row_Index, C_index, List_Of_Moves, New_List_Of_Moves).
left_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(3,Piece,1),
	C_index is Piece_Column_Index-2,
	add_move(Board, Piece_Row_Index, C_index, List_Of_Moves, New_List_Of_Moves).
left_possible_moves(_, _, _, _, List_Of_Moves, New_List_Of_Moves):-
	New_List_Of_Moves = List_Of_Moves.

right_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(5,Piece,1),
	C_index is Piece_Column_Index+1,
	add_move(Board, Piece_Row_Index, C_index, List_Of_Moves, New_List_Of_Moves).
right_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(5,Piece,1),
	C_index is Piece_Column_Index+2,
	add_move(Board, Piece_Row_Index, C_index, List_Of_Moves, New_List_Of_Moves).
right_possible_moves(_, _, _, _, List_Of_Moves, New_List_Of_Moves):-
	New_List_Of_Moves = List_Of_Moves.

down_left_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(6,Piece,1),
	R_index is Piece_Row_Index+1,
	C_index is Piece_Column_Index-1,
	add_move(Board, R_index, C_index, List_Of_Moves, New_List_Of_Moves).
down_left_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(6,Piece,1),
	R_index is Piece_Row_Index+2,
	C_index is Piece_Column_Index-2,
	add_move(Board, R_index, C_index, List_Of_Moves, New_List_Of_Moves).
down_left_possible_moves(_, _, _, _, List_Of_Moves, New_List_Of_Moves):-
	New_List_Of_Moves = List_Of_Moves.

down_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(7,Piece,1),
	R_index is Piece_Row_Index+1,
	add_move(Board, R_index, Piece_Column_Index, List_Of_Moves, New_List_Of_Moves).
down_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(7,Piece,1),
	R_index is Piece_Row_Index+2,
	add_move(Board, R_index, Piece_Column_Index, List_Of_Moves, New_List_Of_Moves).
down_possible_moves(_, _, _, _, List_Of_Moves, New_List_Of_Moves):-
	New_List_Of_Moves = List_Of_Moves.

down_right_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(8,Piece,1),
	R_index is Piece_Row_Index+1,
	C_index is Piece_Column_Index+1,
	add_move(Board, R_index, C_index, List_Of_Moves, New_List_Of_Moves).
down_right_possible_moves(Board, Piece_Row_Index, Piece_Column_Index, Piece, List_Of_Moves, New_List_Of_Moves):-
	nth0(8,Piece,1),
	R_index is Piece_Row_Index+2,
	C_index is Piece_Column_Index+2,
	add_move(Board, R_index, C_index, List_Of_Moves, New_List_Of_Moves).
down_right_possible_moves(_, _, _, _, List_Of_Moves, New_List_Of_Moves):-
	New_List_Of_Moves = List_Of_Moves.

add_move(Board, Row_Index, Column_Index, List_Of_Moves, New_List_Of_Moves):-
	proper_length(Board, Board_Size),
	Row_Index >= 0,
	Row_Index < Board_Size,
	Column_Index >= 0,
	Column_Index < Board_Size,

	\+ is_piece(Board, Row_Index, Column_Index),
	proper_length(List_Of_Moves, Index),
	Temp_Element = [Row_Index, Column_Index],
	nth0(Index, New_List_Of_Moves, Temp_Element, List_Of_Moves).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%    Directions Menu    %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

piece_direction_menu(Board, Row_Index, Column_Index, Player_Type, NewBoard):-
	piece_directions_avaliable(Board, Row_Index, Column_Index, Counter),
	Counter < 8,
	nl,
	Char_Row is Row_Index+97,
	write('    Piece '), put(Char_Row), write(Column_Index), write(' directions'),
	nl,
	nl,
	list_possible_directions(Board, Row_Index, Column_Index),
	nl,
	write('	Choose the direction (choose option number ex: 1.):   '),
	read(Direction),
	set_piece_direction(Board, Row_Index, Column_Index, Direction, Player_Type, NewBoard).

piece_direction_menu(Board, Row_Index, Column_Index, Player_Type, NewBoard):-
	print_warning('An error occurred.. You cant add more directions to this piece.', 63),
	nl,
	piece_options(Board, Row_Index, Column_Index, Player_Type, NewBoard).

set_piece_direction(Board, Row_Index, Column_Index, Direction, _, NewBoard):-
	get_piece(Board, Row_Index, Column_Index, Piece, Temp_Board),
	nth0(Direction, Piece, Current_Value, Temp_Directions),

	Current_Value == 0,
	nth0(Direction, NewPiece, 1, Temp_Directions),
	insert_piece(Temp_Board, Row_Index, Column_Index, NewPiece, NewBoard).

set_piece_direction(Board, Row_Index, Column_Index, _, Player_Type, NewBoard):-
	print_warning('An error occurred... Your option is invalid.', 44),
	nl,
	piece_direction_menu(Board, Row_Index, Column_Index, Player_Type, NewBoard).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%    List directions    %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

list_possible_directions(Board, Row_Index, Column_Index):-
	up_left_direction(   Board, Row_Index, Column_Index ),
	up_direction(        Board, Row_Index, Column_Index ),
	up_right_direction(  Board, Row_Index, Column_Index ),
	left_direction(      Board, Row_Index, Column_Index ), 
	right_direction(     Board, Row_Index, Column_Index ), 
	down_left_direction( Board, Row_Index, Column_Index ), 
	down_direction(      Board, Row_Index, Column_Index ), 
	down_right_direction(Board, Row_Index, Column_Index ).

up_left_direction(Board, Row_Index, Column_Index):-
	get_piece(Board, Row_Index, Column_Index, Piece,_),
	nth0(0, Piece, Value),
	Value == 0,
	write('	0 - up left direction'),
	nl.
up_left_direction(_ ,_ ,_).

up_direction(Board, Row_Index, Column_Index):-
	get_piece(Board, Row_Index, Column_Index, Piece, _),
	nth0(1, Piece, Value),
	Value == 0,
	write('	1 - up direction'),
	nl.
up_direction(_ ,_ ,_ ).

up_right_direction(Board, Row_Index, Column_Index):-
	get_piece(Board, Row_Index, Column_Index, Piece, _),
	nth0(2, Piece, Value),
	Value == 0,
	write('	2 - up right direction'),
	nl.
up_right_direction(_ ,_ ,_ ).

left_direction(Board, Row_Index, Column_Index):-
	get_piece(Board, Row_Index, Column_Index, Piece, _),
	nth0(3, Piece, Value),
	Value == 0,
	write('	3 - left direction'),
	nl.
left_direction(_ ,_ ,_ ).

right_direction(Board, Row_Index, Column_Index):-
	get_piece(Board, Row_Index, Column_Index, Piece, _),
	nth0(5, Piece, Value),
	Value == 0,
	write('	5 - right direction'),
	nl.
right_direction(_ ,_ ,_).


down_left_direction(Board, Row_Index, Column_Index):-
	get_piece(Board, Row_Index, Column_Index, Piece, _),
	nth0(6, Piece, Value),
	Value == 0,
	write('	6 - down left direction'),
	nl.
down_left_direction(_ ,_ ,_).

down_direction(Board, Row_Index, Column_Index):-
	get_piece(Board, Row_Index, Column_Index, Piece, _),
	nth0(7, Piece, Value),
	Value == 0,
	write('	7 - down direction'),
	nl.
down_direction(_ ,_ ,_).

down_right_direction(Board, Row_Index, Column_Index):-
	get_piece(Board, Row_Index, Column_Index, Piece, _),
	nth0(8, Piece, Value),
	Value == 0,
	write('	8 - down right direction'),
	nl.
down_right_direction(_ ,_ ,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%    Interface     %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

initialize_game(Board_Size):-
	initialize_board(Board_Size, Board),
	game_loop(Board, 'Y', 0).

game_loop(Board, _, 1):-
	draw_board(Board).

game_loop(Board, 'Y', 0):-
	draw_board(Board),
	player_yellow_turn(Board, NewBoard),
	game_loop(NewBoard, 'R', 0).


game_loop(Board, 'R', 0):-
	draw_board(Board),
	player_red_turn(Board, NewBoard),
	%verify_reds_end_positions(NewBoard, Return),
	%end_game(Return, 'R'),
	game_loop(NewBoard, 'Y', 0).


player_crate_placement1(Board,Piece_Row_Index,Piece_Column_Index,NewBoard):-
	display_player_turn('Yellow player turn!'),
	nl,
	read_crater(Board,Piece_Row_Index,Piece_Column_Index,NewBoard_1),
	read_crater(NewBoard_1,Piece_Row_Index,Piece_Column_Index,NewBoard).
	
player_yellow_turn(Board, NewBoard):-
	display_player_turn('Yellow player turn!'),
	nl,
	read_crater(Board,_,_,NewBoard).
player_red_turn(Board, NewBoard):-
	display_player_turn('  Red  player turn!'),
	nl,
	read_crater(Board,Piece_Row_Index,Piece_Column_Index,NewBoard).
	%read_piece(Board, Piece_Row_Index, Piece_Column_Index, 'R'),
	%piece_options(Board, Piece_Row_Index, Piece_Column_Index, 'R', NewBoard).

end_game(1, 'Y'):-
	print_warning('      Player Yellow win!!!!      ', 33),
	nl.
end_game(1, 'R'):-
	print_warning('      Player Reds win!!!!      ', 31),
	nl.
end_game(0, _).

number_of_pieces(Board, Type, Counter):-
	number_of_pieces_aux(Board, Type, 0, Counter).

number_of_pieces_aux([], _, Counter, New_Counter):-
	New_Counter = Counter.
number_of_pieces_aux([Current_Row|Next_Rows], Piece_Type, Counter, New_Counter):-
	number_of_pieces_aux2(Current_Row, Piece_Type, Counter, Temp_Counter),
	number_of_pieces_aux(Next_Rows, Piece_Type, Temp_Counter, New_Counter).



number_of_pieces_aux2([], _, Counter, New_Counter):-
	New_Counter = Counter.

number_of_pieces_aux2([Current_Column|Next_Columns], Piece_Type, Counter, New_Counter):-
	proper_length(Current_Column,2),
	nth0(1,Current_Column,Piece),
	nth0(4,Piece,Piece_Type),
	C is Counter+1,
	number_of_pieces_aux2(Next_Columns, Piece_Type, C, New_Counter).

number_of_pieces_aux2([Current_Column|Next_Columns], Piece_Type, Counter, New_Counter):-
	proper_length(Current_Column,9),
	nth0(4,Current_Column,Piece_Type),
	C is Counter+1,
	number_of_pieces_aux2(Next_Columns, Piece_Type, C, New_Counter).

number_of_pieces_aux2([_|Next_Columns], Piece_Type, Counter, New_Counter):-
	number_of_pieces_aux2(Next_Columns, Piece_Type, Counter, New_Counter).


find_piece_in([], _, _, Return):-
	Return is 0.
find_piece_in([Current_Cell|_], Element, End_Cell, Return):-
	proper_length(Current_Cell,2),
	
	[End_Field|NextList] = Current_Cell,
	
	End_Field == End_Cell,
	nth0(0, NextList, Piece),
	nth0(4,Piece,Element),
	Return is 1.

find_piece_in([_|Next_Cells], Element, End_Cell, Return):-
	find_piece_in(Next_Cells, Element, End_Cell, Return).

display_player_turn(Player_Name):-
	write('		╔═════════════════════════════╗'), nl,
	write('		║                             ║'), nl,
	write('		║     ')                         , 
	write(Player_Name)                           , 
	write('     ║')                              , nl,
	write('		║                             ║'), nl,
	write('		╚═════════════════════════════╝'), nl.

print_warning(Warning_Msg, Msg_Size):-
	Size is Msg_Size + 6, 
	nl,
	write('	'),
	draw_character('#', Size), nl,
	write('	#  '), 
	write(Warning_Msg), 
	write('  #'), nl,
	write('	'), 
	draw_character('#', Size), nl.

draw_character(_, 0).
draw_character(Char, Size):-
	write(Char),
	S is Size-1,
	draw_character(Char, S).