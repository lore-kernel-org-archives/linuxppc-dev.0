Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 08 Dec 2008 15:32:26 +1100
Subject: [PATCH] powerpc: Fix mismerge of iss4xx platform support
Message-Id: <20081208043311.5CB96DDE07@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Makefile missed the necessary bit for treeboot-iss4xx.o to be built
thus breaking builds of this platform

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/boot/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/boot/Makefile	2008-12-08 15:30:38.000000000 +1100
+++ linux-work/arch/powerpc/boot/Makefile	2008-12-08 15:30:56.000000000 +1100
@@ -70,7 +70,7 @@ src-plat := of.c cuboot-52xx.c cuboot-82
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
 		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
-		cuboot-acadia.c
+		cuboot-acadia.c treeboot-iss4xx.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
