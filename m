Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5A039DE19C
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 07:55:20 +1000 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] [POWERPC] Xilinx: Virtex: Enable dcr for MMIO and NATIVE
Date: Fri, 18 Apr 2008 14:55:04 -0700
In-Reply-To: <1208555704-8978-1-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1206914576.10388.132.camel@pasglop>
	<1208555704-8978-1-git-send-email-stephen.neuendorffer@xilinx.com>
Message-Id: <20080418215513.C8D1A44007F@mail114-dub.bigfish.com>
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
