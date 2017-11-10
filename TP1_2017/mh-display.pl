

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

draw_avaliable_move           :-write('A').
draw_unavaliable_move         :-write('U').

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
	fill_board(Dimension, Row, [], Board),
	draw_board(Board).



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
	put_code(Row_Number),
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
	length(Cell, 2),
	nth0(0, Cell, 'xR'),
	nth0(1, Cell, Piece),
	draw_piece_1(Piece, '*').
draw_cell_1(Cell):-
	length(Cell, 2),
	nth0(0, Cell, 'xY'),
	nth0(1, Cell, Piece),
	draw_piece_1(Piece, '#').
draw_cell_1(Cell):-
	length(Cell, 9),
	draw_piece_1(Cell, ' ').
draw_cell_1(Cell):-
	Cell == ' ',
	write('         ').
draw_cell_1(Cell):-
	Cell == 'xR',
	write('*********').
draw_cell_1(Cell):-
	Cell == 'xY',
	write('#########').

draw_cell_2(Cell):-
	length(Cell, 2),
	nth0(0, Cell, 'xR'),
	nth0(1, Cell, Piece),
	draw_piece_2(Piece, '▒').
draw_cell_2(Cell):-
	length(Cell, 2),
	nth0(0, Cell, 'xY'),
	nth0(1, Cell, Piece),
	draw_piece_2(Piece, '░').
draw_cell_2(Cell):-
	length(Cell, 9),
	draw_piece_2(Cell, ' ').
draw_cell_2(Cell):-
	Cell == ' ',
	write('         ').
draw_cell_2(Cell):-
	Cell == 'xR',
	write('*********').
draw_cell_2(Cell):-
	Cell == 'xY',
	write('#########').

draw_cell_3(Cell):-
	length(Cell, 2),
	nth0(0, Cell, 'xR'),
	nth0(1, Cell, Piece),
	draw_piece_3(Piece, '▒').
draw_cell_3(Cell):-
	length(Cell, 2),
	nth0(0, Cell, 'xY'),
	nth0(1, Cell, Piece),
	draw_piece_3(Piece, '░').
draw_cell_3(Cell):-
	length(Cell, 9),
	draw_piece_3(Cell, ' ').
draw_cell_3(Cell):-
	Cell == ' ',
	write('         ').
draw_cell_3(Cell):-
	Cell == 'xR',
	write('*********').
draw_cell_3(Cell):-
	Cell == 'xY',
	write('#########').

%%%%%%%%%%%%%%  Draw piece  %%%%%%%%%%%%%%%%%

draw_avaliable_move(0, CellBackground):-
	write(CellBackground),
	draw_unavaliable_move,
	write(CellBackground).
draw_avaliable_move(1, CellBackground):-
	write(CellBackground),
	draw_avaliable_move,
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
	create_board(Dimension, Temp_Board),
	insert_end_cells(Temp_Board, Temp_Board2),
	insert_pieces(Temp_Board2, Board).
