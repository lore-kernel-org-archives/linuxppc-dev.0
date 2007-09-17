Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 07EDADDE40
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 23:03:50 +1000 (EST)
Date: Mon, 17 Sep 2007 17:02:39 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] Add PowerPC 440EPx Sequoia ehci dts entry.
Message-ID: <20070917130239.GA29687@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917125039.GA29525@ru.mvista.com>
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch adds usb ehci entry to PowerPC440EPx Sequoia DTS.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/dts/sequoia.dts |    9 +++++++++
 1 file changed, 9 insertions(+)

diff -ruN linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts linux-2.6/arch/powerpc/boot/dts/sequoia.dts
--- linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts	2007-09-15 14:28:06.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/dts/sequoia.dts	2007-09-15 16:20:19.000000000 +0400
@@ -122,6 +122,15 @@
 			interrupt-map-mask = <ffffffff>;
 		};
 
+		USB0: ehci@e0000300 {
+			device_type = "usb";
+			compatible = "ibm,ehci-440epx", "ehci-be-desc", "ehci";
+			interrupt-parent = <&UIC0>;
+			interrupts = <1a 4>;
+			reg = <0 e0000300 ff>;
+			big-endian;
+		};
+
 		POB0: opb {
 		  	compatible = "ibm,opb-440epx", "ibm,opb";
 			#address-cells = <1>;
