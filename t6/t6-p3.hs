-- Rafael Sebastião Miranda - 17/09/2015
-- Paradigmas de Programação - Trabalho final de Haskell
-- Parte 3a - Retângulo Rainbow
-- (Começa com uma cor e termina em outra variando o ângulo da matiz)

import Text.Printf

type Point     = (Float,Float)
type Rect      = (Point,Float,Float)

-- Definição de Constantes
c1Hue = 120.0      -- Matiz da cor 1
c1Sat = 100.0      -- Saturação da cor 1
c1Lig = 40.0       -- Luminosidade da cor 1
c2Hue = 0.0        -- Matiz da cor 2
c2Sat = 100.0      -- Saturação da cor 2
c2Lig = 30.0       -- Luminosidade da cor 2
precision = 0.1    -- Separação entre os retângulos que compõem a imagem
opacity = 0.6      -- Opacidade dos retângulos que compõem a imagem
superposition = 15 -- Número de retângulos sobrepostos
hRect = 300.0      -- Altura do Retângulo
wRect = 500.0      -- Largura do Retângulo
edge = 10.0        -- Margem
bgHue = 0.0        -- Matiz do Plano de Fundo
bgSat = 0.0        -- Saturação do Plano de Fundo
bgLig = 50.0       -- Luminosidade do Plano de Fundo

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

-- Gera estilo da imagem
getStyle :: (Float,Float,Float) -> Float -> String   
getStyle (h,s,l) opac = 
   printf "fill:hsl(%.2f, %.2f%%, %.2f%%); fill-opacity:%.2f" h s l opac
-- fonte auxiliar: "https://hackage.haskell.org/package/base-4.8.1.0/docs/Text-Printf.html"

-- Escolhe a cor baseado em um valor de 0 a 1
getColor :: Float -> (Float,Float,Float)
getColor x = (c1Hue*(1-x)+c2Hue*x,c1Sat*(1-x)+c2Sat*x,c1Lig*(1-x)+c2Lig*x)

main1 :: IO ()
main1 = do
   let
      -- fonte auxiliar "http://zvon.org/other/haskell/Outputprelude/index.html"
      lastRect = (wRect-(1+superposition)*precision) -- posição (sem margem) do último retângulo desenhado
      rects = [(getStyle (getColor (x/lastRect)) opacity,((edge+x,edge),precision*(1+superposition),hRect))| x<-[0.0,precision..lastRect]] -- Retângulos sobrepostos
      w = edge*2+wRect -- Largura da imagem
      h = edge*2+hRect -- Altura da imagem
      background = (getStyle(bgHue,bgSat,bgLig) 1,((0.0,0.0),w,h)) -- Plano de fundo 
   writeFile "colors3a.svg" (writeRects w h (background:rects)) -- Cria arquivo svg

-- --------------------------------------------------------------

-- Parte 3b - hexágono
-- Paleta passando pelo círculo de matizes, com saturação fixa, utilizando hexágonos

saturation = 100 -- Saturação fixa das cores
nHex = 50 :: Int -- Número de Hexágonos nas extremidades
aHex = 2.0 -- Aresta de cada Hexágono
minLig = 5.0 -- Luminosidade nas bordas

type Hex = (Float,Point) -- (aresta, ponto (x,y) do centro do Hex)
   
writeHex :: (String,Hex) -> String -- Escreve hexágono
writeHex (style,(a,(x,y))) = 
   printf "<polygon points= '%s' style='%s' />\n" sPoints style
   where
      sPoints = concatMap auxPrintf points -- pontos do polygon que desenha o hexágono em string 
      points = [p1,p2,p3,p4,p5,p6] -- pontos do polygon
      p1 = (bx,by) -- ponto superior esquerdo
      p2 = (bx+a,by) -- ponto superior direito
      p3 = (x+a,y) -- ponto mais a direita
      p4 = (bx+a,y+hAux) -- ponto inferior direito
      p5 = (bx,y+hAux) -- ponto inferior esquerdo
      p6 = (x-a,y) -- ponto mais a esquerda
      bx = x - 0.5*a -- (bx,by) = p1
      by = y - hAux
      hAux = a*cos(pi/6.0) -- Altura dos triângulos que formam o hexágono    
-- fonte auxiliar "http://www.w3schools.com/svg/svg_polygon.asp"

auxPrintf :: Point -> String -- função para poder usar printf com concatMap
auxPrintf (px,py) = printf "%.2f,%.2f " px py

writeHexs :: Float -> Float -> (String,Rect) -> [(String,Hex)] -> String -- escreve um arquivo svg com background e hexágonos
writeHexs w h bg hs = 
   printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 
   ++ writeRect bg ++ (concatMap writeHex hs) ++ "</svg>"

getColumn :: Point -> Int -> Int -> Int -> [(String,Hex)] -- escreve coluna de hexágonos
getColumn (cX,cY) columnSize maxSize xScale= -- (cx,cy) = centro da imagem, número de hexágonos na coluna, número de hexágonos da maior coluna, escala no eixo x 
   [(getStyle (((atan2 (x-cX) (-h*y))*180.0/pi)-90.0,saturation,getLight y) 1,(aHex,(x,cY+h*y)))
   |y<-[-((fromIntegral columnSize)-1.0)/2.0..((fromIntegral columnSize)-1.0)/2.0]]
   where
      getLight dy 
         | nHex==1 = 100 -- Singularidade
         | otherwise = 100 - (100-minLig)*(getRing dy)/(fromIntegral (nHex-1)) -- Função linear para escolher a luminosidade de acordo com o anel
      getRing dy = if  abs dy <= nInRange -- anel do hexágono
         then  fromIntegral (maxSize - columnSize)
         else  fromIntegral (maxSize - columnSize) + 0.5 + (abs dy) - nInRange
      nInRange = fromIntegral nHex - (fromIntegral columnSize)/2.0 -- número de hexágonos pertencentes ao mesmo anel /2
      h = 2*aHex*cos(pi/6.0) -- Altura dos hexágonos
      x = cX+aHex*1.5*fromIntegral(xScale*(maxSize-columnSize)) -- distância da coluna até o centro (baseado no número de hexágonos)
     
main2 :: IO ()
main2 = do
   let
      w = edge*2 + 2*(1.5*(fromIntegral nHex)-0.5)*aHex -- largura da imagem
      h = edge*2 + 2*(fromIntegral (2*nHex-1))*aHex*cos (pi/6.0) -- altura da imagem
      nColumns = nHex*2 - 1 -- Número de colunas
      hexsLeft = [getColumn (w/2.0,h/2.0) x nColumns (-1)|x<-[nHex..(nColumns-1)]] -- Colunas a esquerda do centro
      hexsRight = [getColumn (w/2.0,h/2.0) x nColumns 1|x<-[nHex..(nColumns-1)]] -- Colunas a direita do centro
      hexsCenter = getColumn (w/2.0,h/2.0) nColumns nColumns 0 -- Coluna do centro
      hexs = concat (hexsCenter:hexsRight++hexsLeft) -- Une as colunas em uma lista
      background = (getStyle(bgHue,bgSat,bgLig) 1,((0.0,0.0),w,h))  -- Plano de fundo
   writeFile "colors3b.svg" (writeHexs w h background hexs) -- Cria arquivo svg
