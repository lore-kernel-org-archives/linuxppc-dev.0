Message-ID: <00e101c1dc8e$f4f8d720$6401a8c0@attbi.com>
Reply-To: "Greg Griffes" <ggg@ieee.org>
From: "Greg Griffes" <ggg@ieee.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: 7400 mmu_init problem
Date: Fri, 5 Apr 2002 05:45:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am trying to port linuxppc_2_4_devel to a custom 750 design.
Using the GNU binutils and gcc-core-2.95.3 tools.

After ppc_md.progress reports "MMU: exit" in mm/init.c::mmu_init()
the kernel goes into panic() and dies there.

I have been using a lousy, unreliable JTAG debugger. Today, I have a
BDI2000 and will be learning how to use it and GDB :-))

Has anyone experienced this in the past?
Does anyone have a rough idea of the cause of the problem?
My guess is that it could be many possible problems, but, it has to
be something that I did wrong in <my>_setup.c I haven't changed
much in the kernel itself.

The low level IO is mapped at 0xEC00_0000; could that be a problem?

The kernel is configured very slim, could I be excluding necessary
functionality?

Thanks for listening,

Greg Griffes

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
