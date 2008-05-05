Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E5771DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 03:56:50 +1000 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: jwboyer@linux.vnet.ibm.com, benh@kernel.crashing.org,
	grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] [POWERPC] Xilinx: Virtex: Enable dcr for MMIO and NATIVE
Date: Mon,  5 May 2008 10:56:39 -0700
In-Reply-To: <1210010201-28436-2-git-send-email-stephen.neuendorffer@xilinx.com>
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-2-git-send-email-stephen.neuendorffer@xilinx.com>
Message-Id: <20080505175646.BDF3D11806D@mail196-wa4.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FPGA designs may have need of both MMIO-based and NATIVE-based dcr
interfaces.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 arch/powerpc/platforms/40x/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index a9260e2..b8e06df 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -123,6 +123,8 @@ config 405GPR
 
 config XILINX_VIRTEX
 	bool
+	select PPC_DCR_MMIO
+	select PPC_DCR_NATIVE
 
 config XILINX_VIRTEX_II_PRO
 	bool
-- 
1.5.3.4-dirty
