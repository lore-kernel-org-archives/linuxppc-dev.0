Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 03 Oct 2008 19:33:20 +1000
Subject: [PATCH] powerpc: Fix a typo that breaks canyonland support
Message-Id: <20081003093338.50543DDF78@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A typo in the new ppc4xx_simple.c prevents proper detection of
the AMCC Canyonland board.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/44x/ppc44x_simple.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/platforms/44x/ppc44x_simple.c	2008-10-03 14:44:32.000000000 +1000
+++ linux-work/arch/powerpc/platforms/44x/ppc44x_simple.c	2008-10-03 14:44:36.000000000 +1000
@@ -53,7 +53,7 @@ machine_device_initcall(ppc44x_simple, p
  */
 static char *board[] __initdata = {
 	"amcc,bamboo",
-	"amcc,cayonlands",
+	"amcc,canyonlands",
 	"amcc,glacier",
 	"ibm,ebony",
 	"amcc,katmai",
