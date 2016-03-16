module C258E where
import Control.Monad
import Data.List.Split
import Network
import System.IO

splitPort :: String -> Maybe (String, String)
splitPort s = case splitOn ":" s of
                [server, port] -> Just (server, port)
                _              -> Nothing 

main :: IO ()
main = do 
  addr <- fmap (splitOn ":") getLine
  nick <- getLine
  user <- getLine
  real <- getLine
  h <- case splitPort (join addr) of
    Just (server, port) -> undefined
    Nothing             -> connectTo "irc.freenode.org" (PortNumber 6667)
  hSetBuffering h NoBuffering
  hPutStr h $ "NICK " ++ nick ++ "\r\n"
  hPutStr h $ "USER " ++ user ++ " 0 * :" ++ real ++ "\r\n"
  hPutStr h $ "JOIN #reddit-dailyprogrammer" ++ "\r\n"
  forever $ do 
    new <- hGetLine h
    if take 4 new == "PING" 
    then do
      hPutStr h $ "PONG" ++ (drop 4 new)  ++ "\r\n"
      putStrLn new
    else putStrLn new
