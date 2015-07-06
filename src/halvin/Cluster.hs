{-# LANGUAGE TemplateHaskell #-}
module Cluster where

import Control.Lens
import Control.Lens.TH
import Control.Concurrent.STM

newtype Cluster = Cluster {
    _size :: Int
}
makeLenses ''Cluster