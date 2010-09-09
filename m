Return-Path: <tie-fei.zang@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141]) by ozlabs.org (Postfix) with ESMTP id 9EAEBB6EEF
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Sep 2010 18:27:05 +1000 (EST)
Received: from mail27-db3 (localhost.localdomain [127.0.0.1])	by
	mail27-db3-R.bigfish.com (Postfix) with ESMTP id 7E63FAA8372	for
	<linuxppc-dev@ozlabs.org>; Thu,  9 Sep 2010 08:36:17 +0000 (UTC)
Received: from DB3EHSMHS005.bigfish.com (unknown [10.3.81.249])	by
	mail27-db3.bigfish.com (Postfix) with ESMTP id 5222A113804C	for
	<linuxppc-dev@ozlabs.org>; Thu,  9 Sep 2010 08:36:17 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o898QlFJ017162	for <linuxppc-dev@ozlabs.org>;
	Thu, 9 Sep 2010 01:26:57 -0700 (MST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/dts: add interrupt parent for lbc node for p4080
Date: Thu, 9 Sep 2010 16:05:15 +0800
Message-ID: <1284019515-26258-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/dts/p4080ds.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 2f0de24..0a18138 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -431,6 +431,7 @@
 		compatible = "fsl,p4080-elbc", "fsl,elbc", "simple-bus";
 		reg = <0xf 0xfe124000 0 0x1000>;
 		interrupts = <25 2>;
+		interrupt-parent = <&mpic>;
 		#address-cells = <2>;
 		#size-cells = <1>;
 
-- 
1.5.6.5
