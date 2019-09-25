data Arvore = Folha | Galho Int Arvore Arvore
  deriving Show

a1 = Galho 2 (Galho 1 Folha Folha) (Galho 3 Folha Folha)
a2 = Galho 5 (Galho 4 (Galho 3 Folha Folha) Folha) Folha
a3 = Galho 5 Folha (Galho 7 (Galho 6 Folha Folha) (Galho 8 Folha Folha))

folhas :: Arvore -> Int
folhas Folha = 1
folhas (Galho _ a1 a2) = folhas a1 + folhas a2

altura :: Arvore -> Int
altura Folha = 0
altura (Galho _ a1 a2) = 1 + (max (altura a1) (altura a2))

espelho :: Arvore -> Arvore
espelho Folha = Folha
espelho (Galho x a1 a2) = (Galho x (espelho a2) (espelho a1))

soma :: Arvore -> Int
soma Folha = 0
soma (Galho x a1 a2) = x + (soma a1) + (soma a2)

dobra :: Arvore -> Arvore
dobra Folha = Folha
dobra (Galho x a1 a2) = Galho (2*x) (dobra a1) (dobra a2)

possui :: Arvore -> Int -> Bool
possui Folha _ = False
possui (Galho x a1 a2) y = if (x == y) then True else (if x < y then (possui a2 y) else (possui a1 y))

maximo :: Arvore -> Int
maximo Folha = 0
maximo (Galho x a1 a2) = max x (maximo a2)

insere :: Arvore -> Int -> Arvore
insere Folha y = (Galho y Folha Folha)
insere (Galho x a1 a2) y = if y>x then (Galho x a1 (insere a2 y)) else (Galho x (insere a1 y) a2)

main = print (insere a3 4)