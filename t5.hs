-- Exercício 1

addSuffix :: String -> [String] -> [String]
addSuffix suf ls = [s++suf|s<-ls]

-- Exercício 2

addSuffixRec :: String -> [String] -> [String]
addSuffixRec _ [] = [] 
addSuffixRec suf (s:sx) = (s++suf):(addSuffixRec suf sx)

-- Exercício 3

countShortsRec :: [String] -> Int
countShortsRec [] = 0
countShortsRec (s:sx) = resp + countShorts sx
   where resp = if (length s) < 5 then 1 else 0
   
-- Exercício 4

countShorts :: [String] -> Int
countShorts ls = length [s | s <- ls, length s < 5]

-- Exercício 5

ciclo :: Int -> [Int] -> [Int]
ciclo 0 _ = []
ciclo n ls = ls ++ (ciclo (n-1) ls)

-- Exercício 6

combine :: [Int] -> [String] -> [(Int,String)]
combine [] [] = []
combine (d:dx) [] = (d,"") : combine dx []
combine [] (s:sx) = (undefined,s) : combine [] sx
combine (d:dx) (s:sx) = (d,s) : combine dx sx

-- Exercício 7

numera :: [String] -> [(Int,String)]
numera ls = numeraAux 1 ls

numeraAux :: Int -> [String] -> [(Int,String)]
numeraAux _ [] = []
numeraAux n (s:sx) = (n,s) : numeraAux (n+1) sx

-- Exercício 8

-- a) [ (x,y) | x <[1..5], even x, y <[(x + 1)..6], odd y ]
-- Cria uma lista de tuplas, cujos primeiros valores são os números pares 
-- de 1 a 5 e os segundos são os números ímpares entre o primeiro valor e 6
-- i.e. [(2,3),(2,5),(4,5)]

-- b)[ a ++ b | a <["lazy","big"], b <["frog", "dog"]]
-- Cria uma lista de 4 string, onde estas são as combinações entre strings
-- "lazy" e "big" com "frog" e "dog"
-- i.e ["lazyfrog","lazydog","bigfrog","bigdog"]

-- c) concat [ [a,'']| a <"paralelepipedo", a `elem` "aeiou"]
-- Cria uma String com as vogais de "paralelepipedo" separadas e terminando 
-- com hífen
-- i.e. "a-a-e-e-i-e-o-"

-- Exercício 9

crossProduct :: [a] -> [b] -> [(a,b)] 
crossProduct x y = concat (map (\z -> pairWithAll z y) x)

pairWithAll :: a -> [b] -> [(a,b)]
pairWithAll _ [] = []
pairWithAll x (y:ys) = (x,y) : pairWithAll x ys

-- Exercício 10

genRects :: Int -> (Int,Int) -> [(Float,Float,Float,Float)]
genRects n (x,y) = [(px,fromIntegral y,5.5,5.5)|px<-xises]
   where xises = map (\z -> fromIntegral x + z*5.5) [0.0 .. fromIntegral (n-1)]

-- Exercício 11

funcRec :: [(a,b)] -> ([a],[b])
funcRec [] = ([],[])
funcRec (x:xs) = case funcRec xs of
   ([],[]) -> ([fst x],[snd x])
   (ls1,ls2) -> (fst x : ls1, snd x : ls2)
   
-- Exercício 12

funcLC :: [(a,b)] -> ([a],[b])
funcLC ls = ([fst x | x <- ls],[snd x | x <- ls])

-- Exercício 13

func :: [(a,b)] -> ([a],[b])
func ls = (map (fst) ls, map (snd) ls)
