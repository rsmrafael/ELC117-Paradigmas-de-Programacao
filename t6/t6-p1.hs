-- Rafael Sebastião Miranda - 15/09/2015
-- Paradigmas de Programação - Trabalho final de Haskell
-- Parte 1

import Text.Printf

type Point     = (Float,Float)
type Rect      = (Point,Float,Float)

-- Definição de Constantes
hue = 120       -- Matiz Base
nLines = 9      -- Número de Linhas
nColumns = 5    -- Número de Colunas
hRect = 14      -- Altura do Retângulo
wRect = 33      -- Largura do Retângulo
gap = 2         -- Espaço entre Retângulos
edge = 4        -- Bordas
bgHue = 0       -- Matiz do Plano de Fundo
bgSat = 0       -- Saturação do Plano de Fundo
bgLig = 50      -- Luminosidade do Plano de Fundo

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

chooseColor :: (Float,Float) -> (Float,Float,Float)
chooseColor (x,y) = (hue,100.0-(x*100.0/(nColumns-1.0)),100.0-(y*100.0/(nLines-1.0)))

main :: IO ()
main = do
   let
      rects = [(getStyle (chooseColor (x,y)),((x*(wRect+gap)+edge,y*(hRect+gap)+edge),wRect,hRect))|
         x<-[0.0..(nColumns-1.0)],y<-[0.0..(nLines-1.0)]]
      w = edge*2+(nColumns*(wRect+gap)-gap)
      h = edge*2+(nLines*(hRect+gap)-gap)
      background = (getStyle(bgHue,bgSat,bgLig),((0.0,0.0),w,h))
   writeFile "colors.svg" (writeRects w h (background:rects))
