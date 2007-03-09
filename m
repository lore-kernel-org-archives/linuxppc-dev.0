Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id BE101DDEB7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Mar 2007 19:49:57 +1100 (EST)
Date: Fri, 9 Mar 2007 09:49:54 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] lite5200(b) dts: mscan.1 irq
Message-ID: <20070309084954.GA14658@moe.telargo.com>
References: <20070306095139.GZ4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070306095139.GZ4397@moe.telargo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

Found another one. ;-)

Btw. I forward ported Freescale's mscan patch to latest
peak-linux-driver. Should I send it somewhere? Where to?

--
Fix mscan irq number.
Tested with peak-linux-driver + patch from Freescale in
loopback mode.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 arch/powerpc/boot/dts/lite5200.dts  |    2 +-
 arch/powerpc/boot/dts/lite5200b.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: grant.git/arch/powerpc/boot/dts/lite5200.dts
===================================================================
--- grant.git.orig/arch/powerpc/boot/dts/lite5200.dts
+++ grant.git/arch/powerpc/boot/dts/lite5200.dts
@@ -167,7 +167,7 @@
 			device_type = "mscan";
 			compatible = "mpc5200-mscan";
 			cell-index = <1>;
-			interrupts = <1 12 0>;
+			interrupts = <2 12 0>;
 			interrupt-parent = <500>;
 			reg = <980 80>;
 		};
Index: grant.git/arch/powerpc/boot/dts/lite5200b.dts
===================================================================
--- grant.git.orig/arch/powerpc/boot/dts/lite5200b.dts
+++ grant.git/arch/powerpc/boot/dts/lite5200b.dts
@@ -167,7 +167,7 @@
 			device_type = "mscan";
 			compatible = "mpc5200b-mscan\0mpc5200-mscan";
 			cell-index = <1>;
-			interrupts = <1 12 0>;
+			interrupts = <2 12 0>;
 			interrupt-parent = <500>;
 			reg = <980 80>;
 		};
