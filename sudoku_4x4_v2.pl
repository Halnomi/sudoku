/* 
4x4 sudoku solver by vwxy, version 2
example: Square = [_,4,_,_,1,_,_,_,_,_,_,3,_,1,_,2], sudoku( Square ), pprint( Square ).
caveat: cases with multiple solutions are left unresolved instead of yielding multiple answers.
*/

:- use_module(library(clpfd)).

%% ----------------- valid -----------------

valid( [] ).

valid( [H|T] ) :-
  all_different( H ),
  valid( T ).

%% ----------------- sudoku -----------------

sudoku( Square ) :-
  Square = [ A1, A2, A3, A4,
             B1, B2, B3, B4,
             C1, C2, C3, C4,
             D1, D2, D3, D4 ],
  Square ins 1..4,

  Row1 = [ A1, A2, A3, A4 ],
  Row2 = [ B1, B2, B3, B4 ],
  Row3 = [ C1, C2, C3, C4 ],
  Row4 = [ D1, D2, D3, D4 ],

  Col1 = [ A1, B1, C1, D1 ],
  Col2 = [ A2, B2, C2, D2 ],
  Col3 = [ A3, B3, C3, D3 ],
  Col4 = [ A4, B4, C4, D4 ],

  Box1 = [ A1, A2, B1, B2 ],
  Box2 = [ A3, A4, B3, B4 ],
  Box3 = [ C1, C2, D1, D2 ],
  Box4 = [ C3, C4, D3, D4 ],

  valid( [ Row1, Row2, Row3, Row4, Col1, Col2, Col3, Col4, Box1, Box2, Box3, Box4 ] ).

%% ----------------- pprint -----------------

pprint( Square ) :-
  Square = [ A1, A2, A3, A4,
             B1, B2, B3, B4,
             C1, C2, C3, C4,
             D1, D2, D3, D4 ],
  print( [ A1, A2, A3, A4 ] ), print('\n'),
  print( [ B1, B2, B3, B4 ] ), print('\n'),
  print( [ C1, C2, C3, C4 ] ), print('\n'),
  print( [ D1, D2, D3, D4 ] ).
