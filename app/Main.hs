{-# language RankNTypes #-}
{-# language QuasiQuotes #-}
{-# language OverloadedStrings #-}
{-# language ExtendedDefaultRules #-}
{-# language NoMonomorphismRestriction #-}

module Main where

import            Data.Text
import            Data.Text as T
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

-- import            Language.Javascript.JSaddle.WebKitGTK  as Wk

import            Text.InterpolatedString.Perl6
import            Reflex.Dom.Core
import            Control.Lens hiding ((.>), element)

default ((), Int, Text)

main = do
  putStrLn "init"
  mainJSA
  -- mainReflex
  -- mainReflexSimpleInput
  -- mainDisplayOddity

runFn =
  -- run
  debugAndWait
  -- \_ -> Wk.run

mainReflexSimpleInput = do
  runFn 3197 $ mainWidget $ do
    text "hello 2 3"
    inp <- inputElement def
    display $ value inp

mainDisplayOddity = do
  JSA.run 3197 $ mainWidget $ do

    (valEv, valTrigger) <- newTriggerEvent

    io $ forkIO $ forM_ [1 .. 20 :: Int] $ \i -> do
      valTrigger $ i
      threadDelay $ 1000 * 1000

    valDy <- holdDyn 0 valEv
    display valDy
{-
mainReflex = do
  runFn 3197 $ mainWidget $ do
    -- textInput def
    dtext "hello 2"
    -- (domElement, _) <- el' "input" noop
    domElement <- buildEmptyElement "textarea" ("style" =: "width:700px")

    (valEv, valTrigger) <- newTriggerEvent
    liftJSM $ do
      jsFun <- JSA.eval [q|(function(el, cb) {
        try {
          el.addEventListener('input', function(e) {
            cb(el.value)
            if (e.keyCode == 13 && !e.shiftKey) {
              e.preventDefault()
              cb(el.value)
            } else {
            }
          })
        } catch(e) {
          console.error(e)
          throw(e)
        }
      })|]
      jsValUpdater <- JSA.eval [q|(function(el, cb) {
        try {
          el.addEventListener('input', function(e) {
            cb(el.value)
          })
        } catch(e) {
          console.error(e)
          throw(e)
        }
      })|]
      -- JSA.call jsFun JSA.global
      --   ( _textInput_element  inp
      --   -- , JSA.function $ \_ _ _ -> do
      --   , JSA.asyncFunction $ \_ _ args -> do
      --       -- prnt "!!!"
      --       argsStr <- valToText args
      --       -- prnt argsStr
      --       prnt argsStr
      --       -- io $ entersNoShiftTrigger ()
      --   )

      -- JSA.call jsValUpdater JSA.global
      --   -- ( _el_element domElement
      --   -- ( _element_raw domElement
      --   ( domElement
      --   , JSA.asyncFunction $ \_ _ args -> do
      --       argsStr <- valToText args
      --       prnt argsStr
      --       io $ valTrigger argsStr
      --   )

      noop

    (valEv, valTrigger) <- newTriggerEvent

    io $ forkIO $ forM_ [1..20 :: Int] $ \i -> do
      valTrigger $ i
      threadDelay $ 1000 * 1000

    valDy <- holdDyn 0 valEv
    display valDy


    noop

-}

dtext = el "div" . text
noop = pure ()

mainJSA = do
  putStrLn "init"
  -- debugAndWait 3197 $ do
  runFn 3197 $ mainWidget $ do
    {-
    (valEv, valTrigger) <- newTriggerEvent

    (_, taEl) <- el' "textarea" blank

    liftJSM $ do

      -- eval "document.write('asd2')"

      -- inpEl <- eval "document.body.appendChild(document.createElement('input'))"
      -- taEl <- eval "document.body.appendChild(document.createElement('textarea'))"

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
          el.addEventListener('input', function(e) {
            cb(el.value)
            if (e.keyCode == 13 && !e.shiftKey) {
              e.preventDefault()
              cb(el.value)
            } else {
            }
          })
        } catch(e) {
          console.error(e)
          throw(e)
        }
      })|]
      JSA.call jsFun JSA.global
        ( taEl
        -- , JSA.function $ \_ _ _ -> do
        , JSA.asyncFunction $ \_ _ args -> do
            -- prnt "!!!"
            argsStr <- valToText args
            -- prnt argsStr
            prnt argsStr
            io $ valTrigger argsStr
            -- io $ entersNoShiftTrigger ()
        )

    dyA <- holdDyn "x" valEv
    display dyA
    -}

    inp <- textInput def
    display $ value inp

    -- call jsFun jsFun [funJsv]
    -- call jsFn jsFn [funJsv]
    pure ()

-- TODO https://stackoverflow.com/questions/48571228/is-it-possible-to-break-up-a-long-nix-shell-p-line-into-multiple-lines

io = liftIO
prnt = io . print

debugAndWait p f = debug p f >> forever (threadDelay $ 1000 * 1000 * 1000)
