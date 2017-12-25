:- use_module(library(clpfd)).
:- use_module(library(lists)).

optimal(Group, GroupLength, Initial, RowSize, Vars, Variation):-
	minimum(MinSeat,Group),
	maximum(MaxSeat,Group),
	(MaxSeat - MinSeat) #= (GroupLength - 1), 

	((MaxSeat-1) mod RowSize) #> ((MinSeat-1) mod RowSize),

	variation_list(Group, Initial, Vars),
	sum(Vars, #= , Variation).
	
variation_list([], [], []).
variation_list([G|Group], [I|Initial], [V|Vars]):-
	(abs(G-I) #\= 0 #<=> V), %ou (V #= abs(G-I)), com a primeira, obtem-se o menor numero de mudanças, com a segunda a mudança mais pequena
	variation_list(Group, Initial, Vars).


%Variation = minimo de variação, Vars, Quais variaram a sua posiçao
optimal_groups(_, [], _ , [], []).
optimal_groups([Initial|IRest], [Group|GRest], RowSize, [Var|VRest], [Variation|VTRest]) :-
	length(Initial,GroupLength),
	optimal(Group, GroupLength, Initial, RowSize, Var, Variation),
	optimal_groups(IRest, GRest, RowSize, VRest, VTRest).

%Se o grupo nao couber na fila, começará a ser ordenado na fila seguinte. 
%Para grupos > que RowSize, começaram a ser ordenados a partir do inicio da primeira row nao ocupada. Neste caso nao é tido em conta VT
solve_group_destribution(Seats, RowSize, Initials, Groups, Vars, Variation) :-
	statistics(runtime, [T0| _]),
	nl,
	loading,
	length(Initials, GroupNum),
	length(Groups, GroupNum),
	initialize(Groups, Initials, Seats),
	optimal_groups(Initials, Groups, RowSize, Vars, VTList),
	append(Groups,FlattenedGroups),
	all_distinct(FlattenedGroups),
	sum(VTList, #= , Variation),
	labeling([minimize(Variation),time_out(20000,_)],FlattenedGroups),
	cls,
	outputseats(1, RowSize, Seats, Groups, []),
    statistics(runtime, [T1|_]),
    T is T1 - T0,
    nl,nl,
    format('Execution took ~3d sec.~n', [T]).

initialize([],[],_).
initialize([Group|GRest], [Initial|IRest], Seats) :-
	length(Initial, GroupSize),
	length(Group, GroupSize),
	domain(Group, 1, Seats),
	initialize(GRest, IRest, Seats).

writeOutput(_, _, []).
writeOutput(RowCounter, RowSize, [Seat|List]):-
	(
		RowCounter == RowSize, nl, write(' '), write(Seat), writeOutput(1, RowSize, List)
	);
	write(' '), write(Seat), NewRowCounter is RowCounter+1, writeOutput(NewRowCounter, RowSize, List).
	
isFromGroupNumber(_, [], _, _):- fail.
isFromGroupNumber(Counter, [Group|Groups], N, Number):-
	member(Counter, Group), Number = N;
	N1 is N+1, isFromGroupNumber(Counter, Groups, N1, Number).
	
outputseats(_, RowSize, 0, _, OutputList):- nl, writeOutput(0, RowSize, OutputList).
outputseats(Counter, RowSize, Seats, Groups, OutputList):-
	(
		isFromGroupNumber(Counter, Groups, 1, Number), append(OutputList, [Number], NewList);
		append(OutputList, ['_'], NewList)
	),	
	NewCounter is Counter+1, NewSeats is Seats-1,
	outputseats(NewCounter, RowSize, NewSeats, Groups, NewList).

cls :- write('\e[2J').
loading:- write('\t'), write('\t'), write('\t'), write('\t'), write('\t'), write('Loading').
