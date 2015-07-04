module MessageProcessor where


import Control.Concurrent.STM
import Control.Lens
import Control.Lens.TH

import Message
import Node
import qualified DeliveryQueue
import Commutating
import Propose

processMessage :: (Commutating a) => Message a -> Node a -> STM ()
processMessage (ProposeMessage propose) node = do
    deliveryQueue <- readTVar $ node ^. (state . deliveryQueueTVar)
    let proposedTransaction = propose ^. transaction
    let conflictingTransaction = DeliveryQueue.getNonCommutatingTransactions proposedTransaction deliveryQueue
    return ()

processMessage (AckProposeMessage ackPropose) node =
    undefined

processMessage (AcceptMessage accept) node =
    undefined