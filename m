Message-ID: <3A15645C.CA1A8A8C@agelectronics.co.uk>
Date: Fri, 17 Nov 2000 17:01:16 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: GBIOS release
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Our in-house PowerPC boot code is now released under GPL, and can be
found at http://www.agelectronics.co.uk/gbios/

It's main trick is PCI configuration, which we've tested with fairly
large "christmas tree" configurations using PCI bridge evaluation
boards.

It can load a kernel using bootp and tftp. It also has some hooks for
running on PCI agents, and some simple memory test code included. So far
it runs on our own TPE4 board, and on the Sandpoint with a MPC107
"Altimus" PMC.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
