Return-Path: <rpjday@crashcourse.ca>
Received: from cpanel2.indieserve.net (cpanel2.indieserve.net [199.212.143.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkmrQ49clzDqYy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Sep 2017 16:47:32 +1000 (AEST)
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com
 ([174.118.92.171]:47232 helo=localhost.localdomain)
 by cpanel2.indieserve.net with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <rpjday@crashcourse.ca>) id 1do2DI-0007IJ-E0
 for linuxppc-dev@lists.ozlabs.org; Sat, 02 Sep 2017 02:47:28 -0400
Date: Sat, 2 Sep 2017 02:47:26 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] arch/powerpc: Standardize DTS status assignments from "ok"
 to "okay"
Message-ID: <alpine.LFD.2.21.1709020244110.10577@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


While the current kernel drivers/of/ code allows developers to be
sloppy and use a DTS status value of "ok", the current DTSpec 0.1
makes it clear that the proper spelling is "okay", so fix the small
number of PowerPC .dts files that do this.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/arch/powerpc/boot/dts/akebono.dts b/arch/powerpc/boot/dts/akebono.dts
index e61d5dc..660ee21 100644
--- a/arch/powerpc/boot/dts/akebono.dts
+++ b/arch/powerpc/boot/dts/akebono.dts
@@ -40,7 +40,7 @@
 			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
-			status = "ok";
+			status = "okay";
 		};
 		cpu@1 {
 			device_type = "cpu";
diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/bluestone.dts
index b0b26d8..64eaf7e 100644
--- a/arch/powerpc/boot/dts/bluestone.dts
+++ b/arch/powerpc/boot/dts/bluestone.dts
@@ -109,7 +109,7 @@

 	OCM: ocm@400040000 {
 		compatible = "ibm,ocm";
-		status = "ok";
+		status = "okay";
 		cell-index = <1>;
 		/* configured in U-Boot */
 		reg = <4 0x00040000 0x8000>; /* 32K */
diff --git a/arch/powerpc/boot/dts/currituck.dts b/arch/powerpc/boot/dts/currituck.dts
index 4191e18..093c4bc 100644
--- a/arch/powerpc/boot/dts/currituck.dts
+++ b/arch/powerpc/boot/dts/currituck.dts
@@ -39,7 +39,7 @@
 			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
-			status = "ok";
+			status = "okay";
 		};
 		cpu@1 {
 			device_type = "cpu";
diff --git a/arch/powerpc/boot/dts/iss4xx-mpic.dts b/arch/powerpc/boot/dts/iss4xx-mpic.dts
index 23e9d9b..9804ada 100644
--- a/arch/powerpc/boot/dts/iss4xx-mpic.dts
+++ b/arch/powerpc/boot/dts/iss4xx-mpic.dts
@@ -43,7 +43,7 @@
 			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
-			status = "ok";
+			status = "okay";
 		};
 		cpu@1 {
 			device_type = "cpu";

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
