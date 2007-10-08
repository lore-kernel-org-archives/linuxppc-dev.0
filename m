Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A82EDDDE9
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 00:28:14 +1000 (EST)
Date: Mon, 8 Oct 2007 18:26:58 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC 440EPx Sequoia USB OHCI DTS entry
Message-ID: <20071008142658.GA15197@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PowerPC 440EPx Sequoia USB OHCI device tree entry.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/dts/sequoia.dts |    7 +++++++
 1 files changed, 7 insertions(+)

diff -pruN linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts linux-2.6/arch/powerpc/boot/dts/sequoia.dts
--- linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts	2007-10-08 16:29:54.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/dts/sequoia.dts	2007-10-08 17:56:05.000000000 +0400
@@ -122,6 +122,13 @@
 			interrupt-map-mask = <ffffffff>;
 		};
 
+		USB1: usb@e0000400 {
+			compatible = "ohci-be";
+			reg = <0 e0000400 60>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <15 8>;
+		};
+
 		POB0: opb {
 		  	compatible = "ibm,opb-440epx", "ibm,opb";
 			#address-cells = <1>;
