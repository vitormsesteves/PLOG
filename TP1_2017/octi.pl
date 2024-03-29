

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
%	%%0%%
%	write(Column_Index),write(Row_Index),
%	%% Column and row calcs%%
%	
%	Column0 is Column_Index -1, 
%	Row0 is Row_Index - 1, 
%	Column2 is Column_Index + 1,
%	Row2 	is Row_Index +1 ,
%	%% Row 0 %%
%	%0,0%
%	insert_element(Board,Row0,Column0,Element,TempBoard),
%	
%	%0,1%
%	insert_element(TempBoard,Row0,Column_Index,Element,TempBoard1),
%	
%	%0,2%
%	insert_element(TempBoard1,Row0,Column2,Element,TempBoard2),
%	%%Row 1 %%
%	
%	%1,0%
%	insert_element(TempBoard2,Row_Index,Column0,Element,TempBoard3),
%	
%	%1,1%
%	insert_element(TempBoard3,Row_Index,Column_Index,Element,TempBoard4),
%
%	%1,2%
%	insert_element(TempBoard4,Row_Index,Column2,Element,TempBoard6),
%	
%	%%Row 2 %%
%
%	%2,0%
%	insert_element(TempBoard2,Row2,Column0,Element,TempBoard3),
%	
%	%2,1%
%	insert_element(TempBoard3,Row2,Column_Index,Element,TempBoard4),
%	
%	%2,2%
%	insert_element(TempBoard4,Row2,Column2,Element,NewBoard).
%	
%	%%Row 1 %%


insert_piece_T_rotate1(Board,Row_Index,Column_Index,Element,NewBoard):-
	%%0%%
	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Column0 is Column_Index -1, 
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	
	%0,0%
	insert_element(Board,Row0,Column0,Element,TempBoard),
	
	%0,1%
	insert_element(TempBoard,Row0,Column_Index,Element,TempBoard1),
	
	%0,2%
	insert_element(TempBoard1,Row0,Column2,Element,TempBoard2),
	
	%%Row 1 %%
	
	%1,1%
	insert_element(TempBoard2,Row_Index,Column_Index,Element,TempBoard3),

	%%Row 2 %%

	%2,1%
	insert_element(TempBoard3,Row2,Column_Index,Element,NewBoard).



insert_piece_T_rotate2(Board,Row_Index,Column_Index,Element,NewBoard):-
		%%0%%
	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Column0 is Column_Index -1, 
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	%% Row 0 %%
	
	%0,2%
	insert_element(Board,Row0,Column2,Element,TempBoard2),
	
	%%Row 1 %%
	
	%1,0%
	insert_element(TempBoard2,Row_Index,Column0,Element,TempBoard3),
	
	%1,1%
	insert_element(TempBoard3,Row_Index,Column_Index,Element,TempBoard4),

	%1,2%
	insert_element(TempBoard4,Row_Index,Column2,Element,TempBoard6),
	
	%%Row 2 %%

	%2,2%
	insert_element(TempBoard6,Row2,Column2,Element,NewBoard).
	

insert_piece_T_rotate3(Board,Row_Index,Column_Index,Element,NewBoard):-
	%%0%%
	write(Row_Index),write(Column_Index),
	%% Column and row calcs%%
	Column0 is Column_Index -1, 
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	
	
	%0,1%
	insert_element(Board,Row0,Column_Index,Element,TempBoard1),
	
	%%Row 1 %%
	
	%1,1%
	insert_element(TempBoard1,Row_Index,Column_Index,Element,TempBoard2),

	%%Row 2 %%

	%2,0%
	insert_element(TempBoard2,Row2,Column0,Element,TempBoard3),
	
	%2,1%
	insert_element(TempBoard3,Row2,Column_Index,Element,TempBoard4),
	
	%2,2%
	insert_element(TempBoard4,Row2,Column2,Element,NewBoard).

insert_piece_T_rotate4(Board,Row_Index,Column_Index,Element,NewBoard):-
	%%0%%
	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	Column0 is Column_Index -1, 
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	%0,0%
	insert_element(Board,Row0,Column0,Element,TempBoard),
	
	%%Row 1 %%
	
	%1,0%
	insert_element(TempBoard,Row_Index,Column0,Element,TempBoard1),
	
	%1,1%
	insert_element(TempBoard1,Row_Index,Column_Index,Element,TempBoard3),

	%1,2%
	insert_element(TempBoard3,Row_Index,Column2,Element,TempBoard4),
	
	%%Row 2 %%

	%2,0%
	insert_element(TempBoard4,Row2,Column0,Element,NewBoard).



insert_piece_C_rotated1(Board,Row_Index,Column_Index,Element,NewBoard):-
	%%0%%
	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Column0 is Column_Index -1, 
	Row0 is Row_Index - 1, 
	Row2 	is Row_Index +1 ,
	%% Row 0 %%
	%0,0%
	insert_element(Board,Row0,Column0,Element,TempBoard),
	
	%0,1%
	insert_element(TempBoard,Row0,Column_Index,Element,TempBoard1),
	
	%%Row 1 %%
	
	%1,0%
	insert_element(TempBoard1,Row_Index,Column0,Element,TempBoard2),
	
	
	%%Row 2 %%

	%2,0%
	insert_element(TempBoard2,Row2,Column0,Element,TempBoard3),
	
	%2,1%
	insert_element(TempBoard3,Row2,Column_Index,Element,NewBoard).
	
	%%Row 1 %%
insert_piece_C_rotated2(Board,Row_Index,Column_Index,Element,NewBoard):-
	%%0%%
	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	%% Row 0 %%
	%0,0%
	insert_element(Board,Row0,Column0,Element,TempBoard),
	
	%0,1%
	insert_element(TempBoard,Row0,Column_Index,Element,TempBoard1),
	
	%0,2%
	insert_element(TempBoard1,Row0,Column2,Element,TempBoard2),
	%%Row 1 %%
	
	%1,0%
	insert_element(TempBoard2,Row_Index,Column0,Element,TempBoard3),
	
	%%Row 2 %%

	%2,0%
	insert_element(TempBoard3,Row2,Column0,Element,NewBoard).
	
	%%Row 1 %%
insert_piece_C_rotated3(Board,Row_Index,Column_Index,Element,NewBoard):-
	%%0%%
	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	%% Row 0 %%
	%0,1%
	insert_element(Board,Row0,Column_Index,Element,TempBoard1),
	
	%0,2%
	insert_element(TempBoard1,Row0,Column2,Element,TempBoard2),
	%%Row 1 %%
	
	%1,2%
	insert_element(TempBoard2,Row_Index,Column2,Element,TempBoard3),
	
	%%Row 2 %%

	%2,1%
	insert_element(TempBoard3,Row2,Column_Index,Element,TempBoard4),
	
	%2,2%
	insert_element(TempBoard4,Row2,Column2,Element,NewBoard).
	
	%%Row 1 %%
insert_piece_C_rotated4(Board,Row_Index,Column_Index,Element,NewBoard):-
	%%0%%
	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Column0 is Column_Index -1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	%% Row 0 %%
	%%Row 1 %%
	
	%1,0%
	insert_element(Board,Row_Index,Column0,Element,TempBoard),
	
	%1,2%
	insert_element(TempBoard,Row_Index,Column2,Element,TempBoard1),
	
	%%Row 2 %%

	%2,0%
	insert_element(TempBoard1,Row2,Column0,Element,TempBoard3),
	
	%2,1%
	insert_element(TempBoard3,Row2,Column_Index,Element,TempBoard4),
	
	%2,2%
	insert_element(TempBoard4,Row2,Column2,Element,NewBoard).
	
	%%Row 1 %%	
insert_piece_L_rotated1(Board,Row_Index,Column_Index,Element,NewBoard):-

	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Column0 is Column_Index -1, 
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	%% Row 0 %%
	%0,0%
	insert_element(Board,Row0,Column0,Element,TempBoard),

	%%Row 1 %%
	
	%1,0%
	insert_element(TempBoard,Row_Index,Column0,Element,TempBoard2),
		
	%%Row 2 %%

	%2,0%
	insert_element(TempBoard2,Row2,Column0,Element,TempBoard3),
	
	%2,1%
	insert_element(TempBoard3,Row2,Column_Index,Element,TempBoard4),
	
	%2,2%
	insert_element(TempBoard4,Row2,Column2,Element,NewBoard).

	%%Row 1 %%

insert_piece_L_rotated2(Board,Row_Index,Column_Index,Element,NewBoard):-

	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Column0 is Column_Index -1, 
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	
	%% Row 0 %%
	%0,0%
	insert_element(Board,Row0,Column0,Element,TempBoard),
	
	%0,1%
	insert_element(TempBoard,Row0,Column_Index,Element,TempBoard1),
	
	%0,2%
	insert_element(TempBoard1,Row0,Column2,Element,TempBoard2),
	%%Row 1 %%
	
	%1,0%
	insert_element(TempBoard2,Row_Index,Column0,Element,TempBoard3),
	
	
	%%Row 2 %%

	%2,0%
	insert_element(TempBoard3,Row2,Column0,Element,NewBoard).


insert_piece_L_rotated3(Board,Row_Index,Column_Index,Element,NewBoard):-

	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Column0 is Column_Index -1, 
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	%% Row 0 %%
	%0,0%
	insert_element(Board,Row0,Column0,Element,TempBoard),
	
	%0,1%
	insert_element(TempBoard,Row0,Column_Index,Element,TempBoard1),
	
	%0,2%
	insert_element(TempBoard1,Row0,Column2,Element,TempBoard2),
	%%Row 1 %%
	

	%1,2%
	insert_element(TempBoard2,Row_Index,Column2,Element,TempBoard3),
	
	%%Row 2 %%
	
	%2,2%
	insert_element(TempBoard3,Row2,Column2,Element,NewBoard).
	

insert_piece_L_rotated4(Board,Row_Index,Column_Index,Element,NewBoard):-
	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Column0 is Column_Index -1, 
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	%% Row 0 %%
	%0,2%
	insert_element(Board,Row0,Column2,Element,TempBoard),
	%%Row 1 %%
	%1,2%
	insert_element(TempBoard,Row_Index,Column2,Element,TempBoard2),
	
	%%Row 2 %%

	%2,0%
	insert_element(TempBoard2,Row2,Column0,Element,TempBoard3),
	
	%2,1%
	insert_element(TempBoard3,Row2,Column_Index,Element,TempBoard4),
	
	%2,2%
	insert_element(TempBoard4,Row2,Column2,Element,NewBoard).

insert_piece_W_rotated1(Board,Row_Index,Column_Index,Element,NewBoard):-
	
	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Column0 is Column_Index -1, 
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	%% Row 0 %%

	%0,0%
	insert_element(Board,Row0,Column0,Element,TempBoard),
	
	%0,1%
	insert_element(TempBoard,Row0,Column_Index,Element,TempBoard1),
	
	%%Row 1 %%
		
	%1,1%
	insert_element(TempBoard1,Row_Index,Column_Index,Element,TempBoard2),

	%1,2%
	insert_element(TempBoard2,Row_Index,Column2,Element,TempBoard3),
	
	%%Row 2 %%

	%2,2%
	insert_element(TempBoard3,Row2,Column2,Element,NewBoard).
	

insert_piece_W_rotated2(Board,Row_Index,Column_Index,Element,NewBoard):-
	
	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Column0 is Column_Index -1, 
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	%% Row 0 %%
	%0,2%
	insert_element(Board,Row0,Column2,Element,TempBoard),
	
	%%Row 1 %%
	
	%1,1%
	insert_element(TempBoard,Row_Index,Column_Index,Element,TempBoard2),

	%1,2%
	insert_element(TempBoard2,Row_Index,Column2,Element,TempBoard3),
	
	%%Row 2 %%

	%2,0%
	insert_element(TempBoard3,Row2,Column0,Element,TempBoard4),
	
	%2,1%
	insert_element(TempBoard4,Row2,Column_Index,Element,NewBoard).
	

insert_piece_W_rotated3(Board,Row_Index,Column_Index,Element,NewBoard):-
	
	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Column0 is Column_Index -1, 
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	%% Row 0 %%

	%0,0%
	insert_element(Board,Row0,Column0,Element,TempBoard),
	
	%%Row 1 %%
	
	%1,0%
	insert_element(TempBoard,Row_Index,Column0,Element,TempBoard2),
	
	%1,1%
	insert_element(TempBoard2,Row_Index,Column_Index,Element,TempBoard3),
	%%Row 2 %%

	%2,1%
	insert_element(TempBoard3,Row2,Column_Index,Element,TempBoard4),
	
	%2,2%
	insert_element(TempBoard4,Row2,Column2,Element,NewBoard).
	
	%%Row 1 %%

insert_piece_W_rotated4(Board,Row_Index,Column_Index,Element,NewBoard):-
	
	write(Column_Index),write(Row_Index),
	%% Column and row calcs%%
	
	Column0 is Column_Index -1, 
	Row0 is Row_Index - 1, 
	Column2 is Column_Index + 1,
	Row2 	is Row_Index +1 ,
	%% Row 0 %%

	%0,1%
	insert_element(Board,Row0,Column_Index,Element,TempBoard1),
	
	%0,2%
	insert_element(TempBoard1,Row0,Column2,Element,TempBoard2),
	%%Row 1 %%
	
	%1,0%
	insert_element(TempBoard2,Row_Index,Column0,Element,TempBoard3),
	
	%1,1%
	insert_element(TempBoard3,Row_Index,Column_Index,Element,TempBoard4),
	%%Row 2 %%

	%2,0%
	insert_element(TempBoard4,Row2,Column0,Element,NewBoard).
	
	%%Row 1 %%


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
%%%%%%%%%%%%%%%%%   Menu   %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

read_crater(Board, Piece_Row_Index,Piece_Column_Index,NewBoard):-
	nl,
	
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

read_piece(Board, NewBoard,Player_Type):-
	
	read(Piece),

	name(Piece, Piece_Str),
	
	nth0(0, Piece_Str, Temp_R),
	nth0(1, Piece_Str, Temp_C),	

	Piece_Row_Index is Temp_R - 97,
	Piece_Column_Index is Temp_C - 48,

	write(Piece_Column_Index),
	write(Piece_Row_Index),
	piece_options(Board, Piece_Row_Index, Piece_Column_Index,[0,0,0,0,Player_Type,0,0,0,0], NewBoard).
piece_options(Board, Piece_Row_Index, Piece_Column_Index,Element, NewBoard):-
	Char_Row is Piece_Row_Index+97,
	write('    Piece '), put(Char_Row), write(Piece_Column_Index), write(' options'),
	nl,
	nl,
	write('	1 - Piece Format:    T    '),
	nl,
	write('	2 - Piece Format:    C    '),
	nl,
	write('	3 - Piece Format:    L    '),
	nl,
	write('	4 - Piece Format:    W    '),
	nl, nl,
	write('	Select an option(input type ex: 1.): '),
	read(Option),
	write('Teste'),
	write(Element),

	write('    Piece '), put(Char_Row), write(Piece_Column_Index), write(' options'),
	nl,
	nl,
	write('	1 - Piece Rotation:    0  '),
	nl,
	write('	2 - Piece Rotation:    90 '),
	nl,
	write('	3 - Piece Rotation:    180'),
	nl,
	write('	4 - Piece Rotation:    270'),
	nl, nl,
	write('	Select an option(input type ex: 1.): '),
	read(Rotation),
	resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option,Rotation, Element, NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 1,
	Rotation == 1,
	write('good'),
	insert_piece_T_rotate1(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 1,
	Rotation == 2,
	write('good'),
	insert_piece_T_rotate2(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 1,
	Rotation == 3,
	write('good'),
	insert_piece_T_rotate4(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 1,
	Rotation == 4,
	write('good'),
	insert_piece_T_rotate3(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 2,
	Rotation == 1,
	insert_piece_C_rotated1(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 2,
	Rotation == 2,
	insert_piece_C_rotated2(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 2,
	Rotation == 3,
	insert_piece_C_rotated3(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 2,
	Rotation == 4,
	insert_piece_C_rotated4(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 3,
	Rotation == 1,
	insert_piece_L_rotated1(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 3,
	Rotation == 2,
	insert_piece_L_rotated2(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 3,
	Rotation == 3,
	insert_piece_L_rotated3(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 3,
	Rotation == 4,
	insert_piece_L_rotated4(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 4,
	Rotation == 1,
	insert_piece_W(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 4,
	Rotation == 2,
	insert_piece_W(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 4,
	Rotation == 3,
	insert_piece_W(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).

resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, Option, Rotation, Element, NewBoard):-
	Option == 4,
	Rotation == 4,
	insert_piece_W(Board,Piece_Row_Index,Piece_Column_Index,Element,NewBoard).


resolve_piece_option(Board, Piece_Row_Index, Piece_Column_Index, 1, Element, NewBoard):-
	print_warning('An error occurred.. This piece dont have posible moves.', 55),
	nl,
	piece_options(Board, Piece_Row_Index, Piece_Column_Index, Element, NewBoard).

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


player_yellow_turn(Board, NewBoard):-
	display_player_turn('Yellow player turn!'),
	nl,
	write('Select a spot to place the crater(input type ex: b4) :'),
	read_crater(Board,_,_,Temp_Board),
	draw_board(Temp_Board),
	write('Select a spot to palce a piece(input type ex: b4.): '),
	nl,
	read_piece(Temp_Board,NewBoard,'Y').
player_red_turn(Board, NewBoard):-
	display_player_turn('  Red  player turn!'),
	nl,
	write('Select a spot to place the crater(input type ex: b4) :'),
	read_crater(Board,_,_,Temp_Board),
	draw_board(Temp_Board),
	write('Select a spot to palce a piece(input type ex: b4.): '),
	nl,
	read_piece(Temp_Board,NewBoard,'R').

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
	proper_length(Current_Cell,9),
	
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