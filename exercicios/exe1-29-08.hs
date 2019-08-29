--lista de inteiros
xs::[Int] 
xs = [1,2,3,4,5,6,7,8,9,10]

-- funcao incremento
inc:: Int -> Int
inc x = x + 1

--funcao duplica inteiro
duplica::Int->Int
duplica x = 2*x

-- funcao duplica lista
dups::[Int]->[Int]
dups lista = map duplica lista

--funcao que retorna o menor valor da lista
menor::[Int]->Int
menor lista = minimum lista

--lista de pares de xs
pares::[Int]
pares = filter even xs 

-- lista de incrementos de xs
incs::[Int]
incs = map inc xs 

-- maior valor de xs
maior::Int
maior = maximum xs

main = print (menor xs)