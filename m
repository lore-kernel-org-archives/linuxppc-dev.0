Message-ID: <3CAD56AC.55CAE96A@imc-berlin.de>
Date: Fri, 05 Apr 2002 09:47:56 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: consistent_alloc and 2.4.4.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I am using linux 2.4.4 from ftp.denx.de on a MPC855T.

I want to dma from a device into MPC's SDRAM and therefore I need some
non-cacheable (i.e./or cache coherent) memory.

I read about consistent_alloc() but I can't find it for the mpc8xx in
the mentioned 2.4.4 kernel.

What would be the best alternative to consistent_alloc()?

Cheers,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
