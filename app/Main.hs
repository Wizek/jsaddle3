{-# language RankNTypes #-}
{-# language QuasiQuotes #-}
{-# language OverloadedStrings #-}
{-# language ExtendedDefaultRules #-}
{-# language NoMonomorphismRestriction #-}

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
import            Language.Javascript.JSaddle        as JSA
import            Language.Javascript.JSaddle.Warp   as JSA
import            Language.Javascript.JSaddle.Debug  as JSA
import            Text.InterpolatedString.Perl6
import            Reflex.Dom.Core


main = mainReflex


mainReflex = do
  let
    runFn =
      -- run
      debugAndWait

  runFn 3197 $ mainWidget $ do
    text "hello 2 3"
    inp <- inputElement def
    display $ value inp

mainJSA = do
  putStrLn "init"
  -- debugAndWait 3197 $ do
  run 3197 $ do
    eval "document.write('asd')"

    -- inpEl <- eval "document.body.appendChild(document.createElement('input'))"
    taEl <- eval "document.body.appendChild(document.createElement('textarea'))"

    -- result <- liftIO newEmptyMVar
    -- deRefVal $ call (eval "(function(f) {f('Hello');})") global [fun $ \ _ _ [arg1] -> do
    --   valToText arg1 >>= (liftIO . putMVar result)
    --   ]
    -- liftIO $ takeMVar result >>= print
    -- inp <- textArea
    -- jsFn <- eval "(function (cb) { try{cb(3);console.log(1)}catch(e){console.warn(e);alert(2)} })"
    -- -- jsFn <- eval "(function (cb) { try{cb(3);console.log(1)}catch(e){console.warn(e);alert(2)} })"

    -- (funJsv) <- function $ \ _ _ args -> do
    --   io $ print 13333

    jsFun <- JSA.eval [q|(function(el, cb) {
      try {
        el.addEventListener('keypress', function(e) {
          if (e.keyCode == 13 && !e.shiftKey) {
            e.preventDefault()
            cb()
          } else {
          }
        })
      } catch (e) {
        console.error(e)
      }
    })|]
    JSA.call jsFun JSA.global
      ( taEl
      -- , JSA.function $ \_ _ _ -> do
      , JSA.asyncFunction $ \_ _ _ -> do
        prnt "!!!"
        -- io $ entersNoShiftTrigger ()
      )



    -- call jsFun jsFun [funJsv]
    -- call jsFn jsFn [funJsv]
    pure ()

-- TODO https://stackoverflow.com/questions/48571228/is-it-possible-to-break-up-a-long-nix-shell-p-line-into-multiple-lines

io = liftIO
prnt = io . print

debugAndWait p f = debug p f >> forever (threadDelay $ 1000 * 1000 * 1000)
