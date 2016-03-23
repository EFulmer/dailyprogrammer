module Challenge257 where
import qualified Data.IntMap as IntMap
import Data.Maybe (catMaybes)
import System.Environment (getArgs)
import Text.Read (readMaybe)
import Text.Regex

type Lifespan = (Int, Maybe Int)

csvSplitRE :: Regex
csvSplitRE = mkRegex ",[ t]+" 

splitCSVLine :: String -> [String]
splitCSVLine = splitRegex csvSplitRE

getLifespan :: [String] -> Maybe Lifespan -- Maybe accounts for headers
getLifespan (pres:bday:bloc:dday:dloc:[]) = do
  bday' <- readMaybe $ last4 bday
  if (not . null) dday
  then Just (bday', readMaybe $ last4 dday)
  else Just (bday', Nothing)
  where 
    last4 ss = drop (length ss - 4) ss
getLifespan _ = Nothing

lifespanToRange :: Lifespan -> [Int]
lifespanToRange (a1, Nothing) = [a1..2016]
lifespanToRange (a1, Just a2) = [a1..a2]

buildFreqTable :: [Int] -> IntMap.IntMap Int
buildFreqTable xs = acc xs IntMap.empty
  where acc (x:xs) m = if IntMap.member x m
                       then acc xs $ IntMap.adjust succ x m
                       else acc xs $ IntMap.insert x 1 m
        acc []     m = m

maxVal :: IntMap.IntMap Int -> (Int, Int) -- (numAlive, year)
maxVal m = maximum $ map swap $ IntMap.toList m
  where swap (a, b) = (b, a)

main :: IO ()
main = do
  args <- getArgs
  if length args /= 1
  then putStrLn "usage: Challenge257 [csv-name]"
  else do
    pd <- readFile $ args !! 0
    let pd' = fmap splitCSVLine (lines pd)
    let lifespans = fmap getLifespan pd'
    let lifeYears = concat $ fmap lifespanToRange (catMaybes lifespans)
    let freqTable = buildFreqTable lifeYears
    let (alive, year) = maxVal freqTable
    putStrLn $ show alive ++ " presidents were alive in " ++ show year ++ "."
