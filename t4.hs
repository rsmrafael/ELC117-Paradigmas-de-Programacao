import Data.Char (toLower)

-- Exercício 1

eleva2 :: [Int] -> [Int]
eleva2 [] = []
eleva2 (x:xs) = x^2 : eleva2 xs

-- Exercício 2

contido :: Char -> String -> Bool
contido _ [] = False
contido c (s:sx) = (c==s) || contido c sx

-- Exercício 3

semVogais :: String -> String
semVogais [] = []
semVogais (c:cx) = if (toLower c=='a') || (toLower c=='e') || (toLower c=='i') || (toLower c=='o') || (toLower c=='u')
   then semVogais cx
   else c : semVogais cx
   
-- Exercício 4

translate :: [(Double,Double)] -> [(Double,Double)]
translate [] = []
translate ((p1,p2):tx) = (p1+2,p2+2) : translate tx

-- Exercício 5

geraTabela' :: Int -> [(Int,Int)]
geraTabela' 1 = [(1,1)]
geraTabela' n = if n>1
   then geraTabela' (n-1) ++ [(n,n^2)]
   else undefined
