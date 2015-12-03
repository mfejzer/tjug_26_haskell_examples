{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

import Data.Aeson
import Data.Text
import Control.Applicative
import Control.Monad
import qualified Data.ByteString.Lazy as B
import GHC.Generics

--"status": "M",
-- "approve_history": [{
--  "userId": 1001414,
--  "approve_value": 2,
--  "grant_date": "2012-01-27 19:16:13.571000000"}],
-- "submit_date": "2012-01-26 22:59:36.560000000",
-- "changeId": 31760,
-- "project": "platform/sdk",
-- "close_date": "2012-01-27 19:16:49.719000000",
-- "files": ["files/ant/build.xml"]}



data Review = Review
    { status :: Text,
      approve_history :: [Approve],
      submit_date :: Text,
      changeId :: Int,
      project :: Text,
      close_date :: Text,
      files :: [Text]
    } deriving (Show,Generic)

data Approve = Approve
    {
      userId :: Int,
      approve_value :: Int,
      grant_date :: Text
    } deriving (Show,Generic)

instance FromJSON Review
instance FromJSON Approve
instance ToJSON Review
instance ToJSON Approve



jsonFile :: FilePath
jsonFile = "android.json"

getJSON :: IO B.ByteString
getJSON = B.readFile jsonFile

example :: B.ByteString
example = "{\"status\": \"M\", \"approve_history\": [{\"userId\": 1001414, \"approve_value\": 2, \"grant_date\": \"2012-01-27 19:16:13.571000000\"}], \"submit_date\": \"2012-01-26 22:59:36.560000000\", \"changeId\": 31760, \"project\": \"platform/sdk\", \"close_date\": \"2012-01-27 19:16:49.719000000\", \"files\": [\"files/ant/build.xml\"]}"

parsedExample = eitherDecode example :: Either String Review

main :: IO ()
main = do
 -- Get JSON data and decode it
 d <- (eitherDecode <$> getJSON) :: IO (Either String [Review])
 -- If d is Left, the JSON was malformed.
 -- In that case, we report the error.
 -- Otherwise, we perform the operation of
 -- our choice. In this case, just print it.
 case d of
  Left err -> putStrLn err
  Right ps -> print (Prelude.head ps)
