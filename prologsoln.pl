:- discontiguous copy/2,alloc/2,store/3,load/3,invoke/2.
:- multifile copy/2,alloc/2,store/3,load/3,invoke/2.

element_at(X,[X|_],1).
element_at(X,[_|L],K) :- K > 1, K1 is K - 1, element_at(X,L,K1).

escapes(O):-D is 1,(\+ (findall(D,escapes1(O,D),L1),length(L1,0))).
escapes1(O,D):- D<3000,((\+ (findall(M,(invoke(M,T),element_at(Y,T,D),(alloc_find(Y,O);copy_find(Y,O,3000);store_find(Y,O,3000);load_find(Y,O,3000))),L1),length(L1,0)));escapes1(O,D+1)).
escapesthrough(O,M):- \+ forall((allescapes(M,L),member(O,L)),append(L,[])).
allescapes(M,L):- D is 1,findall(O,allescapes1(M,O,D),L2),list_to_set(L2,L).
allescapes1(M,O,D):- D<3000,((invoke(M,T),element_at(Y,T,D),(alloc_find(Y,O);copy_find(Y,O,3000);store_find(Y,O,3000);load_find(Y,O,3000)));allescapes1(M,O,D+1)).


alloc_find(X,O):-alloc(X,O),alloc(X,_).
copy_find(X,O,D):- D>0, D1 is D-1,copy(X,Y),(alloc_find(Y,O);load_find(Y,O,D1);store_find(Y,O,D1);copy_find(Y,O,D1)).
copy1_find(X,Y,O,D):- D>0, D1 is D-1,copy(X,Y),(alloc_find(Y,O);load_find(Y,O,D1);store_find(Y,O,D1);copy_find(Y,O,D1)).
store_find(X,O,D):- D>0, D1 is D-1,(store(X,_,Y),(copy_find(Y,O,D1);alloc_find(Y,O);load_find(Y,O,D1);store_find(Y,O,D1))).
store1_find(X,Y,O,D):- D>0, D1 is D-1,(store(X,Y,Z),(copy_find(Z,O,D1);alloc_find(Z,O);load_find(Z,O,D1);store_find(Z,O,D1))).
load_find(X,O,D):- D>0, D1 is D-1,(load(X,Y,Z),(store1_find(Y,Z,O,D1);copy1_find(Y,P,O,20),store1_find(P,Z,O,20))).




