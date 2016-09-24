{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module ParserSpec where

import Parser

import qualified Data.ByteString.Lazy.Char8 as C
import Data.Aeson
import Data.Either
import Data.Text
import Test.Hspec

main :: IO ()
main = hspec spec

correctExample :: C.ByteString
correctExample = "{\"status\": \"M\", \"approve_history\": [{\"userId\": 1001414, \"approve_value\": 2, \"grant_date\": \"2012-01-27 19:16:13.571000000\"}], \"submit_date\": \"2012-01-26 22:59:36.560000000\", \"changeId\": 31760, \"project\": \"platform/sdk\", \"close_date\": \"2012-01-27 19:16:49.719000000\", \"files\": [\"files/ant/build.xml\"]}"

parsedExample = eitherDecode correctExample :: Either String Review

spec :: Spec
spec = do
  describe "eitherDecode correctExample" $ do
    it "parses correctly example" $ do
      (isRight parsedExample) `shouldBe` True
