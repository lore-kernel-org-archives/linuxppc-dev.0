Date: Mon, 22 Feb 1999 11:25:04 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: VALETTE Eric <valette@crf.canon.fr>
cc: jpeters@phx.mcd.mot.com, paubert@iram.es, jeremy@goop.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Interrupt routing in prep_pci.c
In-Reply-To: <m10EqzZ-0000WXC@tri-yann.crf.canon.fr>
Message-ID: <Pine.LNX.3.96.990222112112.4988A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Before you get too grumpy please realize I don't have any of the newer
boards.  I only have the "old interrupt" routing scheme boards to work
with first hand.  If someone wants to get to me 1) the newer boards or 2)
some code that handles both well I'd be more than happy to redo the
routing.  prep_pci.c has been a nasty piece of code for some time.

}OK but with the current code :
}
}   1) you scew up the value that may have been correctly set for PCI devices,
}   BY ANY KIND OF FIRMWARE (PPCBUG, ...),
}   2) You force epople to write a config for each board,
}   3) you assume old 105, 106 PCI interrupt routing scheme that makes nothing
}   on newer chips like raven,

That's right, we should keep the setup if it's correct.  Find me a better
scheme for identifying the board, then.

}	1) we should know wether the board firmware correctly
}	set up the PCI devices. If this is the case, the old
}	interrupt scheme must be removed. Note that this
}	implies to have a better scheme for identifying board than the
}	inb (0x800) currently used.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
