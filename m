Message-ID: <3B80DFC3.BBAF169@us.ibm.com>
Date: Mon, 20 Aug 2001 10:00:35 +0000
From: Scott Carroll <scottcar@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2_4 Power3 break?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


While building for Power3:


gcc -D__KERNEL__ -I/usr/src/latest_082001/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-Wa,-mppc64bridge    -DEXPORT_SYMTAB -c ppc_ksyms.c
ppc_ksyms.c:187: `flush_dcache_page' undeclared here (not in a function)
ppc_ksyms.c:187: initializer element is not constant
ppc_ksyms.c:187: (near initialization for
`__ksymtab_flush_dcache_page.value')
make[1]: *** [ppc_ksyms.o] Error 1
make[1]: Leaving directory `/usr/src/latest_082001/arch/ppc/kernel'

--
Scott Carroll                                  IBM RS/6000
Division
11400 Burnet Road, M.S. 9541       Notes:       scottcar@us.ibm.com
Austin, TX  78758-3493 U.S.A       phone:       +1 (512) 838-9642

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
