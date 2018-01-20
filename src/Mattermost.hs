module Mattermost
  ( login
  ) where

import           Mattermost.Data (Login, Password, Url)

login :: Maybe Login -> Maybe Password -> Maybe Url -> Either String String
login login password url = Left ""
