Message-ID: <38CCFDB4.C1428A02@raleigh.ibm.com>
Date: Mon, 13 Mar 2000 09:39:48 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: using io remap in an init func
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am working on a port of linux to the IBM 405.

I need to scan the PCI hardware and to do this I need a tlb entry for
the
indirect io addresses staring at 0xeec00000.  The function that sets up
the
indrect address is specified as an __init.  If I use IOremap here to
remap the
address, will this tlb entry stick around forever or do I need to pin a
tlb entry?

Thanks

Chip
IBM MicroElectronics
RTP, NC

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
