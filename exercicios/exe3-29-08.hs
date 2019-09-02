--Definicoes iniciais

bandas :: [[String]]
bandas = [ ["Gilberto Gil"],
           ["Victor","Leo"],
           ["Gonzagao"],
           ["Claudinho","Bochecha"] ]

musicas :: [(String, Int, Int)]
musicas = [ ("Aquele Abraco",       1, 100),
            ("Esperando na Janela", 1, 150),
            ("Borboletas",          2, 120),
            ("Asa Branca",          3, 120),
            ("Assum Preto",         3, 140),
            ("Vem Morena",          3, 200),
            ("Nosso Sonho",         4, 150),
            ("Quero te Encontrar",  4, 100) ]

-- funcoes retornam valor unico

nomeMusica:: (String, Int, Int) -> String
nomeMusica (s,a,b) = s

autorIdMusica:: (String, Int, Int) -> Int
autorIdMusica (s,a,b) = a

duracaoMusica:: (String, Int, Int) -> Int
duracaoMusica (s,a,b) = b

-- valor 1
nomeMusicas::[String]
nomeMusicas = map nomeMusica musicas

--valor 2
musicasLongas::[(String, Int, Int)]
musicasLongas = filter (\(s,a,b) -> b>= 120) musicas

--valor 3

duracaoMaxima::Int
--usando a funcao maximum
--duracaoMaxima = maximum (map duracaoMusica musicas)
--usando fold
duracaoMaxima = foldr (\x y -> if x > y then x else y) 0 (map duracaoMusica musicas)

--valor 4
nomesMusicasLongas::[String]
nomesMusicasLongas = map nomeMusica musicasLongas

--Pretty
getAutor::[String] -> String
getAutor autor = foldr (\x y -> concat[x,", ",y]) "" autor

linha::(String, Int, Int) -> String
linha (s, a, b) = "Nome: " ++ s ++ "\nAutores: "++ (getAutor (bandas !! (a-1))) ++ "\nDuracao: "++ (show b)

pretty::[(String, Int, Int)] -> String
pretty lista = foldr (\x y -> concat[x,"\n-------------------------\n", y]) "" (map linha lista)

--Duracao: 120

main= putStrLn (pretty musicas)