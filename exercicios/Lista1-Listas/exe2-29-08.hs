turma1 :: [ (String,Float,Float) ]
turma1 = [ ("Joao",7.5,3.5), ("Maria",10.0,8.0), ("Jose",5.0,3.0), ("Dennis", 0.5, 9.0)]

nome :: (String,Float,Float) -> String
nome (nm,_,_) = nm

nota1 :: (String,Float,Float) -> Float
nota1 (_,n1,_) = n1

nota2 :: (String,Float,Float) -> Float
nota2 (_,_,n2) = n2

media :: (String,Float,Float) -> Float
media aluno = ((nota1 aluno) + (nota2 aluno)) / 2

medias :: [ (String,Float,Float) ] -> [Float]
medias turma = map media turma

--funcao que retorna a media de uma lista de floats
media_da_lista::[Float] -> Float
media_da_lista lista = (foldr (+) 0.0 lista)/fromIntegral(length lista)

-- Lista das primeiras notas da turma
notas1::[Float]
notas1 = map nota1 turma1

-- Lista das segundas notas da turma
notas2::[Float]
notas2 = map nota2 turma1 

--funcao que retorna todos os alunos que tiraram acima de 8
oitos::[(String,Float,Float)]->[String]
oitos lista = map nome (filter (\(_,_,n2)->n2>=8)(filter (\(_,n1,_)->n1>=8) lista))

--funcao que retorna a media de todas as notas da turma (p1, p2, media)
todas :: [(String,Float,Float)] -> (Float, Float, Float)
todas turma = (media_da_lista(map nota1 turma),media_da_lista(map nota2 turma), media_da_lista(map media turma1))

--lista de notas abaixo de 5 da turma
baixas:: [Float]
baixas =  filter (<=5.0) (notas1 ++ notas2)

--funcao que retorna a situacao do aluno
situacao::(String, Float, Float) -> String
situacao aluno = if (media aluno) >= 5.0 then "Aprovado" else "Reprovado"

linha::(String, Float, Float) -> String
linha aluno = (nome aluno) ++" "++ show (media aluno) ++ " (" ++ (situacao aluno) ++ ")"

pretty :: [ (String,Float,Float) ] -> String
pretty turma = foldr (\x y -> concat [x,"\n",y]) " " (map linha turma)

main = putStrLn (pretty turma1)