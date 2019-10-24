data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | Mul Exp Exp
         | Div Exp Exp
  deriving Show

e0 = Num 1
e1 = Sub (Add (Num 1) (Num 10)) (Num 20)
e2 = Add (Num 1) (Sub (Num 10) (Num 20))
e3 = Sub (Add (Num 5) (Num 5)) (Sub (Num 5) (Num 5))
e4 = Add (Num 2) (Num 1)
e5 = Mul (Num 5) (Div (Num 5) (Num 2))

avalia :: Exp -> Int
avalia (Num x) = x
avalia (Add e1 e2) = avalia e1 + avalia e2
avalia (Sub e1 e2) = avalia e1 - avalia e2
avalia (Mul e1 e2) = avalia e1 * avalia e2
avalia (Div e1 e2) = div (avalia e1) (avalia e2)

avalia' :: Exp -> Exp
avalia' (Num x) = (Num x)
avalia' (Add e1 e2) = (Num (f (avalia' e1) (avalia' e2)))
  where f (Num x) (Num y) = x + y
avalia' (Sub e1 e2) = (Num (f (avalia' e1) (avalia' e2)))
  where f (Num x) (Num y) = x - y
avalia' (Mul e1 e2) = (Num (f (avalia' e1) (avalia' e2)))
  where f (Num x) (Num y) = x * y
avalia' (Div e1 e2) = (Num (f (avalia' e1) (avalia' e2)))
  where f (Num x) (Num y) = div x y

main = print (avalia e5)