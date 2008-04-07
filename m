Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 03EA7DDF34
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 08:08:21 +1000 (EST)
Date: Mon, 7 Apr 2008 15:08:06 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: paulus@samba.org
Message-ID: <20080407220806.GB24979@farnsworth.org>
References: <20080407220027.GA24510@farnsworth.org>
MIME-Version: 1.0
In-Reply-To: <20080407220027.GA24510@farnsworth.org>
Subject: [PATCH 2/8 v3] [POWERPC] prpmc2800: fix frequencies in prpmc2800.dts
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth <dale@farnsworth.org>

After the conversion to dts v1 format, seeing the frequencies
in decimal made it obvious that some of them had been
incorrectly truncated.  This fixes them.  Note that the PCI
frequency comes from a different source and is documented
as 66MHz, so it was left at 66000000.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Acked-by: Mark A. Greer <mgreer@mvista.com>

---
 arch/powerpc/boot/dts/prpmc2800.dts |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/prpmc2800.dts
+++ linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
@@ -27,7 +27,7 @@
 		PowerPC,7447 {
 			device_type = "cpu";
 			reg = <0>;
-			clock-frequency = <733000000>;	/* Default */
+			clock-frequency = <733333333>;	/* Default */
 			bus-frequency = <133333333>;
 			timebase-frequency = <33333333>;
 			i-cache-line-size = <32>;
@@ -137,7 +137,7 @@
 			compatible = "marvell,mv64x60-brg";
 			reg = <0xb200 0x8>;
 			clock-src = <8>;
-			clock-frequency = <133000000>;
+			clock-frequency = <133333333>;
 			current-speed = <9600>;
 			bcr = <0>;
 		};
@@ -146,7 +146,7 @@
 			compatible = "marvell,mv64x60-brg";
 			reg = <0xb208 0x8>;
 			clock-src = <8>;
-			clock-frequency = <133000000>;
+			clock-frequency = <133333333>;
 			current-speed = <9600>;
 			bcr = <0>;
 		};
