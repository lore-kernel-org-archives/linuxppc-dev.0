To: linux1394-devel@lists.sourceforge.net
Cc: linuxppc-dev@lists.linuxppc.org, cooker-ppc@linux-mandrake.com
Subject: Problem compiling iee3394 on ppc
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 27 Jul 2000 05:42:57 -0700
Message-ID: <m2u2dbzqum.fsf@cassini.us.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have a problem to compile iee3394 the last cvs snapshot on ppc, here
is the output  :

In file included from ohci1394.c:88:
ieee1394_types.h: In function `memcpy_le32':
ieee1394_types.h:239: warning: passing arg 1 of `__swab32p' discards qualifiers from pointer target type
ohci1394.c: In function `ohci_transmit':
ohci1394.c:739: warning: int format, long int arg (arg 3)
gcc -D__KERNEL__ -I/home/chmou/work/kernel/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DMODULE   -DEXPORT_SYMTAB -c ieee1394_syms.c
In file included from ieee1394_syms.c:16:
ieee1394_types.h: In function `pci_alloc_consistent':
ieee1394_types.h:88: warning: implicit declaration of function `__get_free_pages'
ieee1394_types.h:88: `GFP_ATOMIC' undeclared (first use in this function)
ieee1394_types.h:88: (Each undeclared identifier is reported only once
ieee1394_types.h:88: for each function it appears in.)
ieee1394_types.h: In function `pci_free_consistent':
ieee1394_types.h:99: warning: implicit declaration of function `free_pages'
In file included from ieee1394_syms.c:16:
ieee1394_types.h: At top level:
ieee1394_types.h:169: warning: `struct file_operations' declared inside parameter list
ieee1394_types.h:169: warning: its scope is only this definition or declaration, which is probably not what you want.
ieee1394_types.h: In function `devfs_register_chrdev':
ieee1394_types.h:171: warning: implicit declaration of function `register_chrdev'
ieee1394_types.h: In function `devfs_unregister_chrdev':
ieee1394_types.h:175: warning: implicit declaration of function `unregister_chrdev'
ieee1394_types.h: In function `memcpy_le32':
ieee1394_types.h:239: warning: passing arg 1 of `__swab32p' discards qualifiers from pointer target type
make[2]: *** [ieee1394_syms.o] Error 1

the config :

CONFIG_IEEE1394=m
CONFIG_IEEE1394_PCILYNX=m
# CONFIG_IEEE1394_PCILYNX_LOCALRAM is not set
# CONFIG_IEEE1394_PCILYNX_PORTS is not set
CONFIG_IEEE1394_AIC5800=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

--
MandrakeSoft Inc                http://www.mandrakesoft.com
San-Francisco, CA USA                             --Chmouel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
