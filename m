MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: link error when compiling linux 2.4.5 on powerpc g3
Date: Mon, 25 Jun 2001 17:54:53 +0100
Message-ID: <EB0AF92C5F6B6B45A3EC7A2608347EC008201E@CORK-DC1.raidtec.ie>
From: "Charles Feng" <Charles.Feng@raidtec.ie>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dear list,
	I tried to compile linux 2.4.5 on powerpc g3 system running
linux ppc 2000. I had my own customized ramdisk device driver which
calls several zlib functions like inflateInit, inflate etc. An error
occured when linking object files. The error message is:

drivers/block/block.o(.text+0x2abc): undefined reference to
`inflateInit_'
drivers/block/block.o(.text+0x2abc): relocation truncated to fit:
R_PPC_REL24 inflateInit_
drivers/block/block.o(.text+0x2ad0): undefined reference to `inflate'
drivers/block/block.o(.text+0x2ad0): relocation truncated to fit:
R_PPC_REL24 inflate
drivers/block/block.o(.text+0x2b00): undefined reference to `inflateEnd'
drivers/block/block.o(.text+0x2b00): relocation truncated to fit:
R_PPC_REL24 inflateEnd
make: *** [vmlinux] Error 1

	Does anybody have a clue what's wrong there? I definitely have
the missing functions compiled in. Thanks in acvance.

Charles

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
