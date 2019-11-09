data Cmd = Atr String Exp   -- atribuicao, ex.: x=1
         | Seq Cmd Cmd      -- sequencia,  ex.: x=1 ; y=x
         | Dcl String       -- declaracao, ex.: int x
    deriving Show

data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | Var String
    deriving Show

type Mem = [(String,Int)]

verificaExp :: [String] -> Exp -> Bool
verificaExp [] (Var str) = False
verificaExp lista (Var str) = if (head lista) == str then True else verificaExp (tail lista) (Var str)
verificaExp lista (Sub exp1 exp2) = (verificaExp lista exp1) && (verificaExp lista exp2)
verificaExp lista (Add exp1 exp2) = (verificaExp lista exp1) && (verificaExp lista exp2)
verificaExp lista (Num x) = True

verificaCmd :: [String] -> Cmd -> ([String],Bool)
verificaCmd lista (Dcl str) = ((str:lista), True)
verificaCmd list (Atr str exp) = (list, ((func list str) && (verificaExp list exp)))
    where func [] s = False
          func l s = if s == (head l) then True else func (tail l) str
verificaCmd lista (Seq cmd1 cmd2) = (l2, b1 && b2)
    where (l1, b1) = (verificaCmd lista cmd1)
          (l2, b2) = (verificaCmd l1 cmd2)

verificaProg :: Cmd -> Bool
verificaProg cmd = b
    where (l , b) = verificaCmd [] cmd

avaliaExp:: Mem -> Exp -> Int
avaliaExp m (Num x) = x
avaliaExp m (Add exp1 exp2) = (avaliaExp m exp1) + (avaliaExp m exp2)
avaliaExp m (Sub exp1 exp2) = (avaliaExp m exp1) - (avaliaExp m exp2)
avaliaExp [] (Var str) = 0
avaliaExp ((var, x):m) (Var str) = if var == str then x else avaliaExp m (Var str)

avaliaCmd:: Mem -> Cmd -> Mem
avaliaCmd m (Atr str exp) = (str, (avaliaExp m exp)):m
avaliaCmd m (Dcl str) = m
avaliaCmd m (Seq c1 c2) = avaliaCmd (avaliaCmd m c1) c2

avaliaProg :: Cmd -> Maybe Int
avaliaProg cmd = if (verificaProg cmd) then Just (avaliaExp (avaliaCmd [] (eliminaDcl cmd)) (Var "ret")) else Nothing

eliminaDcl :: Cmd -> Cmd
eliminaDcl (Atr x y) = (Atr x y)
eliminaDcl (Seq (Dcl str) c2) = eliminaDcl c2
eliminaDcl (Seq c1 (Dcl str)) = eliminaDcl c1
eliminaDcl (Seq c1 c2) = (Seq (eliminaDcl c1) (eliminaDcl c2))
eliminaDcl cmd = error $ show cmd

c1 = (Dcl "x")
c2 = (Dcl "y")
c3 = (Dcl "ret")
c4 = (Atr "x" (Num 4))
c5 = (Atr "y" (Num 9))
c6 = (Atr "ret" (Add (Var "x") (Var "y")))
c7 = (Seq c1 (Seq c2 (Seq c3 (Seq c4 (Seq c5 c6)))))

main = print (avaliaProg c7)