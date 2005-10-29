Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lH68030096@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:46 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 31/43] ppc64 boot: fix typo in asm comments
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

Update comment in memcpy, r7 contains the byte count.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/boot/string.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/ppc64/boot/string.S~ppc64-boot-fix-typo-in-asm-comments arch/ppc64/boot/string.S
--- devel/arch/ppc64/boot/string.S~ppc64-boot-fix-typo-in-asm-comments	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/string.S	2005-10-28 17:44:04.000000000 -0700
@@ -104,7 +104,7 @@ memmove:
 
 	.globl	memcpy
 memcpy:
-	rlwinm.	r7,r5,32-3,3,31		/* r0 = r5 >> 3 */
+	rlwinm.	r7,r5,32-3,3,31		/* r7 = r5 >> 3 */
 	addi	r6,r3,-4
 	addi	r4,r4,-4
 	beq	2f			/* if less than 8 bytes to do */
@@ -146,7 +146,7 @@ memcpy:
 
 	.globl	backwards_memcpy
 backwards_memcpy:
-	rlwinm.	r7,r5,32-3,3,31		/* r0 = r5 >> 3 */
+	rlwinm.	r7,r5,32-3,3,31		/* r7 = r5 >> 3 */
 	add	r6,r3,r5
 	add	r4,r4,r5
 	beq	2f
_
