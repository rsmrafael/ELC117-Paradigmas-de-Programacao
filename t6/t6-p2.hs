-- Rafael Sebastião Miranda - 15/09/2015
-- Paradigmas de Programação - Trabalho final de Haskell
-- Parte 2

import Text.Printf

type Point     = (Float,Float)
type Rect      = (Point,Float,Float)

-- Definição de Constantes
hueInit = 240    -- Matiz Base
nHues = 14       -- Número de Matizes
nLines = 9       -- Número de Linhas em cada paleta
nColumns = 5     -- Número de Colunas em cada paleta
hRect = 14       -- Altura dos Retângulos
wRect = 33       -- Largura dos Retângulos
gapRect = 2      -- Espaço entre Retângulos
gapTables = 15   -- Espaço entre paletas
edge = 20        -- Bordas
bgHue = 0        -- Matiz do Plano de Fundo
bgSat = 0        -- Saturação do Plano de Fundo
bgLig = 50       -- Luminosidade do Plano de Fundo

-- Gera retangulo SVG 
-- a partir de coordenadas+dimensoes e de uma string com atributos de estilo
writeRect :: (String,Rect) -> String 
writeRect (style,((x,y),w,h)) = 
   printf "<rect x='%.3f' y='%.3f' width='%.2f' height='%.2f' style='%s' />\n" x y w h style

-- Gera codigo-fonte de arquivo SVG 
-- concatenando uma lista de retangulos e seus atributos de estilo
writeRects :: Float -> Float -> [(String,Rect)] -> String 
writeRects w h rs = 
   printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 
   ++ (concatMap writeRect rs) ++ "</svg>"

getStyle :: (Float,Float,Float) -> String   
getStyle (h,s,l) = 
   printf "fill:hsl(%.2f, %.2f%%, %.2f%%)" h s l
-- fonte auxiliar: "https://hackage.haskell.org/package/base-4.8.1.0/docs/Text-Printf.html"

chooseColor :: Float -> (Float,Float) -> (Float,Float,Float)
chooseColor hue (x,y) = (hue,100.0-(x*100.0/((fromIntegral nColumns)-1.0)),100.0-(y*100.0/((fromIntegral nLines)-1.0)))

getTable :: Float -> (Float,Float) -> [(String,Rect)]
getTable hue (xOffset,yOffset) = [(
   getStyle (chooseColor hue (x,y)), -- String
   ((x*(wRect+gapRect)+xOffset,y*(hRect+gapRect)+yOffset),wRect,hRect) --Rect
   ) | x<-[0.0..((fromIntegral nColumns)-1.0)] , y<-[0.0..((fromIntegral nLines)-1.0)] ]
   
main :: IO ()
main = do
   let
      -- fonte auxiliar "http://zvon.org/other/haskell/Outputprelude/index.html"
      columnsOfTables = fromIntegral (ceiling (sqrt nHues)) 
      linesOfTables = fromIntegral (ceiling (nHues/columnsOfTables))
      tableWidth = (fromIntegral nColumns)*(wRect+gapRect)-gapRect
      tableHeigth = (fromIntegral nLines)*(hRect+gapRect)-gapRect
      auxList = [ getTable 
         (hueInit+(x+y*columnsOfTables)*360/nHues) -- color
         (edge+x*(tableWidth+gapTables),edge+y*(tableHeigth+gapTables)) -- offset
         | y<-[0.0..(linesOfTables-1.0)] , x<-[0.0..(columnsOfTables-1.0)]]
      rects = concat (take (round nHues) auxList)
      w = edge*2+columnsOfTables*tableWidth+(columnsOfTables-1)*gapTables
      h = edge*2+linesOfTables*tableHeigth+(linesOfTables-1)*gapTables
      background = (getStyle(bgHue,bgSat,bgLig),((0.0,0.0),w,h))  
   writeFile "colors2.svg" (writeRects w h (background:rects))
