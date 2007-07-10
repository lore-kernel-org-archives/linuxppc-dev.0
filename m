Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3EDEDDDEBE
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 16:57:50 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6A6vjwf022118
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 23:57:46 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6A6viJO012981
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 01:57:45 -0500 (CDT)
Message-ID: <46932E5B.4040107@freescale.com>
Date: Tue, 10 Jul 2007 14:59:39 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH] powerpc: Fix typo in Ebony default dts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
diff --git a/arch/powerpc/boot/dts/ebony.dts b/arch/powerpc/boot/dts/ebony.dts
index 0ec02f4..59bbae2 100644
--- a/arch/powerpc/boot/dts/ebony.dts
+++ b/arch/powerpc/boot/dts/ebony.dts
@@ -31,8 +31,8 @@
 			reg = <0>;
 			clock-frequency = <0>; // Filled in by zImage
 			timebase-frequency = <0>; // Filled in by zImage
-			i-cache-line-size = <32>;
-			d-cache-line-size = <32>;
+			i-cache-line-size = <20>;
+			d-cache-line-size = <20>;
 			i-cache-size = <8000>; /* 32 kB */
 			d-cache-size = <8000>; /* 32 kB */
 			dcr-controller;
