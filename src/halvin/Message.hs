module Message where

import Control.Concurrent.STM

import Propose
import Accept
import AckPropose
import AckAccept

data Message = ProposeMessage Propose | AcceptMessage Accept deriving (Show)

data AckMessage = AckProposeMessage AckPropose | AckAcceptMessage AckAccept deriving (Show)