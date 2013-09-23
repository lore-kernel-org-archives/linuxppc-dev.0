Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 20/39] powerpc: Little endian fixes for
 platforms/powernv/opal.c
Date: Mon, 23 Sep 2013 12:04:54 +1000
Message-Id: <1379901913-5945-21-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alistair Popple <alistair@popple.id.au>

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2911abe..4ffa75e 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -372,7 +372,7 @@ static irqreturn_t opal_interrupt(int irq, void *data)
 static int __init opal_init(void)
 {
 	struct device_node *np, *consoles;
-	const u32 *irqs;
+	const __be32 *irqs;
 	int rc, i, irqlen;
 
 	opal_node = of_find_node_by_path("/ibm,opal");
-- 
1.8.1.2
