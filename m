Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: problems on building linux kernel
Date: Tue, 19 Aug 2003 19:24:45 +0800
Message-ID: <000101c36644$7f9c12d0$9f02a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20030815084215.BE92CC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear All,

I met a problem as following when I'm building linux kernel image. Does anyboday give me some advics or comments?

Thanks in advance!
=========================================================================

root@localhost linux-2.4.1]# make vmmage
ppc-linux-gcc -D__KERNEL__ -I/opt/Embedix/home/abc/project/ppcTest/build/rpmdir/BUILD/linux-2.4.1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -Wa,-mppc64bridge -I/opt/Embedix/home/abc/project/ppcTest/build/rpmdir/BUILD/linux-2.4.1/include -I/opt/Embedix/home/abc/project/ppcTest/build/rpmdir/BUILD/linux-2.4.1/include/asm-ppc/ -I/opt/Embedix/home/abc/project/ppcTest/build/rpmdir/BUILD/linux-2.4.1/include/linux   -c -o init/main.o init/main.c
Assembler messages:
Error: Internal assembler error for instruction bdnzlr-
Error: Internal assembler error for instruction bdnzlr+
Error: Internal assembler error for instruction bdnzlrl-
Error: Internal assembler error for instruction bdnzlrl+
Error: Internal assembler error for instruction bdzlr-
Error: Internal assembler error for instruction bnulrl+
Error: Internal assembler error for instruction btlr-
Error: Internal assembler error for instruction btlr+
Error: Internal assembler error for instruction btlrl-
Error: Internal assembler error for instruction btlrl+
Error: Internal assembler error for instruction bflr-
Error: Internal assembler error for instruction bflr+
Error: Internal assembler error for instruction bflrl-
Error: Internal assembler error for instruction bflrl+
Error: Internal assembler error for instruction bltctr-
Error: Internal assembler error for instruction bltctr+
Error: Internal assembler error for instruction bltctrl-
Error: Internal assembler error for instruction bltctrl+
Error: Internal assembler error for instruction bngctrl+
Error: Internal assembler error for instruction bnectr-
Error: Internal assembler error for instruction bfctrl-
Error: Internal assembler error for instruction bfctrl+
Internal error, aborting at ../../gas/config/tc-ppc.c line 1309 in md_begin
Please report this bug.
init/main.c:283: Internal compiler error:
init/main.c:283: output pipe has been closed
cpp0: output pipe has been closed
make: *** [init/main.o] Error 1
[root@localhost linux-2.4.1]#

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
