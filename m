Subject: A couple of minor sys/types.h changes
To: dan@netx4.com (Dan Malek)
Date: Fri, 7 Apr 2000 13:10:03 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000407031003.A76213C9A8@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

We've recently stumbled on a couple of sys/types.h references in your 2.2.13
kernel under arch/ppc/mbxboot which we think should be to linux/types.h.

Here's a patch:

Index: embed_config.c
===================================================================
retrieving revision 1.1.1.2
retrieving revision 1.2
diff -u -r1.1.1.2 -r1.2
--- embed_config.c	2000/01/04 03:38:39	1.1.1.2
+++ embed_config.c	2000/04/06 05:47:19	1.2
@@ -2,7 +2,7 @@
 /* Board specific functions for those embedded 8xx boards that do
  * not have boot monitor support for board information.
  */
-#include <sys/types.h>
+#include <linux/types.h>
 #include "asm/mpc8xx.h"


Index: pci.c
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- pci.c	1999/12/30 05:56:23	1.1.1.1
+++ pci.c	2000/04/06 05:47:19	1.2
@@ -1,6 +1,6 @@
 /* Stand alone funtions for QSpan Tundra support.
  */
-#include <sys/types.h>
+#include <linux/types.h>
 #include <linux/pci.h>
 #include <asm/mpc8xx.h>

Index: qspan_pci.c
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- qspan_pci.c	1999/12/30 05:56:24	1.1.1.1
+++ qspan_pci.c	2000/04/06 05:47:19	1.2
@@ -9,7 +9,7 @@
  * I don't know what to do about interrupts (yet).
  */

-#include <sys/types.h>
+#include <linux/types.h>
 #include <linux/pci.h>
 #include <asm/mpc8xx.h>

--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
