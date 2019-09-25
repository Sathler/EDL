data Arvore a = Folha | Galho a (Arvore a) (Arvore a)
  deriving Show

a1 = Galho 2 (Galho 1 Folha Folha) (Galho 3 Folha Folha)
a2 = Galho 5 (Galho 4 (Galho 3 Folha Folha) Folha) Folha
a3 = Galho 5 Folha (Galho 7 (Galho 6 Folha Folha) (Galho 8 Folha Folha))
a4 = Galho "batata-frita" (Galho "arroz" Folha Folha) (Galho "feijao" Folha Folha)

folhas :: Arvore a -> Int
folhas Folha = 1
folhas (Galho _ a1 a2) = folhas a1 + folhas a2

altura :: Arvore a -> Int
altura Folha = 0
altura (Galho _ a1 a2) = 1 + (max (altura a1) (altura a2))

espelho :: Arvore a -> Arvore a
espelho Folha = Folha
espelho (Galho x a1 a2) = (Galho x (espelho a2) (espelho a1))

--apenas tipos numericos podem ser somados
soma :: Num a => Arvore a -> a
soma Folha = 0
soma (Galho x a1 a2) = x + (soma a1) + (soma a2)

--apenas tipos numericos podem ser somados
dobra :: Num a => Arvore a -> Arvore a
dobra Folha = Folha
dobra (Galho x a1 a2) = Galho (2*x) (dobra a1) (dobra a2)

--apenas tipos que possam ser ordenados podem ser passados para a funcao possui
possui :: Ord a => Arvore a -> a -> Bool
possui Folha _ = False
possui (Galho x a1 a2) y = if (x == y) then True else (if x < y then (possui a2 y) else (possui a1 y))

maximo :: Num a => Ord a => Arvore a -> a
maximo Folha = 0
maximo (Galho x a1 a2) = max x (maximo a2)

insere :: Ord a => Arvore a -> a -> Arvore a
insere Folha y = (Galho y Folha Folha)
insere (Galho x a1 a2) y = if y>x then (Galho x a1 (insere a2 y)) else (Galho x (insere a1 y) a2)

mapA :: (a -> b) -> Arvore a -> Arvore b
mapA f Folha = Folha
mapA f (Galho x a1 a2) = (Galho (f x)(mapA f a1)(mapA f a2))


main = print (mapA even a1)