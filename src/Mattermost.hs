{-# LANGUAGE OverloadedStrings #-}

module Mattermost
  ( login
  ) where

import qualified Control.Exception     as E

import qualified Control.Lens          as CL ((^.))
import           Data.Aeson            (toJSON)
import qualified Data.ByteString.Char8 as BSC
import           Mattermost.Data       (Credentials (Credentials), Login,
                                        Password, Token, Url)
import           Network.HTTP.Client   (HttpException (HttpExceptionRequest), HttpExceptionContent (StatusCodeException))
import           Network.Wreq          (post, responseHeader, responseStatus,
                                        statusMessage)

login :: Login -> Password -> Url -> IO (Either String Token)
login loginId password url =
  (Right . show . (CL.^. responseHeader "token") <$>
   post url (toJSON $ Credentials loginId password)) `E.catch`
  handler
  --(r CL.^. responseBody . key "username" . _String)
  where
    handler :: HttpException -> IO (Either String Token)
    handler (HttpExceptionRequest _ (StatusCodeException r _)) =
      return . Left . show . BSC.unpack $
      (r CL.^. responseStatus . statusMessage)
    handler _ = return . Left $ "Unhandled exception"
