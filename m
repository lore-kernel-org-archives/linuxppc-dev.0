Content-Type: text/plain;
  charset="us-ascii"
From: Shie Erlich <shie_e@elbit.co.il>
Reply-To: shie_e@elbit.co.il
To: linuxppc-embedded@lists.linuxppc.org
Subject: no virtual terminals problem
Date: Tue, 11 Jun 2002 17:35:21 +0000
MIME-Version: 1.0
Message-Id: <200206111735.21959.shie_e@elbit.co.il>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi people,
we're using hardhat with kernel 2.4.2. our system has a serial
port, through which we're using the serial console.
also, we have a PMC adapter on board, and we're trying to
use it with a VGA card. we took a PCI VGA card (ATI RAGEpro),
and attached it to the board, through a PCI2PMC adapter.
/proc/pci identifies the card, and also the framebuffer device
seems to recognize it, but all we get on screen is some green trash.

Also we don't have any tty - only /dev/tty exists and /dev/vc/0 (using devfs).

what do we need to do in order to get the missing ttys or vc/*, so we'll
be able to start XFree ?


Shie Erlich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
