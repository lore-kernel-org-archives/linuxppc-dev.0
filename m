Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id 6E492DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 01:14:20 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so148168nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 06:14:17 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] dts-bindings/fsl/dma.txt: fix IRQ number in mpc83xx dma
	example
Date: Wed, 14 Jan 2009 15:14:13 +0100
Message-Id: <1231942453-17898-1-git-send-email-jacmet@sunsite.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The DMAC IRQ number of the mpc8349 is 71 and not 47, according to
http://www.freescale.com/files/32bit/doc/ref_manual/MPC8349EARMAD.pdf

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 Documentation/powerpc/dts-bindings/fsl/dma.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/dma.txt b/Documentation/powerpc/dts-bindings/fsl/dma.txt
index cc45311..3df1552 100644
--- a/Documentation/powerpc/dts-bindings/fsl/dma.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/dma.txt
@@ -38,7 +38,7 @@ Example:
 		reg = <82a8 4>;
 		ranges = <0 8100 1a4>;
 		interrupt-parent = <&ipic>;
-		interrupts = <47 8>;
+		interrupts = <71 8>;
 		cell-index = <0>;
 		dma-channel@0 {
 			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
-- 
1.5.6.5
