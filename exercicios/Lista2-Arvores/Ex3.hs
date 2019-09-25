data Arvore = Folha Int | Galho Arvore Arvore
  deriving Show

a1 = Galho (Galho (Folha 1) (Folha 2)) (Galho (Folha 3) (Folha 4))
a2 = Galho (Galho (Galho (Folha 1) (Folha 2)) (Folha 3)) (Folha 4)
a3 = Galho (Folha 1) (Galho (Galho (Folha 2) (Folha 3)) (Galho (Folha 4) (Folha 5)))

folhas :: Arvore -> Int
folhas (Folha _) = 1
folhas (Galho a1 a2) = folhas a1 + folhas a2

altura :: Arvore -> Int
altura (Folha _) = 0
altura (Galho a1 a2) = 1 + (max (altura a1) (altura a2))

espelho :: Arvore -> Arvore
espelho (Folha x) = (Folha x)
espelho (Galho a1 a2) = (Galho (espelho a2) (espelho a1))

soma :: Arvore -> Int
soma (Folha x) = x
soma (Galho a1 a2) = (soma a1) + (soma a2)

dobra :: Arvore -> Arvore
dobra (Folha x) = (Folha (2*x))
dobra (Galho a1 a2) = Galho (dobra a1) (dobra a2)

possui :: Arvore -> Int -> Bool
possui (Folha x) y = (x==y)
possui (Galho a1 a2) y = ((possui a1 y) || (possui a2 y))

maximo :: Arvore -> Int
maximo (Folha x) = x
maximo (Galho a1 a2) = max (maximo a1) (maximo a2)

main = print (maximo a3)