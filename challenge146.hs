import System.Environment
import Text.Printf

sideLength n r = r * 2 * sin (pi / n)

perimeter n r = let s = sideLength n r in n * s

main :: IO ()
main = do
    args <- getArgs
    let
        n = (read $ args !! 0) :: Double
        r = (read $ args !! 1) :: Double
    -- putStrLn $ show (perimeter n r)
    printf "%.3f\n" (perimeter n r)
