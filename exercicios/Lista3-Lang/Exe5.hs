data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | And Exp Exp
         | Or Exp Exp
         | Not Exp
  deriving Show

e0 = Num 1
e1 = Sub (Add (Num 1) (Num 10)) (Num 20)
e2 = Add (Num 1) (Sub (Num 10) (Num 20))
e3 = Sub (Add (Num 5) (Num 5)) (Sub (Num 5) (Num 5))
e4 = Add (Num 2) (Num 1)
e5 = Or (Num 0) (Num 0)
e6 = Not (Num 123)

avalia :: Exp -> Int
avalia (Num x) = x
avalia (Add e1 e2) = avalia e1 + avalia e2
avalia (Sub e1 e2) = avalia e1 - avalia e2
avalia (And e1 e2) = if (avalia e1)*(avalia e2) /= 0 then 1 else 0
avalia (Or e1 e2) = if avalia (And e1 (Num 1)) + avalia (And e2 (Num 1)) == 0 then 0 else 1
avalia (Not e1) = if avalia e1 == 0 then 1 else 0

avalia' :: Exp -> Exp
avalia' (Num x) = (Num x)
avalia' (Add e1 e2) = (Num (f (avalia' e1) (avalia' e2)))
  where f (Num x) (Num y) = x + y
avalia' (Sub e1 e2) = (Num (f (avalia' e1) (avalia' e2)))
  where f (Num x) (Num y) = x - y
avalia' (And e1 e2) = (Num (f (avalia' e1) (avalia' e2)))
  where f (Num x) (Num y) = if x*y == 0 then 0 else 1
avalia' (Or e1 e2) = if f (avalia' (Add (avalia' (And e1 (Num 1))) (avalia' (And e2 (Num 1))))) == 0 then (Num 0) else (Num 1)
  where f (Num x) = x
avalia' (Not (Num x)) = if x == 0 then (Num 1) else (Num 0)


main = print (avalia' e6)