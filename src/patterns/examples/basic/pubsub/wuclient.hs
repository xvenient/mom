{-# LANGUAGE BangPatterns #-}
module Main 
where

  import Helper
  import           Network.Mom.Patterns
  import qualified Data.ByteString.Char8 as B
  import           Control.Concurrent

  noparam :: String
  noparam = ""

  main :: IO ()
  main = do
    (l, p, ts) <- getOs
    let topic = case ts of
                  [x] -> x       
                  _   -> "10001" 
    withContext 1 $ \ctx -> 
      withSub ctx "Weather Report" noparam topic
              (address l "tcp" "localhost" p []) 
              (return . B.unpack)
              onErr_ (\_ -> output) wait
  
  wait :: Service -> IO ()
  wait s = untilInterrupt $ do 
             putStrLn $ "Waiting for " ++ srvName s ++ "..."
             threadDelay 1000000
           
