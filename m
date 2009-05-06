Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 09F59504F4
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:22:16 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/12] mpc5121ads: Added I2C RTC node to mpc5121ads DTS.
Date: Wed,  6 May 2009 22:15:16 +0200
Message-Id: <1241640919-4650-10-git-send-email-wd@denx.de>
In-Reply-To: <1241640919-4650-1-git-send-email-wd@denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
Cc: Piotr Ziecik <kosmo@semihalf.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Piotr Ziecik <kosmo@semihalf.com>

Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
 arch/powerpc/boot/dts/mpc5121ads.dts |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index 93fe12a..c2d9de9 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -210,6 +210,11 @@
 			interrupts = <9 0x8>;
 			interrupt-parent = < &ipic >;
 			fsl5200-clocking;
+
+			rtc@68 {
+				compatible = "stm,m41t80";
+				reg = <0x68>;
+			};
 		};
 
 		i2c@1720 {
-- 
1.6.0.6
