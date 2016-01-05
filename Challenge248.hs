import System.Environment
import System.Exit
import System.IO
import Text.Read
-- words 

data ChallengeData = ChallengeData { inH :: Handle, outH :: Handle, numRows :: Int, numCols :: Int }

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
        -- putStrLn inFName
        inStr <- hGetLine inF -- rename 1stline or something
        -- reads
        let line1 = map fst $ concat (map reads (words inStr) :: [[(Int, String)]])
        -- print line1
        let (cols, rows) = (line1 !! 0, line1 !! 1)
        -- print (cols, rows)
        hPutStrLn outF inStr
        let cData = ChallengeData { inH = inF, outH = outF, numCols = cols, 
            numRows = rows }
        mainLoop cData
        hClose inF
        hClose outF

mainLoop :: ChallengeData -> IO ()
mainLoop cData = do
    eof <- hIsEOF (inH cData)
    case eof of
        True  -> return ()
        False -> do
            line <- hGetLine (inH cData)
            let ws = words line
            let intWords = map fst $ concat (map reads ws :: [[(Int, String)]])
            case ws of
                ("point":ws) -> printPoint cData intWords
                ("line":ws)  -> printLine cData intWords
                ("rect":ws)  -> printRect cData intWords
                _            -> do die "every line should start with 'point', 'line', or 'rect'"

printPoint :: ChallengeData -> [Int] -> IO ()
printPoint cData xs = undefined

printLine :: ChallengeData -> [Int] -> IO ()
printLine cData xs = undefined

printRect :: ChallengeData -> [Int] -> IO ()
printRect cData xs = undefined
