Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040721062243.41383.qmail@web53703.mail.yahoo.com>
Date: Tue, 20 Jul 2004 23:22:43 -0700 (PDT)
From: Naveen S <naveenmailid@yahoo.com>
Subject: ppcboot help required
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all

     I  have  problem in compiling ppcboot .I am
getting fallowing error message plase help me




.make[1]: Entering directory `/home/ppc/ppcboot/ppc'
ppc_82xx-gcc -g  -Os -fomit-frame-pointer
-mrelocatable -ffixed-r14 -meabi -mrelocatable
-ffixed-r14 -meabi -D__KERNEL__ -D__powerpc__
-DTEXT_BASE=0xFFF00000 -I/home/ppc/ppcboot/include
-fno-builtin -pipe -DCONFIG_PPC -D__powerpc__
-DCONFIG_MPC824X -ffixed-r2 -mstring -mcpu=603e
-msoft-float -DTEXT_BASE=0xFFF00000 -DCONFIG_PPC
-D__powerpc__ -DCONFIG_MPC824X -ffixed-r2 -mstring
-mcpu=603e -msoft-float -DTEXT_BASE=0xFFF00000 -Wall
-Wno-uninitialized -Wstrict-prototypes
-DBUILD_TAG='"(SW04794A,B)"' -c -o zlib.o zlib.c
{standard input}: Assembler messages:
{standard input}:5071: Error: Relocation cannot be
done when using -mrelocatable
{standard input}:5072: Error: Relocation cannot be
done when using -mrelocatable
{standard input}:5073: Error: Relocation cannot be
done when using -mrelocatable
{standard input}:5074: Error: Relocation cannot be
done when using -mrelocatable
{standard input}:5075: Error: Relocation cannot be
done when using -mrelocatable
{standard input}:5076: Error: Relocation cannot be
done when using -mrelocatable
{standard input}:5077: Error: Relocation cannot be
done when using -mrelocatable
{standard input}:5078: Error: Relocation cannot be
done when using -mrelocatable
{standard input}:5042: Error: Relocation cannot be
done when using -mrelocatable
make[1]: *** [zlib.o] Error 1
make[1]: Leaving directory `/home/ppc/ppcboot/ppc'
make: *** [subdirs] Error 1

                                   Regards
                                   Naveen


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
