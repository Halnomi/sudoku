/* 
4x4 sudoku solver by vwxy
example: Square = [[_,4,_,_],[1,_,_,_],[_,_,_,3],[_,1,_,_]], sudoku( Square ), pprint( Square ).
*/

%% ----------------- tools -----------------

takeout( X, [X|T], T ).

takeout( X, [H|T], [H|S] ) :- takeout( X, T, S ).

slice( [X|_], 1, 1, [X] ).

slice( [X|Xs], 1, K, [X|Ys] ) :-
  K > 1, 
  K1 is K - 1,
  slice( Xs, 1, K1, Ys ).

slice( [_|Xs], I, K, Ys ) :-
  I > 1, 
  I1 is I - 1,
  K1 is K - 1,
  slice( Xs, I1, K1, Ys ).

%% ----------------- column -----------------

column( _, [], [] ).

column( N, [H|T], [Element|Rest] ) :-
  N > 0,
  nth1( N, H, Element ),
  column( N, T, Rest ).

%% ----------------- block -----------------

block( R1, R2, C1, C2, Square, Output ) :-
  nth1( R1, Square, Row1 ),
  nth1( R2, Square, Row2 ),
  slice( Row1, C1, C2, Mini1 ),
  slice( Row2, C1, C2, Mini2 ),
  append( Mini1, Mini2, Output ).

%% ----------------- same elements -----------------

same_elements( [], [] ).

same_elements( [H|T], List ) :-
  member( H, List ),
  takeout( H, List, NewList ),
  same_elements( T, NewList ).

%% ----------------- valid -----------------

valid( [] ).

valid( [H|T] ) :-
  same_elements( H, [1,2,3,4] ),
  valid( T ).

%% ----------------- sudoku -----------------

sudoku( Square ) :-
  nth1( 1, Square, R1 ),
  nth1( 2, Square, R2 ),
  nth1( 3, Square, R3 ),
  nth1( 4, Square, R4 ),

  column( 1, Square, C1 ),
  column( 2, Square, C2 ),
  column( 3, Square, C3 ),
  column( 4, Square, C4 ),

  block( 1, 2, 1, 2, Square, B1 ),
  block( 1, 2, 3, 4, Square, B2 ),
  block( 3, 4, 1, 2, Square, B3 ),
  block( 3, 4, 3, 4, Square, B4 ),

  valid( [R1, R2, R3, R4, C1, C2, C3, C4, B1, B2, B3, B4] ).

%% ----------------- pprint -----------------

pprint( [] ).

pprint( [H|T] ) :-
  print(H),
  print('\n'),
  pprint( T ).
