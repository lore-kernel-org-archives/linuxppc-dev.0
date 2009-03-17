Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8B16ADDEEB
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 20:12:33 +1100 (EST)
From: Wolfgang Grandegegr <wg@grandegger.com>
To: linux-mtd@lists.infradead.org
Subject: [PATCH 4/4] powerpc/85xx: TQM8548: Update DTS file for multi-chip
	support
Date: Tue, 17 Mar 2009 10:12:22 +0100
Message-Id: <1237281143-8768-5-git-send-email-wg@grandegger.com>
In-Reply-To: <1237281143-8768-4-git-send-email-wg@grandegger.com>
References: <1237281143-8768-1-git-send-email-wg@grandegger.com>
	<1237281143-8768-2-git-send-email-wg@grandegger.com>
	<1237281143-8768-3-git-send-email-wg@grandegger.com>
	<1237281143-8768-4-git-send-email-wg@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Wolfgang Grandegger <wg@grandegger.com>

This patch adds multi-chip support for the Micron MT29F8G08FAB NAND
flash memory on the TQM8548 modules.

This patch should go through the powerpc/85xx channel.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/tqm8548.dts |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index 81d3fbb..e5c3c67 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -389,6 +389,11 @@
 			reg = <3 0x0 0x800>;
 			fsl,upm-addr-offset = <0x10>;
 			fsl,upm-cmd-offset = <0x08>;
+			wait-flags = <0x05>;
+			/* Multi-chip device */
+			fsl,upm-mar-chip-offset = <0x200>;
+			max-chips = <2>;
+			chip-offset = <0x200>;
 			chip-delay = <25>; // in micro-seconds
 
 			nand@0 {
-- 
1.6.0.6
