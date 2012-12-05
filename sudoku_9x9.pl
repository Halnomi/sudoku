/* 9x9 sudoku solver by vwxy */

:- use_module(library(clpfd)).

%% ----------------- tools -----------------

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

block( R1, R2, R3, C1, C3, Square, Output ) :-
  nth1( R1, Square, Row1 ),
  nth1( R2, Square, Row2 ),
  nth1( R3, Square, Row3 ),
  slice( Row1, C1, C3, Mini1 ),
  slice( Row2, C1, C3, Mini2 ),
  slice( Row3, C1, C3, Mini3 ),
  append( Mini2, Mini3, Temp ),
  append( Mini1, Temp, Output ).

%% ----------------- valid -----------------

valid( [] ).

valid( [H|T] ) :-
  all_different( H ),
  valid( T ).

%% ----------------- sudoku -----------------

sudoku( Square ) :-
  nth1( 1, Square, R1 ),
  nth1( 2, Square, R2 ),
  nth1( 3, Square, R3 ),
  nth1( 4, Square, R4 ),
  nth1( 5, Square, R5 ),
  nth1( 6, Square, R6 ),
  nth1( 7, Square, R7 ),
  nth1( 8, Square, R8 ),
  nth1( 9, Square, R9 ),

  R1 ins 1..9,
  R2 ins 1..9,
  R3 ins 1..9,
  R4 ins 1..9,
  R5 ins 1..9,
  R6 ins 1..9,
  R7 ins 1..9,
  R8 ins 1..9,
  R9 ins 1..9,

  column( 1, Square, C1 ),
  column( 2, Square, C2 ),
  column( 3, Square, C3 ),
  column( 4, Square, C4 ),
  column( 5, Square, C5 ),
  column( 6, Square, C6 ),
  column( 7, Square, C7 ),
  column( 8, Square, C8 ),
  column( 9, Square, C9 ),

  block( 1, 2, 3, 1, 3, Square, B1 ),
  block( 1, 2, 3, 4, 6, Square, B2 ),
  block( 1, 2, 3, 7, 9, Square, B3 ),
  block( 4, 5, 6, 1, 3, Square, B4 ),
  block( 4, 5, 6, 4, 6, Square, B5 ),
  block( 4, 5, 6, 7, 9, Square, B6 ),
  block( 7, 8, 9, 1, 3, Square, B7 ),
  block( 7, 8, 9, 4, 6, Square, B8 ),
  block( 7, 8, 9, 7, 9, Square, B9 ),

  valid( [B1, B2, B3, B4, B5, B6, B7, B8, B9,
          C1, C2, C3, C4, C5, C6, C7, C8, C9,
          R1, R2, R3, R4, R5, R6, R7, R8, R9] ).

%% ----------------- pprint -----------------

pprint( [] ).

pprint( [H|T] ) :-
  print(H),
  print('\n'),
  pprint( T ).
