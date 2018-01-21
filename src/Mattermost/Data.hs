{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Mattermost.Data
  ( Login
  , Password
  , Url
  , Credentials(Credentials)
  ) where

import           Data.Aeson   (ToJSON, object, pairs, toEncoding, toJSON, (.=))
import           Data.Monoid  ((<>))
import           GHC.Generics

type Login = String

type Password = String

type Url = String

data Credentials = Credentials
  { login_id :: Login
  , password :: Password
  } deriving (Generic, Show)

instance ToJSON Credentials where
  toJSON (Credentials login_id password) =
    object ["login_id" .= login_id, "password" .= password]
  toEncoding (Credentials login_id password) =
    pairs ("login_id" .= login_id <> "password" .= password)
