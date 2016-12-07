Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0068.outbound.protection.outlook.com [104.47.36.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYhrG0vBmzDvp8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 02:15:09 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <devicetree@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>, <oss@buserror.net>
Subject: [PATCH v3 3/4] powerpc/fsl/dts: add sg_2500_aqr105_phy4 alias on
 t1024rdb
Date: Wed, 7 Dec 2016 17:14:55 +0200
Message-ID: <1481123696-21028-3-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1481123696-21028-1-git-send-email-madalin.bucur@nxp.com>
References: <1481123696-21028-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The alias is used by the boot loader to perform a device tree
fixup.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t1024rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/t1024rdb.dts b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
index c7f4f62..73a6453 100644
--- a/arch/powerpc/boot/dts/fsl/t1024rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
@@ -41,6 +41,10 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	aliases {
+		sg_2500_aqr105_phy4 = &sg_2500_aqr105_phy4;
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.1.0
