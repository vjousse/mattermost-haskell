{-# LANGUAGE DeriveGeneric #-}

module Mattermost.Data.User
  ( User
  ) where

import           Data.Aeson                  (FromJSON (..), ToJSON (..),
                                              genericParseJSON, genericToJSON)
import           Data.Aeson.Casing           (aesonPrefix, snakeCase)
import           GHC.Generics
import           Mattermost.Data.NotifyProps (NotifyProps (..))

data User = User
  { id                 :: String
  , createAt           :: Int
  , updateAt           :: Int
  , deleteAt           :: Int
  , username           :: String
  , firstName          :: String
  , lastName           :: String
  , nickname           :: String
  , email              :: String
  , emailVerified      :: Bool
  , authService        :: String
  , roles              :: String
  , locale             :: String
  , notifyProps        :: NotifyProps
  , lastPasswordUpdate :: Int
  , lastPictureUpdate  :: Int
  , failedAttempts     :: Int
  , mfaActive          :: Bool
  } deriving (Generic, Show)

instance ToJSON User where
  toJSON = genericToJSON $ aesonPrefix snakeCase

instance FromJSON User where
  parseJSON = genericParseJSON $ aesonPrefix snakeCase
