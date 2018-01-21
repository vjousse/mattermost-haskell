{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Control.Lens       as CL ((^.), (^?))
import           Data.Aeson         (ToJSON, object, pairs, toEncoding, toJSON,
                                     (.=))
import           Data.Aeson.Lens    (key, _String)
import           Data.ByteString    (unpack)
import           Data.Text.Encoding (decodeUtf8)
import           Mattermost         (login)
import           Mattermost.Data    (Credentials (Credentials), Token)
import           Network.Wreq       (get, post, responseBody, responseHeader,
                                     responseStatus, statusMessage)
import           System.Environment (getEnv)

main :: IO ()
main = doPost

-- Should have a look at https://stackoverflow.com/questions/36361611/wreq-get-post-with-exception-handling
doPost :: IO ()
doPost = do
  clientId <- getEnv "LOGIN_ID"
  password <- getEnv "PASSWORD"
  url <- getEnv "URL"
  response <- login clientId password url
  --print (r CL.^. responseBody . key "username" . _String)
  case response of
    Right t -> putStrLn t
    Left e  -> putStrLn $ "Error while retrieving token: " ++ e
