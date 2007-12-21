Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 21 Dec 2007 15:39:35 +1100
Subject: [PATCH 18/21] [POWERPC] bamboo: remove bogus "ranges" property in EBC
	node
Message-Id: <20071221043939.72A8BDDFCF@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This removes a bogus empty "ranges" property in the EBC device node
of the Bamboo board device-tree.

The "ranges" property will be created by the boot wrapper, there is
no need to have an empty property there, and that causes recent
dtc to complain.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/boot/dts/bamboo.dts |    1 -
 1 file changed, 1 deletion(-)

--- linux-merge.orig/arch/powerpc/boot/dts/bamboo.dts	2007-12-21 14:35:23.000000000 +1100
+++ linux-merge/arch/powerpc/boot/dts/bamboo.dts	2007-12-21 14:35:25.000000000 +1100
@@ -126,7 +126,6 @@
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				ranges;
 				interrupts = <5 1>;
 				interrupt-parent = <&UIC1>;
 			};
