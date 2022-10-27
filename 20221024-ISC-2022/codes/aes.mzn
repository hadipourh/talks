int: R;
R = 4;
array[0..R, 0..3, 0..3] of var 0..1: S;
array[0..(R - 1), 0..3] of var 0..1: M;

constraint forall(r in 0..(R - 1), j in 0..3)
(
    sum(i in 0..3)(S[r, i, (i + j) mod 4]) + sum(i in 0..3)(S[r + 1, i, j]) >= 5*M[r, j]
    /\
    sum(i in 0..3)(S[r, i, (i + j) mod 4]) + sum(i in 0..3)(S[r + 1, i, j]) <= 8*M[r, j]
);

var 0..(R*16): obj;
constraint obj = sum(r in 0..(R - 1), i in 0..3, j in 0..3)(S[r, i, j]);
constraint sum(i in 0..3, j in 0..3)(S[0, i, j]) >= 1;

solve minimize sum(r in 0..(R - 1), i in 0..3, j in 0..3)(S[r, i, j]);