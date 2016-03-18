-- Here's my own *Haskell* solution. My day job is mostly about writing LoB apps with not much networking knowledge needed, so this was a blast, and I learned a lot. 
module C258E where
import Control.Monad
import Data.ByteString.Char8 (pack)
import Data.List.Split
import Network
import Network.DNS.Lookup -- req. dns package
import Network.DNS.Resolver
import Network.Socket
import System.IO
import Text.Read

data LogOnData = LogOnData
  { host     :: HostName
  , port     :: PortNumber
  , nick     :: String
  , userName :: String
  , realName :: String
  , channels :: [String] }

defHost :: HostName
defHost = "irc.freenode.org"

defPort :: PortNumber
defPort = 6667

getServWithDefault :: HostName -> PortNumber -> String -> (HostName, PortNumber)
getServWithDefault h p s = 
    case splitOn ":" s of
        [host, port] -> case readMaybe port :: Maybe Int of
            Just port' -> (host, aNY_PORT) -- TODO fix
            Nothing    -> (host, p)
        _           -> (h, p)

main :: IO ()
main = do 
    putStr "Enter the address of the server you wish to connect to. (e.g. irc.freenode.org:6667): " -- TODO add "http://"
    (host, port) <- fmap (getServWithDefault defHost defPort) getLine
    putStr "Enter your desired nick: "
    nick <- getLine
    putStr "Enter your desired username. Leave blank to use your nick as your username: "
    user <- getLine
    putStr "Enter your real name (doesn't have to be your real name): "
    real <- getLine
    putStr "Enter the channels you wish to join, separated by commas: "
    chans <- fmap (splitOn ",") getLine -- TODO better checking
    putStr "Enter the message you wish to send to the channels: "
    msg <- getLine
    let logOn = LogOnData { host = host, port = port, nick = nick, 
        userName = user, realName = real, channels = chans } -- TODO realign
    sock <- socket AF_INET Stream defaultProtocol
    -- need to get IP first, via 
    -- connect $ SockAddrInet -- num -- addr
    let hostname = pack host -- let hostname = pack (addr !! 0)
    rs <- makeResolvSeed defaultResolvConf
    hostnames <- withResolver rs $ \resolver -> lookupA resolver hostname -- :: Right IPv4   -- TODO renam
    print hostnames
    case hostnames of
        Left _ -> putStrLn "failed" -- TODO
        Right (h:hs) -> do
            host' <- inet_addr $ show h
            connect sock $ SockAddrInet port host'
    close sock
    -- convert to string, use inet_addr to convert to ip
