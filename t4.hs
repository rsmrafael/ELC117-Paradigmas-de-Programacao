-- Exercício 1

eleva2 :: [Int] -> [Int]
eleva2 [] = []
eleva2 (x:xs) = x^2 : eleva2 xs

-- Exercício 2

contido :: Char -> String -> Bool
contido _ [] = False
contido c (s:sx) = (c==s) || contido c sx

-- Exercício 3

