Date: Sun, 23 Sep 2001 22:43:00 +0200
From: Stefan Pfetzing <dreamind@dreamind.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Problem compiling 2.4.10-pre10-ben0
Message-ID: <20010923224259.A5542@server>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

i just tried to compile the latest Benh kernel, but it failed at the Drm
module for the Ati card in my ibook2. (i had Agpgart disabled)

--- snipp ---
make[3]: Entering directory `/usr/src/linux-benh/drivers/char/drm'
gcc -D__KERNEL__ -I/usr/src/linux-benh/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized
-mmultiple -mstring -DMODULE -DMODVERSIONS -include
/usr/src/linux-benh/include/linux/modversions.h   -c -o r128_drv.o r128_drv.c
In file included from r128_drv.c:108:
drm_memory.h: In function `r128_ioremap_agp':
drm_memory.h:340: warning: unused variable `i'
drm_memory.h:340: warning: unused variable `err'
drm_memory.h:339: warning: unused variable `flags'
drm_memory.h:338: warning: unused variable `agpmem'
drm_memory.h:337: warning: unused variable `area'
drm_memory.h:336: warning: unused variable `pt'
In file included from r128_drv.c:110:
drm_vm.h: In function `r128_vm_shm_nopage':
drm_vm.h:178: warning: unsigned int format, long unsigned int arg (arg 3)
drm_vm.h: In function `r128_vm_dma_nopage':
drm_vm.h:303: warning: unsigned int format, long unsigned int arg (arg 4)
drm_vm.h: In function `r128_mmap':
drm_vm.h:511: structure has no member named `agp'
drm_vm.h:513: structure has no member named `agp'
make[3]: *** [r128_drv.o] Error 1
make[3]: Leaving directory `/usr/src/linux-benh/drivers/char/drm'
make[2]: *** [_modsubdir_drm] Error 2
make[2]: Leaving directory `/usr/src/linux-benh/drivers/char'
make[1]: *** [_modsubdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux-benh/drivers'
make: *** [_mod_drivers] Error 2
--- snapp ---

the 2.4.9-ben0 kernel (which i currently use) works fine.

bye

dreamind

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
