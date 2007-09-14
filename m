Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 09/25] cell: remove DEBUG for spu callbacks
Message-Id: <1189751574.103973.353120224453.9.gpush@pokey>
In-Reply-To: <1189751574.98527.127994196313.1.gpush@pokey>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 14 Sep 2007 16:32:54 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We don't want SPE programs to be able to flood the kernel log by
invoking the SPE callback handler, so don't enable DEBUG for
spu_callbacks.c by default.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spu_callbacks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index ab39e22..dceb8b6 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -2,7 +2,7 @@
  * System call callback functions for SPUs
  */
 
-#define DEBUG
+#undef DEBUG
 
 #include <linux/kallsyms.h>
 #include <linux/module.h>
