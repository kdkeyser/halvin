module Message where

import Propose
import AckPropose
import Accept

data Message a = ProposeMessage (Propose a) | AckProposeMessage (AckPropose a) | AcceptMessage (Accept a)
