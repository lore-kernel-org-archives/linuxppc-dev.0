From: jonathan.hurley@ni.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Enabling the L2 cache on an MPC 7410 Sandpoint 3 system
Message-ID: <OF0E758512.183DD9EA-ON86256AA0.007B549B@natinst.com>
Date: Mon, 6 Aug 2001 17:39:29 -0500
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am currently running benchmarks on an MPC 7410 with a Sandpoint 3 system
running the HHL journeyman distribution with 2.4.2.  I read on the
archives that others have successfully enabled the L2 cache with the l2cr
command line parameter.  However,  I have been unsuccessful with that
method.  In addition to the command line parameter I also tried enabling
the L2 cache in arch/ppc/boot/sandpoint/head.S with code from DINK32
(motorola's debug kernel) that invalidated and enabled the L2 cache.  The
code in head.S successfully sets the L2CR and invalidates the cache,
however the kernel hangs when I set the enable bit.  Does anyone have any
suggestions for enabling the L2?

Thanks in advance for you help.

Jonathan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
