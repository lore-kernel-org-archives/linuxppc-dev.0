From: Ole.Reinartz@nokia.com
Message-ID: <A914533BF4B9D2118D980008C7894C0A014D54DC@dueis01nok>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel Math Emulation again
Date: Tue, 30 Nov 1999 11:03:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I know this was raised here already several times...
I like to run linux on an 860 with the full distribution NFS mounted
 ( ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/mbxroot.full.tgz )
Unfortunately most (or all) or the binaries out of this tar is compiled
without builtin math emulation. So to run this I need kernel math emulation.
I found that in
arch/ppc/kernel/softemu8xx.c
there are already some instructions emulated, using the FPU exception (at
least since version 2.2.5. ). But those are only load/store instructions
which are in C- compiler generated function pre/post code already when it is
compiled without -msoft-float.
Is there something in the works by someone which will also support all the
other instructions?
In time I try to get those in, linking libgcc.a to the kernel (zImage grows
about 200k) and implementing the instructions using functions inside it. But
until now without great success.

Cheers
	Ole


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
