{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Mattermost         (login)
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
  case response of
    Right t -> putStrLn t
    Left e  -> putStrLn $ "Error while retrieving token: " ++ e
