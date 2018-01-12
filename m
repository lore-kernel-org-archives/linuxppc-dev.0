Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHmxc3DYmzF0hd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 13:32:52 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] powerpc: Reduce log level of "OPAL detected !" message
Date: Fri, 12 Jan 2018 13:28:47 +1100
Message-Id: <20180112022849.30899-3-benh@kernel.crashing.org>
In-Reply-To: <20180112022849.30899-1-benh@kernel.crashing.org>
References: <20180112022849.30899-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This message isn't terribly useful.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 041ddbd1fc57..2479e3396ed8 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -127,7 +127,7 @@ int __init early_init_dt_scan_opal(unsigned long node,
 
 	if (of_flat_dt_is_compatible(node, "ibm,opal-v3")) {
 		powerpc_firmware_features |= FW_FEATURE_OPAL;
-		pr_info("OPAL detected !\n");
+		pr_debug("OPAL detected !\n");
 	} else {
 		panic("OPAL != V3 detected, no longer supported.\n");
 	}
-- 
2.14.3
