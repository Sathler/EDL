data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | Equal Exp Exp
         | Greater Exp Exp
         | GreaterEqual Exp Exp
         | Less Exp Exp
         | LessEqual Exp Exp
  deriving Show

e0 = Num 1
e1 = Sub (Add (Num 1) (Num 10)) (Num 20)
e2 = Add (Num 1) (Sub (Num 10) (Num 20))
e3 = Sub (Add (Num 5) (Num 5)) (Sub (Num 5) (Num 5))
e4 = Add (Num 2) (Num 1)
e5 = LessEqual (Num 2) (Num 1)

avalia :: Exp -> Int
avalia (Num x) = x
avalia (Add e1 e2) = avalia e1 + avalia e2
avalia (Sub e1 e2) = avalia e1 - avalia e2
avalia (Equal e1 e2) = if (avalia e1) == (avalia e2) then 1 else 0
avalia (Greater e1 e2) = if (avalia e1) > (avalia e2) then 1 else 0
avalia (GreaterEqual e1 e2) = if (avalia e1) >= (avalia e2) then 1 else 0
avalia (Less e1 e2) = if (avalia e1) < (avalia e2) then 1 else 0
avalia (LessEqual e1 e2) = if (avalia e1) <= (avalia e2) then 1 else 0

avalia' :: Exp -> Exp
avalia' (Num x) = (Num x)
avalia' (Add e1 e2) = (Num (f (avalia' e1) (avalia' e2)))
  where f (Num x) (Num y) = x + y
avalia' (Sub e1 e2) = (Num (f (avalia' e1) (avalia' e2)))
  where f (Num x) (Num y) = x - y
avalia' (Equal e1 e2) = if f (avalia' e1) (avalia' e2) then (Num 1) else (Num 0)
  where f (Num x) (Num y) = x == y
avalia' (Greater e1 e2) = if f (avalia' e1) (avalia' e2) then (Num 1) else (Num 0)
  where f (Num x) (Num y) = x > y
avalia' (GreaterEqual e1 e2) = if f (avalia' e1) (avalia' e2) then (Num 1) else (Num 0)
  where f (Num x) (Num y) = x >= y
avalia' (Less e1 e2) = if f (avalia' e1) (avalia' e2) then (Num 1) else (Num 0)
  where f (Num x) (Num y) = x < y
avalia' (LessEqual e1 e2) = if f (avalia' e1) (avalia' e2) then (Num 1) else (Num 0)
  where f (Num x) (Num y) = x <= y

main = print (avalia' e5)