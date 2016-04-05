module C261E where

import Data.List  (transpose)
import Data.Maybe (catMaybes)
import Text.Read  (readMaybe)

toListOfLists :: [Int] -> Int -> [[Int]]
toListOfLists xs n = case splitAt n xs of
  (xs1, [])  -> [xs1]
  (xs1, xs2) -> xs1:(toListOfLists xs2 n)

fwdDiag :: [[a]] -> [a]
fwdDiag xs = fmap (\(i, xs) -> xs !! i) $ zip [0..] xs

revDiag :: [[a]] -> [a]
revDiag xs = fwdDiag $ reverse xs

isMagicSquare :: [Int] -> Bool
isMagicSquare xs = let
  n            = (truncate . sqrt . fromIntegral . length) xs
  ans          = (n * (n ^ 2 + 1)) `div` 2
  check        = all (\x -> sum x == 15)
  xsMat        = toListOfLists xs n
  xsMat'       = transpose xsMat
  xsMatDiags   = [fwdDiag xsMat, revDiag xsMat]
  in
    all check [xsMat, xsMat', xsMatDiags]

main :: IO ()
main = do
  putStr "Enter numbers: "
  square <- getLine
  let stuff = catMaybes $ fmap readMaybe (words square) :: [Int]
  print $ isMagicSquare stuff
