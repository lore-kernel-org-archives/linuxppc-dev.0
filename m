From: Ruedi.Hofer@ascom.ch
Date: Wed, 08 Dec 1999 15:37:32 +0100 (CET)
Subject: Re: Re: Re: fadsrom.tgz
To: kd@flaga.is
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FMF00G9BFB5YU@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_vgjgqDG+2A48gmMhPBLYIA)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_vgjgqDG+2A48gmMhPBLYIA)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi kd


None of the problems can be solved with the correct Include paths...   ;-(

Maybe it is a problem of the kernel source. I'm using 2.2.13 !!

The problem points from my point of view in this direction since the file super.c
relies on a different definition of

 struct super_block;



powerpc-linux-gcc -D__KERNEL__ -I -O2 -mcpu=860 -I../linux/include -I../linux/include/linux -I../linux/arch/ppc/8xx_io -D__powerpc__ -DMHZ_50 
-DFADS_860 -D__KERNEL__ -DDATA_MEM_ADDR=0x00010000 -DCONFIG_8xx -fsigned-char -msoft-float  -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized 
-mmultiple -mstring   -c super.c -o super.o
super.c: In function `read_sb':
super.c:137: structure has no member named `s_rename_lock'
super.c:138: structure has no member named `s_rename_wait'
make: *** [super.o] Error 1



Cheers, Ruedi


--Boundary_(ID_vgjgqDG+2A48gmMhPBLYIA)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
