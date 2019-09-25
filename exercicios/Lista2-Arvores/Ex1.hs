data Arvore = Folha | Galho Arvore Arvore
  deriving Show


a1 = Galho (Galho Folha Folha) (Galho Folha Folha)
a2 = Galho (Galho (Galho Folha Folha) Folha) Folha
a3 = Galho Folha (Galho (Galho Folha Folha) (Galho Folha Folha))

--Ex1
folhas :: Arvore -> Int
folhas Folha = 1
folhas (Galho a1 a2) = folhas a1 + folhas a2

altura :: Arvore -> Int
altura Folha = 0
altura (Galho a1 a2) = 1 + (max (altura a1) (altura a2))

espelho :: Arvore -> Arvore
espelho Folha = Folha
espelho (Galho a1 a2) = (Galho (espelho a2) (espelho a1))

main = print (a2, espelho a2)