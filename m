Message-ID: <01C19D04.235222E0.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: mpc860 vs. mpc860T
Date: Mon, 14 Jan 2002 14:02:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have 2 bds., the BD #1 is custom designed and based very
closely on the design of the BD #2.  The main difference
is BD #1 uses an mpc860T and BD #2 uses an mpc860.

Both have 32 Meg DRAM, 50MHz.

I can use the exact same Flash Boot code on each,
and download the exact same Linux kernel and app to each.

BD #2 (mpc860) works perfectly, all the way thru to the app
executing threads, etc.

BD #1 (mpc860T) works up until at various points between when
the kernel initializes itself, and the app execution begins, it gets
exception errors, usually something similar to the following:

  Kernel panic: kernel access of bad area pc c0023634 lr c00235ec
                      address 813F004C tsk kswapd/5
or,

  Kernel panic: ramdisk: request list destroyed

Does anyone know of any differences between the 2 CPU's, other than
the mpc860T's internal FEC section and the MII interface on port D, that
might cause such problems?

Thanks,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
