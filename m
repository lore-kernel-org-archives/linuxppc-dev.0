Return-Path: <stephenn@xilinx.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3EA9ADDFC0
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 03:29:30 +1100 (EST)
Received: from outbound3-dub.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound3-dub-R.bigfish.com (Postfix) with ESMTP id BAFA81C68283
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:26:20 +0000 (UTC)
Received: from mail113-dub-R.bigfish.com (unknown [10.5.252.3])
	by outbound3-dub.bigfish.com (Postfix) with ESMTP id AECCB74805C
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:26:20 +0000 (UTC)
Received: from mail113-dub (localhost.localdomain [127.0.0.1])
	by mail113-dub-R.bigfish.com (Postfix) with ESMTP id 1A076107075E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:26:19 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail113-dub.bigfish.com (Postfix) with ESMTP id B75351890079
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:26:17 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com) by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <stephenn@xilinx.com>) id 1JfHPD-00008z-PT
	for linuxppc-dev@ozlabs.org; Fri, 28 Mar 2008 09:26:15 -0700
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] [POWERPC] Xilinx: Virtex: Enable dcr for MMIO and NATIVE
Date: Fri, 28 Mar 2008 09:23:46 -0700
In-Reply-To: <1206721429-18276-1-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1206401313-1625-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1206721429-18276-1-git-send-email-stephen.neuendorffer@xilinx.com>
Message-Id: <20080328162617.B75351890079@mail113-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
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
