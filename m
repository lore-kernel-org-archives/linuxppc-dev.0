Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3DA25CE5.EA79616B@redswitch.com>
Date: Mon, 07 Oct 2002 21:19:49 -0700
From: Jin Cheng <jcheng@redswitch.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: can not open crt1.o using ELDK
References: <20021007192325.GA7735@segfault.usine.8d.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

When I use the ELDK to compile one file, I got the following message saying can
not
find crt1.o. Can someone help me on that? I don't have problem compiling one
other file.

Thanks.

Jin

hyperion: 224 % make
ppc-linux-gcc -D__KERNEL__ -DMODULE -I/u/jcheng/ppclinux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O -g -DDEBUG -fno-strict-aliasing
-fno-common -fomit-frame-pointer -I/u/jcheng/ppclinux/arch/ppc -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -Wa,-m405
-nostdinc -I/opt/eldk/usr/lib/gcc-lib/ppc-linux/2.95.3/include vayu_main.c
dbgprint.h:35: warning: `debug' defined but not used
/opt/eldk/usr/ppc-linux/bin/ld: cannot open crt1.o: No such file or directory
collect2: ld returned 1 exit status
make: *** [vayu_main.o] Error 1


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
