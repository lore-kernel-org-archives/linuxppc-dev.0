Date: Thu, 23 Mar 2000 17:10:24 -0800
From: Geoff Keating <geoffk@cygnus.com>
Message-Id: <200003240110.RAA05871@localhost.cygnus.com>
To: linuxppc-dev@lists.linuxppc.org
CC: libc-hacker@sourceware.cygnus.com
Subject: Change to mman.h around 2.3.99-pre3-pre4
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone know why the file linux/include/asm-ppc/mman.h changed the
values of MCL_CURRENT and MCL_FUTURE around kernel version
2.3.99-pre3-pre4?

This change causes binary incompatibility.

They used to be

#define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
#define MCL_FUTURE      0x4000          /* lock all additions to address space */

but they're now

#define MCL_CURRENT	1		/* lock all current mappings */
#define MCL_FUTURE	2		/* lock all future mappings */

--
- Geoffrey Keating <geoffk@cygnus.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
