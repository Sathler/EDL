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

--parte 1

c0 = Atr "x" (Num 1)
c1 = Atr "x" (Sub (Add (Num 1) (Var "x")) (Num 20))
c2 = Seq (Atr "x" (Num 1)) (Seq (Atr "y" (Num 2)) (Atr "z" (Add (Var "x") (Var "y"))))

--parte 2

--c0 = Atr "x" (Add (Num 1) (Num 2))
--Resposta: x = 1 + 2 -- (valor final x=3)

--c1 = Seq (Atr "x" (Num 10)) (Atr "x" (Num 1))
--Resposta x = 10; x=1;

--c2 = Seq (Atr "x" (Num 1)) (Seq (Atr "y" (Add (Var "x") (Num 1))) (Atr "x" (Var "y")))
--resposta x=1; y=x+1; x = y;

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

main = print (avaliaCmd memoria (Seq c0 c1))