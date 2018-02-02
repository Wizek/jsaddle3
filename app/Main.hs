module Main where

import            Data.Text
import            Control.Monad
import            Control.Concurrent
import            Control.Monad.Trans
import            Control.Monad.IO.Class
import            Control.Concurrent.MVar
import            Language.Javascript.JSaddle
import            Language.Javascript.JSaddle.Warp
import            Language.Javascript.JSaddle.Debug

main = do
  putStrLn "init"
  run 3197 $ do
    result <- liftIO newEmptyMVar
    deRefVal $ call (eval "(function(f) {f('Hello');})") global [fun $ \ _ _ [arg1] -> do
      valToText arg1 >>= (liftIO . putMVar result)
      ]
    liftIO $ takeMVar result >>= print
    pure ()

-- TODO https://stackoverflow.com/questions/48571228/is-it-possible-to-break-up-a-long-nix-shell-p-line-into-multiple-lines
