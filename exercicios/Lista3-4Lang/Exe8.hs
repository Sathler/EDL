data Cmd = Atr String Exp   -- atribuicao, ex.: x=1
         | Seq Cmd Cmd
  deriving Show      -- sequencia,  ex.: x=1 ; y=x

data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | Var String
  deriving Show

type Mem = [(String,Int)]
memoria = []

avaliaExp :: Mem -> Exp -> Int
avaliaExp m (Num x) = x
avaliaExp m (Add e1 e2) = (avaliaExp m e1) + (avaliaExp m e2)
avaliaExp m (Sub e1 e2) = (avaliaExp m e1) - (avaliaExp m e2)
avaliaExp m (Var s) = f m s
  where f ((n, x):l) s = if n == s then x else f l s
        f [] s = 0

avaliaCmd :: Mem -> Cmd -> Mem
avaliaCmd m (Atr s n) = ((s, (avaliaExp m n)):m)
avaliaCmd m (Seq c1 c2) = (avaliaCmd (avaliaCmd m c1) c2)

avaliaPrg:: Cmd -> Int
avaliaPrg c0 = avaliaExp (avaliaCmd [] c0) (Var "ret")

c1 = Seq (Atr "x" (Num 1)) (Seq (Atr "y" (Num 2)) (Seq (Atr "z" (Add (Var "x") (Var "y"))) (Atr "ret" (Num 1))))

main = print (avaliaPrg c1)