{-# LANGUAGE OverloadedStrings #-}
-- Here's my own *Haskell* solution. My day job is mostly about writing LoB apps with not much networking knowledge needed, so this was a blast, and I learned a lot. 
module C258E where
import Control.Concurrent
import Control.Monad
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as C8
import Data.List.Split
import Network.DNS.Lookup -- req. dns package
import Network.DNS.Resolver
import Network.Socket hiding (send, sendTo, recv, recvFrom)
import Network.Socket.ByteString
import Text.Read

endOfMOTD :: B.ByteString
endOfMOTD = C8.pack "376"

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

waitForMOTD :: Socket -> IO ()
waitForMOTD conn = do 
    msg <- recv conn 4096
    C8.putStrLn msg
    unless (motdFound msg) (waitForMOTD conn)
    where 
        motdFound m = (not . B.null) (snd (B.breakSubstring endOfMOTD m))

sendIRC :: Socket -> B.ByteString -> IO Int
sendIRC conn msg = (C8.putStrLn msg') >> (send conn msg')
    where msg' = msg `B.append` "\r\n"

sendChan :: Socket -> B.ByteString -> B.ByteString -> IO Int
sendChan conn chan msg = (C8.putStrLn msg') >> (send conn msg')
    where msg' = "PRIVMSG" `B.append` chan `B.append` ":" `B.append` msg

-- TODO error checking
joinChans :: Socket -> B.ByteString -> IO Int
joinChans conn chans = (C8.putStrLn msg') >> (sendIRC conn msg')
    where msg' = "JOIN " `B.append` chans

logOn :: Socket -> B.ByteString -> B.ByteString -> B.ByteString -> IO Int
logOn conn nick user real = (C8.putStrLn nMsg) >> (sendIRC conn nMsg) >> (C8.putStrLn uMsg) >> (sendIRC conn uMsg)
    where nMsg = "NICK " `B.append` nick
          uMsg = "USER" `B.append` user `B.append` " 0 * :" `B.append` real

loop conn cmd response = do
    msg <- recv conn 4096
    return ()

main :: IO ()
main = do 
    putStr "Enter the address of the server you wish to connect to. (default: irc.freenode.org:6667): " -- TODO add "http://"
    (host, port) <- fmap (getServWithDefault defHost defPort) getLine
    putStr "Enter your desired nick: "
    nick <- B.getLine
    putStr "Enter your desired username. Leave blank to use your nick as your username: "
    user <- B.getLine
    putStr "Enter your real name (doesn't have to be your real name): "
    real <- B.getLine
    putStr "Enter the channels you wish to join, separated by commas: "
    chans <- B.getLine -- TODO better checking
    putStr "Enter the message you wish to send to the channels: "
    msg <- B.getLine
    sock <- socket AF_INET Stream defaultProtocol
    let hostname = C8.pack host -- let hostname = pack (addr !! 0)
    rs <- makeResolvSeed defaultResolvConf
    ips <- withResolver rs $ \resolver -> lookupA resolver hostname
    case ips of
        Left _ -> putStrLn "failed" -- TODO
        Right (i:_) -> do
            host' <- inet_addr $ show i
            connect sock $ SockAddrInet port host'
            logOn sock nick user real
            waitForMOTD sock
            joinChans sock chans
            close sock
    return ()

