{-# LANGUAGE DeriveGeneric #-}

module Mattermost.Data.NotifyProps
  ( NotifyProps
  ) where

import           Data.Aeson        (FromJSON (..), ToJSON (..),
                                    genericParseJSON, genericToJSON)
import           Data.Aeson.Casing (aesonPrefix, snakeCase)
import           GHC.Generics

data NotifyProps = NotifyProps
  { email        :: String
  , push         :: String
  , desktop      :: String
  , desktopSound :: String
  , mentionKeys  :: String
  , channel      :: String
  , firstName    :: String
  } deriving (Generic, Show)

instance ToJSON NotifyProps where
  toJSON = genericToJSON $ aesonPrefix snakeCase

instance FromJSON NotifyProps where
  parseJSON = genericParseJSON $ aesonPrefix snakeCase
