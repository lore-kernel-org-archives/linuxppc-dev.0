Date: Tue, 30 Nov 1999 15:36:17 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
cc: linuxppc-dev@lists.linuxppc.org
Subject: Ethernet Drivers for LAN/Controller-on-Board Systems
Message-ID: <Pine.SGI.4.10.9911301438280.118603-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I seem to recall seeing a HOWTO on this issue some time ago; however,
after checking the HOWTO archives, I find that my memory must be failing
me.

Anyway, I'm working on a port for the IBM "Oak" 403GCX board. This board
has on it, a National DP83902AV Ethernet MAC. The chip is more or less
directly attached to the 403GCX's address/data buses and resides at the
base physical address 0xF4000000.

How are such Ethernet controllers accommodated by the kernel? It seems as
though I cannot just use 8390.o directly as it is but a library used by
drivers such as ne2k.o. However, I don't think I can or want to use a
driver such as ne2k.o as this isn't a PCI or an ISA card-type controller
either.

Do I need to write a small upper-layer wrapper driver, such as oak_8390.c,
for this?

Any pointers, advice, or input would be appreciated.

Regards,

Grant


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
