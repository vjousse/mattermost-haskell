{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Mattermost
  ( login
  ) where

import qualified Control.Exception     as E

import qualified Control.Lens          as CL ((^.))
import           Data.Aeson            (toJSON)
import qualified Data.ByteString.Char8 as BSC
import qualified Data.ByteString.Lazy  as LBS
import           GHC.Generics
import           Mattermost.Data       (Credentials (Credentials), Login,
                                        Password, Url)
import           Network.HTTP.Client   (HttpException (HttpExceptionRequest), HttpExceptionContent (StatusCodeException),
                                        Response)
import           Network.Wreq          (post, statusMessage)

login ::
     Login -> Password -> Url -> IO (Either String (Response LBS.ByteString))
login loginId password url = do
  (Right <$> post url (toJSON $ Credentials loginId password)) `E.catch` handler
  where
    handler :: HttpException -> IO (Either String (Response LBS.ByteString))
    handler (HttpExceptionRequest _ (StatusCodeException s _)) = do
      return $ Left $ "error"
