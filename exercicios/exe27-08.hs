bandas :: [[String]]
bandas = [["Gilberto Gil"],["Victor","Leo"],["Gonzagao"],["Claudinho","Bochecha"]]

musicas :: [(String, Int, Int)]
musicas = [("Aquele Abraco", 1, 100),("Esperando na Janela", 1, 150),("Borboletas", 2, 120),("Asa Branca", 3, 120),("Assum Preto", 3, 140),("Vem Morena", 3, 200),("Nosso Sonho", 4, 150),("Quero te Encontrar", 4, 100)]

--Ex1
nomem :: (String, Int, Int) -> String
nomem (s,x,y) = s

--Ex3
tempom :: (String, Int, Int) -> Int
tempom (s,x,y) = y

tempos = map tempom musicas
tempo_maximo = maximum tempos

--Ex4
listaTupleEx4 = filter (\(_,_,a) -> a >= 120) musicas
listaEx4 = map nomem listaTupleEx4

--Ex5
--bandaCvt :: [String] -> String
--bandaCvt str = str

--autor:: Int -> String
--autor x = 

--prettyprint :: (String, Int, Int) -> String
--prettyprint (s,x,y) = "Duracao:"

-- Exercicio 1
-- main = print (map nomem musicas)

-- Exercicio 2
-- main = print (filter (\(_,_,a) -> a >= 120) musicas)

-- Exercicio 3
--main = print tempo_maximo

--Exercicio 4
--main = print listaEx4