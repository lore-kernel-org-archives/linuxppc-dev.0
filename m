Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lIrL030099@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:47 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 32/43] ppc64 boot: remove global initializers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

No need to initialize global variables.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/boot/main.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/ppc64/boot/main.c~ppc64-boot-remove-global-initializers arch/ppc64/boot/main.c
--- devel/arch/ppc64/boot/main.c~ppc64-boot-remove-global-initializers	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/main.c	2005-10-28 17:45:21.000000000 -0700
@@ -38,9 +38,9 @@ struct addr_range {
 	unsigned long size;
 	unsigned long memsize;
 };
-static struct addr_range vmlinux = {0, 0, 0};
-static struct addr_range vmlinuz = {0, 0, 0};
-static struct addr_range initrd  = {0, 0, 0};
+static struct addr_range vmlinux;
+static struct addr_range vmlinuz;
+static struct addr_range initrd;
 
 static char scratch[46912];	/* scratch space for gunzip, from zlib_inflate_workspacesize() */
 static char elfheader[256];
_
