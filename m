Return-Path: <grant.likely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C8F6B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Jan 2011 08:07:46 +1100 (EST)
Received: by iwn42 with SMTP id 42so15142424iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 03 Jan 2011 13:07:43 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH] powerpc/dts: fix syntax bugs in bluestone.dts
To: tmarri@apm.com, jwboyer@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 03 Jan 2011 14:07:40 -0700
Message-ID: <20110103210715.10427.56175.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

I'm picking this one up immediately into my next-devicetree branch

g.

 arch/powerpc/boot/dts/bluestone.dts |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/bluestone.dts
index 9bb3d72..2a56a0d 100644
--- a/arch/powerpc/boot/dts/bluestone.dts
+++ b/arch/powerpc/boot/dts/bluestone.dts
@@ -33,7 +33,7 @@
 	aliases {
 		ethernet0 = &EMAC0;
 		serial0 = &UART0;
-		serial1 = &UART1;
+		//serial1 = &UART1; --gcl missing UART1 label
 	};
 
 	cpus {
@@ -52,7 +52,7 @@
 			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
-			next-level-cache = <&L2C0>;
+			//next-level-cache = <&L2C0>; --gcl missing L2C0 label
 		};
 	};
 
@@ -142,7 +142,7 @@
 					/*RXEOB*/ 0x7 0x4
 					/*SERR*/  0x3 0x4
 					/*TXDE*/  0x4 0x4
-					/*RXDE*/  0x5 0x4
+					/*RXDE*/  0x5 0x4>;
 		};
 
 		POB0: opb {
@@ -182,7 +182,7 @@
 						reg = <0x001a0000 0x00060000>;
 					};
 				};
-			}
+			};
 
 			UART0: serial@ef600300 {
 				device_type = "serial";
