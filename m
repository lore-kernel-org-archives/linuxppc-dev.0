Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound8-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7FF3ADDE26
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 04:25:41 +1000 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: dwg@au1.ibm.com, jwboyer@linux.vnet.ibm.com,
	grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
Date: Thu,  8 May 2008 11:25:25 -0700
In-Reply-To: <20080508161529.65566FB805F@mail185-va3.bigfish.com>
References: <20080508161529.65566FB805F@mail185-va3.bigfish.com>
Message-Id: <20080508182534.82DF2129805E@mail16-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ePAPR drafts propose 'simple-bus' as a generic compatibility type for
busses which cannot be probed for devices.  In addition, the Xilinx
versions of these IPs seem to be proliferating.  Hence, in the future
let's prefer to use the standard names.  I've left the old names in
for short term backward compatibility for existing device trees.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 arch/powerpc/platforms/40x/virtex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
index 6c72994..b1ab7b8 100644
--- a/arch/powerpc/platforms/40x/virtex.c
+++ b/arch/powerpc/platforms/40x/virtex.c
@@ -16,6 +16,7 @@
 #include <asm/xilinx_intc.h>
 
 static struct of_device_id xilinx_of_bus_ids[] __initdata = {
+	{ .compatible = "simple-bus", },
 	{ .compatible = "xlnx,plb-v46-1.00.a", },
 	{ .compatible = "xlnx,plb-v46-1.02.a", },
 	{ .compatible = "xlnx,plb-v34-1.01.a", },
-- 
1.5.3.4
