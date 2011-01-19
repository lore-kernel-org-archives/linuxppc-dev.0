Return-Path: <B33228@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4DDB8B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Jan 2011 20:06:13 +1100 (EST)
From: Xulei <B33228@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] dts: Update sata controller compatible for p1022ds board
Date: Wed, 19 Jan 2011 17:07:30 +0800
Message-ID: <1295428050-21934-2-git-send-email-B33228@freescale.com>
In-Reply-To: <1295428050-21934-1-git-send-email-B33228@freescale.com>
References: <1295428050-21934-1-git-send-email-B33228@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-ide@vger.kernel.org, kumar.gala@freescale.com, jgarzik@pobox.com,
	Xulei <B33228@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update p1022 sata compatible to "fsl,p1022-sata", "fsl,pq-sata-v2".
p1022ds sata controller is v2 version comparing previous FSL sata
controller, for example, mpc8536.

Signed-off-by: Lei Xu <B33228@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/dts/p1022ds.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 2bbecbb..9ad41dd 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -475,14 +475,14 @@
 		};
 
 		sata@18000 {
-			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
+			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
 			reg = <0x18000 0x1000>;
 			cell-index = <1>;
 			interrupts = <74 0x2>;
 		};
 
 		sata@19000 {
-			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
+			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
 			reg = <0x19000 0x1000>;
 			cell-index = <2>;
 			interrupts = <41 0x2>;
-- 
1.7.0.4
