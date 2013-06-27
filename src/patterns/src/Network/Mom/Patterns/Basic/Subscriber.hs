module Network.Mom.Patterns.Basic.Subscriber
where

  import qualified Data.Conduit          as C
  import qualified System.ZMQ            as Z

  import           Network.Mom.Patterns.Streams.Types
  import           Network.Mom.Patterns.Streams.Streams

  newtype Sub = Sub {subSock :: Z.Socket Z.Sub}

  withSub :: Context       ->
             String        -> 
             LinkType      ->
             (Sub -> IO a) -> IO a
  withSub ctx add lt act = 
    Z.withSocket ctx Z.Sub $ \s -> 
      link lt s add [] >> act (Sub s)

  subscribe :: Sub -> [Service] -> IO ()
  subscribe s = mapM_ (Z.subscribe $ subSock s) 

  checkSub :: Sub -> Timeout -> SinkR (Maybe a) -> IO (Maybe a)
  checkSub s tmo snk = runReceiver (subSock s) tmo subSnk
    where subSnk = do
            mb <- C.await
            case mb of
              Nothing -> return Nothing
              Just _  -> snk

