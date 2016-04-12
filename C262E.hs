module C262E where

import Text.ParserCombinators.Parsec
import Text.Read (readEither)

data NumOrStr = I Integer | F Float | S String

instance Show NumOrStr where
  show (I i) = show i ++ " (number)"
  show (F f) = show f ++ " (number)"
  show (S s) = s ++ " (string)"

aString :: Parser NumOrStr
aString = do
  s <- many1 (letter <|> digit)
  return (S s)

aNum :: Parser NumOrStr
aNum = (try aFloat) <|> (try aInt)
  where
    aInt = do
      i <- many1 digit
      return $ (I . read) i
    aFloat = intSide <|> decSide
    intSide = do
      i <- option "0" (many1 digit)
      char '.'
      f <- many1 digit
      return $ (F . read) (i ++ "." ++ f)
    decSide = do
      i <- many1 digit 
      char '.'
      f <- option "0" (many1 digit)
      return $ (F . read) (i ++ "." ++ f)

parseIt :: Parser NumOrStr
parseIt = aNum <|> aString

main :: IO ()
main = do
  putStrLn "Hi"
  x <- getLine
  putStrLn $ case readEither x :: Either String Int of
    Left _ -> x ++ " (string)"
    Right n -> show n ++ " (int)"
