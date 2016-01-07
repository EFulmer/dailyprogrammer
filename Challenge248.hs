import qualified Data.Map as Map
import System.Environment
import System.Exit
import System.IO
import Text.Read

type Point   = (Int, Int)
type Color   = (Int, Int, Int)
type Picture = Map.Map Point Color

data ChallengeData = ChallengeData { inH  :: Handle
                                   , outH :: Handle
                                   , numRows :: Int
                                   , numCols :: Int
                                   , picture :: Map.Map Point Color }

-- readSafeLine :: String -> [Int]
-- readSafeLine line = (map fst) (map reads (words line))
readSafeLine :: String -> [Int]
readSafeLine str = (map fst) (concatMap reads (words str))

main :: IO ()
main = do
    args <- getArgs
    if length args < 1
    then do die "usage: Challenge248 file"
    else do
        let inFName = args !! 0
        inF <- openFile inFName ReadMode
        outF <- openFile "out" WriteMode -- TODO choose name based on inFName.
        hPutStrLn outF "P3"
        inStr <- hGetLine inF -- rename 1stline or something
        let line1 = readSafeLine inStr
        let (cols, rows) = (line1 !! 0, line1 !! 1)
        hPutStrLn outF inStr
        contents <- hGetContents inF
        -- let finalPicture = mainLoop (lines contents) Map.empty
        -- let picString = printPicture finalPicture cols rows
        -- hPutStr outF picString
        hPutStr outF contents
        hClose inF
        hClose outF

mainLoop :: [String] -> Picture -> Picture
mainLoop [] picture     = picture
mainLoop (x:xs) picture = case words x of
                              ("point":xs') -> mainLoop xs' $ drawPoint xs' picture
                              ("line":xs')  -> mainLoop xs' $ drawLine xs' picture
                              ("rect":xs')  -> mainLoop xs' $ drawRect xs' picture


drawPoint :: [String] -> Picture -> Picture
drawPoint xs pic = let xs'        = readSafeLine (concat xs)
                       (r, g, b)  = (xs' !! 0, xs' !! 1, xs' !! 2)
                       (x, y)     = (xs' !! 4, xs' !! 3)
                   in Map.insert (x, y) (r, g, b) pic

drawLine :: [String] -> Picture -> Picture
drawLine xs pic =  undefined

drawRect :: [String] -> Picture -> Picture
drawRect xs pic = let xs'       = readSafeLine (concat xs)
                      (r, g, b) = (xs' !! 0, xs' !! 1, xs' !! 2)
                      (x, y)    = (xs' !! 4, xs' !! 3)
                      (h, l)    = (xs' !! 5, xs' !! 6)
                      newMapAL  = [ ((a, b), (r, g, b)) | 
                                    a <- [x..x+h], b <- [y..y+l] ]
                  in Map.union (Map.fromList newMapAL) pic

-- printPicture :: Picture -> Int -> Int -> String
printPicture pic cols rows = let colors = [ [ show $ Map.findWithDefault (0, 0, 0) (r, c) pic | 
                                            r <- [0..rows-1] ] | c <- [0..cols-1] ]
              
                             in unlines (map unwords colors)
