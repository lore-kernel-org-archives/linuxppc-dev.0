Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A05FCDDE9D
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 04:25:58 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l8DIOrmn026566
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 22:24:53 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l8DIOrWP026563
	for linuxppc-dev@ozlabs.org; Thu, 13 Sep 2007 22:24:53 +0400
Date: Thu, 13 Sep 2007 22:24:53 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC: usb ehci of_platform bindings for Sequoia 440EPx
Message-ID: <20070913182453.GA26541@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070913131851.56fcc377@weaponx.rchland.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

EHCI OF bindings for PowerPC 440EPx Sequoia.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/dts/sequoia.dts |    7 +++++++
 1 files changed, 7 insertions(+)

diff -ruN linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts linux-2.6.bld/arch/powerpc/boot/dts/sequoia.dts
--- linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts	2007-09-13 20:58:18.000000000 +0400
+++ linux-2.6.bld/arch/powerpc/boot/dts/sequoia.dts	2007-09-13 21:32:49.000000000 +0400
@@ -122,6 +122,13 @@
 			interrupt-map-mask = <ffffffff>;
 		};
 
+		usb@e0000300 {
+			compatible = "ibm,ehci-440epx", "ehci-be-desc", "ehci-be-mmio";
+			interrupt-parent = <&UIC0>;
+			interrupts = <1a 4>;
+			reg = <0 e0000300 ff>;
+		};
+
 		POB0: opb {
 		  	compatible = "ibm,opb-440epx", "ibm,opb";
 			#address-cells = <1>;
