From: miles.lane@attbi.com
Message-Id: <200303241737.LAA16808@lists.linuxppc.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: linuxppc-2.5 from mvista.com -- drivers/char/agp/agp.h:31: asm/agp.h: No such file or directory
Date: Mon, 24 Mar 2003 17:37:10 +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  gcc -Wp,-MD,drivers/char/agp/.backend.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -fomit-frame-pointer -nostdinc -iwithprefix include
-DKBUILD_BASENAME=backend -DKBUILD_MODNAME=agpgart -c -o
drivers/char/agp/backend.o drivers/char/agp/backend.c
In file included from drivers/char/agp/backend.c:39:
drivers/char/agp/agp.h:31: asm/agp.h: No such file or directory
In file included from drivers/char/agp/backend.c:39:
drivers/char/agp/agp.h: In function `global_cache_flush':
drivers/char/agp/agp.h:51: warning: implicit declaration of function
`flush_agp_cache'
make[3]: *** [drivers/char/agp/backend.o] Error 1

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
