:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).

find_optimal(Group, GroupLength, Initial, ChairsPerRow, Vars, VT):-
	minimum(MinSeat,Group),
	maximum(MaxSeat,Group),
	(MaxSeat - MinSeat) #= (GroupLength - 1), 

	((MaxSeat-1) mod ChairsPerRow) #> ((MinSeat-1) mod ChairsPerRow), %Must be on the same row - This implementation means that a group mustnt be bigger than a row

	variation_list(Group, Initial, Vars),
	sum(Vars, #= , VT).
	
variation_list([], [], []).
variation_list([G|Group], [I|Initial], [V|Vars]):-
	(abs(G-I) #\= 0 #<=> V), %ou (V #= abs(G-I)), com a primeira, obtem-se o menor numero de mudanças, com a segunda a mudança mas pequena
	variation_list(Group, Initial, Vars).


%VT = minimo de variação, Vars, Quais variaram a sua posiçao
find_optimal_groups(_, [], _ , [], []).
find_optimal_groups([Initial|IRest], [Group|GRest], ChairsPerRow, [Var|VRest], [VT|VTRest]) :-
	length(Initial,GroupLength),
	find_optimal(Group, GroupLength, Initial, ChairsPerRow, Var, VT),
	find_optimal_groups(IRest, GRest, ChairsPerRow, VRest, VTRest).

%Se o grupo nao couber na fila, começará a ser ordenado na fila seguinte. 
%Para grupos > que ChairsPerRow, começaram a ser ordenados a partir do inicio da primeira row nao ocupada. Neste caso nao é tido em conta VT
manyGroupRedis(Seats, ChairsPerRow, Initials, Groups, Vars, VT) :-
	statistics(runtime, [T0| _]),
	nl,
	loading,
	length(Initials, GroupNum),
	length(Groups, GroupNum),
	initialize(Groups, Initials, Seats),
	find_optimal_groups(Initials, Groups, ChairsPerRow, Vars, VTList),
	append(Groups,FlattenedGroups),
	all_distinct(FlattenedGroups),
	sum(VTList, #= , VT),
	labeling([minimize(VT),time_out(20000,_)],FlattenedGroups),
	cls,
	outputseats(1, ChairsPerRow, Seats, Groups, []),
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
writeOutput(RowCounter, ChairsPerRow, [Seat|List]):-
	(
		RowCounter == ChairsPerRow, nl, write(' '), write(Seat), writeOutput(1, ChairsPerRow, List)
	);
	write(' '), write(Seat), NewRowCounter is RowCounter+1, writeOutput(NewRowCounter, ChairsPerRow, List).
	
isFromGroupNumber(_, [], _, _):- fail.
isFromGroupNumber(Counter, [Group|Groups], N, Number):-
	member(Counter, Group), Number = N;
	N1 is N+1, isFromGroupNumber(Counter, Groups, N1, Number).
	
outputseats(_, ChairsPerRow, 0, _, OutputList):- nl, writeOutput(0, ChairsPerRow, OutputList).
outputseats(Counter, ChairsPerRow, Seats, Groups, OutputList):-
	(
		isFromGroupNumber(Counter, Groups, 1, Number), append(OutputList, [Number], NewList);
		append(OutputList, ['_'], NewList)
	),	
	NewCounter is Counter+1, NewSeats is Seats-1,
	outputseats(NewCounter, ChairsPerRow, NewSeats, Groups, NewList).

cls :- write('\e[2J').
loading:- write('\t'), write('\t'), write('\t'), write('\t'), write('\t'), write('Loading').