data Cmd = Atr String Exp
         | Seq [Cmd]
  deriving Show      -- sequencia,  ex.: x=1 ; y=x

data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | Var String
  deriving Show

type Mem = [(String,Int)]
memoria = []

c0 = Atr "x" (Num 1)
c1 = Atr "y" (Num 2)
c2 = Atr "z" (Add (Var "x") (Var "y"))

avaliaExp :: Mem -> Exp -> Int
avaliaExp m (Num x) = x
avaliaExp m (Add e1 e2) = (avaliaExp m e1) + (avaliaExp m e2)
avaliaExp m (Sub e1 e2) = (avaliaExp m e1) - (avaliaExp m e2)
avaliaExp m (Var s) = f m s
  where f ((n, x):l) s = if n == s then x else f l s
        f [] s = 0

avaliaCmd :: Mem -> Cmd -> Mem
avaliaCmd m (Atr s n) = ((s, (avaliaExp m n)):m)
avaliaCmd m (Seq (c1:l)) = (avaliaCmd (avaliaCmd m c1) (Seq l))
avaliaCmd m (Seq []) = m

lista = [c0, c1, c2]

main = print (avaliaCmd memoria (Seq lista))