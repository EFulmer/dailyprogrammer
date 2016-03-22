module C259E where
import           Data.Char (isDigit)
import qualified Data.Map as M
import           Data.Maybe (catMaybes)
import           Text.Regex.Posix

keypad = M.fromList [('1', (0, 0)), ('2', (0, 1)), ('3', (0, 2))
                    ,('4', (1, 0)), ('5', (1, 1)), ('6', (1, 2))
                    ,('7', (2, 0)), ('8', (2, 1)), ('9', (2, 2))
                    ,('.', (3, 0)), ('0', (3, 1))]

distance :: (Eq a, Floating a) => (a, a) -> (a, a) -> a
distance (r1, c1) (r2, c2)
    | r1 == r2  = abs (c1 - c2)
    | c1 == c2  = abs (r1 - r2)
    | otherwise = sqrt (a ** 2 + b ** 2)
    where a = r1 - r2
          b = c1 - c2

totalDistance :: (Floating a, Fractional a, RealFrac a) => [(a, a)] -> a
totalDistance ds = roundHundreds $ sum $ zipWith distance ds (tail ds)

-- got this from SO:
roundHundreds :: (Fractional a, RealFrac a) => a -> a
roundHundreds x = (fromInteger $ round $ x * 100) / 100.0

main = do
    input <- getLine
    if not (check input)
    then putStrLn "error: expected an IP address"
    else do
        let coords = catMaybes $ fmap (flip M.lookup keypad) input
        putStrLn $ show (totalDistance coords) ++ "cm"
    where check input  = (input =~ ipRe) && (allDigits (inNums input))
          allDigits    = all isDigit
          inNums input = filter (/='.') input
          ipRe         = "[1-9]{1,3}[.][1-9]{1,3}[.][1-9]{1,3}[.][1-9]{1,3}"
