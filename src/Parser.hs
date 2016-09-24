{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Parser where

import Data.Aeson
import Data.Text
import Control.Applicative
import Control.Monad
import qualified Data.ByteString.Lazy.Char8 as C
import GHC.Generics

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

getJSON :: FilePath -> IO C.ByteString
getJSON file = C.readFile file

parse file = do
 fileContent <- C.readFile file
 return (Prelude.map eitherDecode $ C.split '\n' fileContent ) :: IO [Either String Review]


parseReviewFile file = do
 decode <- (eitherDecode <$> (getJSON $ file)) :: IO (Either String [Review])
 case decode of
  Left err -> do putStrLn err; return []
  Right reviews -> return reviews 

