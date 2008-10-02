Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep28-int.chello.at (viefep28-int.chello.at [62.179.121.48])
	by ozlabs.org (Postfix) with ESMTP id 7041FDDE06
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 15:36:43 +1000 (EST)
Received: from ng.localnet ([77.56.223.114]) by viefep28-int.chello.at
	(InterMail vM.7.08.02.02 201-2186-121-104-20070414) with ESMTP
	id <20081002053641.JCLV14600.viefep28-int.chello.at@ng.localnet>
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Oct 2008 07:36:41 +0200
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH]ppc4xx-Walnut: fixes early boot messages
Date: Thu, 2 Oct 2008 07:36:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810020736.40736.niklaus.giger@member.fsf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Inherits the baudrate from U-boot to print things like:
Using Walnut machine description                                          
Linux version <..>
console [udbg0] enabled                                                                                       

Signed-off-by: Niklaus Giger <niklaus.giger@member.fsf.org>
---
 arch/powerpc/boot/dts/walnut.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/walnut.dts 
b/arch/powerpc/boot/dts/walnut.dts
index 4a9f726..6c93f72 100644
--- a/arch/powerpc/boot/dts/walnut.dts
+++ b/arch/powerpc/boot/dts/walnut.dts
@@ -98,7 +98,7 @@
 				reg = <0xef600300 0x00000008>;
 				virtual-reg = <0xef600300>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				current-speed = <9600>;
+				current-speed = <0>;	/* Filled in by U-Boot */
 				interrupt-parent = <&UIC0>;
 				interrupts = <0x0 0x4>;
 			};
-- 
1.6.0.1
