Return-Path: <yanok@emcraft.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5D007B70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Oct 2010 10:53:13 +1100 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de, vlad@emcraft.com
Subject: [PATCH 6/6] mpc8308_p1m: add DMA controller device-tree node
Date: Wed, 27 Oct 2010 01:53:00 +0200
Message-Id: <1288137180-3220-7-git-send-email-yanok@emcraft.com>
In-Reply-To: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
References: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
Cc: Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC8308 has DMA controller compatible with mpc512x_dma driver. This
patch adds device-tree node to support DMA controller on MPC8308 P1M
board.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/powerpc/boot/dts/mpc8308_p1m.dts |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8308_p1m.dts b/arch/powerpc/boot/dts/mpc8308_p1m.dts
index 05a76cc..697b3f6 100644
--- a/arch/powerpc/boot/dts/mpc8308_p1m.dts
+++ b/arch/powerpc/boot/dts/mpc8308_p1m.dts
@@ -297,6 +297,14 @@
 			interrupt-parent = < &ipic >;
 		};
 
+		dma@2c000 {
+			compatible = "fsl,mpc8308-dma", "fsl,mpc5121-dma";
+			reg = <0x2c000 0x1800>;
+			interrupts = <3 0x8
+					94 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+
 	};
 
 	pci0: pcie@e0009000 {
-- 
1.7.2.3
