Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040729121949.23526.qmail@web13603.mail.yahoo.com>
Date: Thu, 29 Jul 2004 05:19:49 -0700 (PDT)
From: m madhuker <mythri_madhuker@yahoo.com>
Subject: problem with compiling ppcboot
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello all,
         Im working with MPC8245 EncorePP1 board..
in this when compile ppcboot with make command..

it is showing errors as follows...
--------------
make[1]: Entering directory
`/home/madhu/ppc/ppcboot/ppc'
ppc-elf-gcc -D__ASSEMBLY__ -g  -Os
-fomit-frame-pointer -mrelocatable -ffixed-r14 -meabi
-mrelocatable -ffixed-r14 -meabi -D__KERNEL__
-D__powerpc__ -DTEXT_BASE=0xFFF00000
-I/home/madhu/ppc/ppcboot/include -fno-builtin -pipe
-DCONFIG_PPC -D__powerpc__ -DCONFIG_MPC824X -ffixed-r2
-mstring -mcpu=603e -msoft-float
-DTEXT_BASE=0xFFF00000 -DCONFIG_PPC -D__powerpc__
-DCONFIG_MPC824X -ffixed-r2 -mstring
-mcpu=603e -msoft-float -DTEXT_BASE=0xFFF00000 -c -o
ppcstring.o ppcstring.S
ppc-elf-gcc: installation problem, cannot exec `cpp0':
No such file or directoryas: unrecognized option
`-mppc'
make[1]: *** [ppcstring.o] Error 1
make[1]: Leaving directory
`/home/madhu/ppc/ppcboot/ppc'
make: *** [subdirs] Error 1
[root@mail ppcboot]#
--------------------------------------

        Please give suggestion....
                                    Regards
                                    Madhukar



Y! Messenger - Communicate in real time. Download now.
http://messenger.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
