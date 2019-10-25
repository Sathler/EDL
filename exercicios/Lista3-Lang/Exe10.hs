data Cmd = Atr String Exp   -- atribuicao, ex.: x=1
         | Seq Cmd Cmd
         | Cnd Exp Cmd Cmd
         | Rep Exp Cmd
  deriving Show      -- sequencia,  ex.: x=1 ; y=x

data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | Var String
  deriving Show

type Mem = [(String,Int)]
memoria = []

c0 = Atr "x" (Num 1)
c1 = Atr "x" (Sub (Add (Num 1) (Var "x")) (Num 20))
c2 = Seq (Atr "x" (Num 1)) (Seq (Atr "y" (Num 2)) (Atr "z" (Add (Var "x") (Var "y"))))
c3 = Cnd (Num 1) (Atr "x" (Num 1)) (Atr "x" (Num 2))
c4 = Seq (Atr "x" (Num 0)) (Rep (Var "x") (Atr "x" (Sub (Var "x") (Num 1))))

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
avaliaCmd m (Cnd e1 c1 c2) = if avaliaExp m e1 /= 0 then avaliaCmd m c1 else avaliaCmd m c2
avaliaCmd m (Rep e1 c1) = if avaliaExp m e1 /= 0 then m else avaliaCmd (avaliaCmd m c1) (Rep e1 c1) 

main = print (avaliaCmd [] c4)