Message-ID: <3EB869AF.7070202@attbi.com>
Date: Tue, 06 May 2003 19:04:31 -0700
From: Miles Lane <miles.lane@attbi.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: mvista.com rsync linuxppc-2.5 -- drivers/char/drm/drm_memory.h:145:
 `radeon_mem_stats' undeclared (first use in this function)
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11x
mount                  2.11x
module-init-tools      0.9.11a
e2fsprogs              1.32
pcmcia-cs              3.2.3
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.7

   gcc -Wp,-MD,drivers/char/drm/.radeon_drv.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized
-mmultiple -mstring -fomit-frame-pointer -nostdinc -iwithprefix include
    -DKBUILD_BASENAME=radeon_drv -DKBUILD_MODNAME=radeon -c -o
drivers/char/drm/radeon_drv.o drivers/char/drm/radeon_drv.c
In file included from drivers/char/drm/radeon_drv.c:49:
drivers/char/drm/drm_memory.h: In function `radeon_ioremap_agp':
drivers/char/drm/drm_memory.h:145: `radeon_mem_stats' undeclared (first
use in this function)
drivers/char/drm/drm_memory.h:145: (Each undeclared identifier is
reported only once
drivers/char/drm/drm_memory.h:145: for each function it appears in.)
drivers/char/drm/drm_memory.h:157: `radeon_mem_lock' undeclared (first
use in this function)
drivers/char/drm/drm_memory.h: In function `radeon_ioremap_agp_free':
drivers/char/drm/drm_memory.h:212: `radeon_mem_stats' undeclared (first
use in this function)
drivers/char/drm/drm_memory.h:216: `radeon_mem_lock' undeclared (first
use in this function)
make[3]: *** [drivers/char/drm/radeon_drv.o] Error 1


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
