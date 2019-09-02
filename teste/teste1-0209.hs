--definicoes

brasil19 = [("Corinthians", (8,7,2), (19,9)),("Goias", (6,3,8), (16,27)),("Flamengo", (11,3,3), (38,18)),("Gremio", (5,7,5), (20,21))]

getGols::(String, (Int, Int, Int), (Int, Int)) -> (Int, Int)
getGols (nome, ved, gols) = gols

-- q1
getNomes::(String, (Int, Int, Int), (Int, Int)) -> String
getNomes (nome, ved, gols) = nome

nomes::[String]
nomes = map getNomes brasil19

-- q2
calcularPontos::(Int, Int, Int) -> Int
calcularPontos (v, e, d) = 3*v + e

listarPontos::(String, (Int, Int, Int), (Int, Int))->(String, Int)
listarPontos (n, ved, gols) = (n, calcularPontos ved)

pontos::[(String, Int)]
pontos = map listarPontos brasil19

-- q3

saldo::(String, (Int, Int, Int), (Int, Int)) -> Bool
saldo (n, ved, (gp, gc)) = if gp > gc then True else False

positivos::[(String, (Int, Int, Int), (Int, Int))] -> [(String, (Int, Int, Int), (Int, Int))]
positivos tabela = filter saldo tabela 

-- q4

filterN::[(String, Int)] -> Int -> [(String, Int)]
filterN tabela num = filter (\(s, n)-> n > num) tabela

getStr:: (String, Int) -> String
getStr (s, n) = s

maisN::[(String, (Int, Int, Int), (Int, Int))] -> Int -> [String]
maisN tabela n = map getStr (filterN (map listarPontos tabela) n)

-- q5

campeao::(String, Int)
campeao = foldr (\(s1, n1) (s2, n2) -> if n1 > n2 then (s1, n1) else (s2, n2)) ("",0) pontos

-- q6

nJogos::(String, (Int, Int, Int), (Int, Int)) -> Int
nJogos (s, (v ,e ,d), gols) = v + e + d

totalJogos::[(String, (Int, Int, Int), (Int, Int))] -> Int
totalJogos tabela = foldr (+) 0 (map nJogos tabela)

nGols::(String, (Int, Int, Int), (Int, Int)) -> Int
nGols (s, ved, (gp, gc)) = gp

totalGols::[(String, (Int, Int, Int), (Int, Int))] -> Int
totalGols tabela = foldr (+) 0 (map nGols tabela)

mediaGols::[(String, (Int, Int, Int), (Int, Int))] -> Float
mediaGols tabela = fromIntegral(2*(totalGols tabela))/fromIntegral(totalJogos tabela)

main = print (maisN brasil19 30)