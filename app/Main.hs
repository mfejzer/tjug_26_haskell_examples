{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

import Parser
import GHC.Generics
import System.Environment

main :: IO ()
main = do
 args <- getArgs
 reviews <- parseReviewFile (Prelude.head args)
 return ()

