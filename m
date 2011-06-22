Return-Path: <mike@mikebwilliams.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42183B6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 02:10:11 +1000 (EST)
Received: by vws20 with SMTP id 20so783941vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 09:10:07 -0700 (PDT)
From: Mike Williams <mike@mikebwilliams.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc,
	ppc4xx: Update canyonlands and glacier boards DTS to add HW RNG
	support
Date: Wed, 22 Jun 2011 12:09:43 -0400
Message-Id: <1308758983-15687-1-git-send-email-mike@mikebwilliams.com>
Cc: Mike Williams <mike@mikebwilliams.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Mike Williams <mike@mikebwilliams.com>
---
 arch/powerpc/boot/dts/canyonlands.dts |    5 +++++
 arch/powerpc/boot/dts/glacier.dts     |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index 22dd6ae..3dc75de 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -143,6 +143,11 @@
 			interrupts = <0x1d 0x4>;
 		};
 
+		HWRNG: hwrng@110000 {
+			compatible = "amcc,ppc460ex-rng", "ppc4xx-rng";
+			reg = <4 0x00110000 0x50>;
+		};
+
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-460ex", "ibm,mcmal2";
 			dcr-reg = <0x180 0x062>;
diff --git a/arch/powerpc/boot/dts/glacier.dts b/arch/powerpc/boot/dts/glacier.dts
index e618fc4..b153a73 100644
--- a/arch/powerpc/boot/dts/glacier.dts
+++ b/arch/powerpc/boot/dts/glacier.dts
@@ -136,6 +136,11 @@
 			interrupts = <0x1d 0x4>;
 		};
 
+		HWRNG: hwrng@110000 {
+			compatible = "amcc,ppc460ex-rng", "ppc4xx-rng";
+			reg = <4 0x00110000 0x50>;
+		};
+
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-460gt", "ibm,mcmal2";
 			dcr-reg = <0x180 0x062>;
-- 
1.7.3.4
