Message-ID: <391B76B9.AD622925@mvista.com>
Date: Thu, 11 May 2000 20:12:57 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: progress on IBM 405GP port (it boots)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Its been a while since I've provided an update on our efforts to boot Linux on the
IBM 405GP based Walnut reference / evaluation system.

The system now boots to multi-user mode.  The root file system is NFS mounted via
a PCI ethernet card.  Real world applications such as the Apache web server run
quite nicely.  I've been told that Doom and Tetris also run very well (sorry, I
didn't build & run these, so I can't provide any details on building them).

Some more information, the kernel source, and the tool chain to build the kernel
are available at:

   http://www.mvista.com/products/405gp_status/main

Enjoy!

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
