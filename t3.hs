import Data.List (elemIndex)

-- Exercício 1

isEven :: Int -> Bool
isEven n = mod n 2 == 0

-- mod retorna o resto da divisão do primeiro número pelo segundo 

-- Exercício 2 

somaquad :: Int -> Int -> Int
somaquad c1 c2 = c1^2 + c2^2 

-- Exercício 3

doubleFirst :: [Int] -> Int
doubleFirst x = (head x)^2 

-- Exercício 4

hasEqHeads :: [Int] -> [Int] -> Bool
hasEqHeads l1 l2 = head l1 == head l2

-- Exercício 5

addMr :: [String] -> [String]
addMr ls = map ("Mr. "++) ls

-- Exercício 6

contaSpc :: String -> Int
contaSpc s = length (filter (==' ') s)

-- Exercício 7

calcFunc :: [Double] -> [Double]
calcFunc ls = map (\x -> (3*x^2 + 2/x + 1)) ls

-- Exercício 8 

novos :: [Int] -> [Int]
novos ls = filter (<(2015-1970)) ls

-- Exercício 9

serie :: Double -> [Double] -> Double
serie m ls = sum (map (/m) ls)

-- Exercício 10

charFound :: Char -> String -> Bool
charFound c s = not(null (filter (==c) s))

-- Exercício 11

htmlListItems :: [String] -> [String]
htmlListItems ls = map (\s -> "<LI>" ++ s ++ "<LI>") ls

-- Exercício 12

-- Havia entendido mal a questão e criei meu próprio takewhile
newTakeWhile :: (a -> Bool) -> [a] -> [a]
newTakeWhile func ls = case elemIndex False ( map func ls) of
   Just n -> take n ls
   Nothing -> ls

-- Exemplos
-- takewhile (< 5) [1,2,3,4,5]
-- [1,2,3,4]
-- takewhile (/=' ') "Fulana de Tal"
-- "Fulana"
-- takewhile (\s -> length s > 5) ["Rafael","Jeferson","Igor","Emilio"]
-- ["Rafael","Jeferson"]

-- Exercício 13

lazaro :: [String] -> [String]
lazaro ls = filter (\s -> last s == 'a') ls
