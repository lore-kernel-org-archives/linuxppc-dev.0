Message-ID: <38DA36A3.3A384DD7@sgi.com>
Date: Thu, 23 Mar 2000 09:22:11 -0600
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: dan@netx4.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: ppc.kernel.org problems
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

Sorry to bother you.  I've scoured the linuxppc-emnbedded mailing list,
and I've tried (unsuccessfully) to access

ftp://ftp.ppc.kernel.org/pub/linuxppc/embedded/

I'm working on a MBX-based 860T board, and I'd like to move from the
2.2.13 kernel in the HardHat package to the latest 2.3.x kernel.
(We need it for the USB drivers).

I have BitKeeper access and I grabbed the latest Linux/PPC kernel tree,
but it doesn't have updated FEC or UART drivers in arch/ppc/8xx_io,
and I'd imagine there are other pieces missing.  Are those pieces
available
to merge w/the Linux PPC (2.3.99-pre3) kernel?  If so, where can I
go besides www.ppc.kernel.org/embedded, which appears to be down.

Any help would be appreciated

Thanks,
Steve

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.
1050 Lowater Road                     Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
