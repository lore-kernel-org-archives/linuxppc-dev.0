Return-Path: <sposelenov@emcraft.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 796CEB7174
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 20:20:36 +1000 (EST)
From: sposelenov@emcraft.com
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] [PPC] Motion-PRO: Changed the default blinking rate for
	the status LED to 200 ms, as per the customer's request.
Date: Thu,  2 Sep 2010 12:20:32 +0200
Message-Id: <1283422832-9620-2-git-send-email-sposelenov@emcraft.com>
In-Reply-To: <1283422832-9620-1-git-send-email-sposelenov@emcraft.com>
References: <1283422832-9620-1-git-send-email-sposelenov@emcraft.com>
Cc: Sergei Poselenov <sposelenov@emcraft.com>, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sergei Poselenov <sposelenov@emcraft.com>

Signed-off-by: Sergei Poselenov <sposelenov@emcraft.com>
---
 arch/powerpc/boot/dts/motionpro.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
index 6ca4fc1..b469fc6 100644
--- a/arch/powerpc/boot/dts/motionpro.dts
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -105,7 +105,7 @@
 			label = "motionpro-statusled";
 			reg = <0x660 0x10>;
 			interrupts = <1 15 0>;
-			blink-delay = <100>; // 100 msec
+			blink-delay = <200>; // 200 msec
 		};
 
 		motionpro-led@670 {	// Motion-PRO ready LED
-- 
1.6.2.5
