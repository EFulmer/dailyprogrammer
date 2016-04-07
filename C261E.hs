module C261E where

import           Data.List         (permutations, transpose)
import           Data.Maybe        (catMaybes)
import qualified Data.Set   as Set
import           Text.Read         (readMaybe)

cTestTrue = [[8, 1, 6], [3, 5, 7]]
cTestFalse = [[3, 5, 7], [8, 1, 6]]

fwdDiag :: [[a]] -> [a]
fwdDiag xs = fmap (\(i, xs) -> xs !! i) $ zip [0..] xs

revDiag :: [[a]] -> [a]
revDiag = fwdDiag . reverse

isMagicSquare :: [[Int]] -> Bool
isMagicSquare sq = let
  n     = length sq
  ans   = (n * (n ^ 2 + 1)) `div` 2
  check = all (\x -> sum x == ans)
  diags = [fwdDiag sq, revDiag sq]
  in
    all check [sq, diags]

msChall :: [[Int]] -> Int -> Bool
msChall xs n = let
  missing = Set.toList $ (Set.fromList [1..n^2]) Set.\\ (Set.fromList (concat xs))
  perms   = permutations missing
  in
    or $ fmap isMagicSquare [ xs ++ [perm] | perm <- perms ]

msChall' :: [[Int]] -> Bool
msChall' xs = let
  undefined = undefined
  in undefined

main :: IO ()
main = do
  putStr "Enter dimension of magic square to verify: "
  n <- getLine
  putStrLn $ "Enter " ++ n ++ " lines, one for each row of the magic square, numbers separated by spaces."
  let n' = readMaybe n
  case n' of
    Nothing -> putStrLn "Please enter a valid number."
    Just n'' -> do
    let lns = replicate n'' getLine
    square <- sequence lns
    let sq = fmap catMaybes $ (fmap . fmap) readMaybe (fmap words square) :: [[Int]]
    print $ isMagicSquare sq

