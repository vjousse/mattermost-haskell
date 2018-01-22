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
  -- Function composition from right to left
  -- 1. Apply (CL.^. responseHeader "token"): get the token header from the response
  -- 2. Apply show: transform ByteString to String
  -- 3. Apply Right: put everything in an Either
  -- <$> Applicative operator, Apply the function on the left to the Applicative
  -- on the right. Gives IO (Either …), the Either is applied inside the IO
   post url (toJSON $ Credentials loginId password)) `E.catch`
  handler
  --(r CL.^. responseBody . key "username" . _String)
  where
    handler :: HttpException -> IO (Either String Token)
    handler (HttpExceptionRequest _ (StatusCodeException r _)) =
      return . Left . show . BSC.unpack $
        -- return wraps what's on the right in the same Monad
        -- In our case, the Monad is IO, return by (r CL.^. responseStatus . statusMessage)
      (r CL.^. responseStatus . statusMessage)
    handler _ = return . Left $ "Unhandled exception"
