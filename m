Date: Tue, 8 Dec 1998 10:53:31 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: VALETTE Eric <valette@crf.canon.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Incomplete (potentially broken) Raven Chipset support for PREP machines.
In-Reply-To: <m0znMxQ-0000WWC@tri-yann.crf.canon.fr>
Message-ID: <Pine.LNX.3.96.981208105134.9992A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We'd then have to have one of those per board type.  That would be pretty
much what we have now.  Perhaps I don't follow you.

}Why dont you have a table with two entries : one being the device func (device + function
}byte) and the other the desired interrupt or directly (dev, func, intr)

I'm happy to take a look at any patches you have for that section of code.
I don't have one of your machines so can't test for it.  The pci/irq code
is a place where I was thinking we need a good cleanup in 2.2.



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
