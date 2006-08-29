Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58C2467A3A
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 08:58:07 +1000 (EST)
Subject: [PATCH] powerpc: Fix MPIC sense codes in doc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 08:58:00 +1000
Message-Id: <1156892280.8433.585.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The booting-without-of.txt had incorrect definition for the sense codes
for an OpenPIC controller

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/Documentation/powerpc/booting-without-of.txt
===================================================================
--- linux-work.orig/Documentation/powerpc/booting-without-of.txt	2006-08-30 08:51:19.000000000 +1000
+++ linux-work/Documentation/powerpc/booting-without-of.txt	2006-08-30 08:56:17.000000000 +1000
@@ -1136,10 +1136,10 @@
    Devices connected to openPIC-compatible controllers should encode
    sense and polarity as follows:
 
-	0 = high to low edge sensitive type enabled
+	0 = low to high edge sensitive type enabled
 	1 = active low level sensitive type enabled
-	2 = low to high edge sensitive type enabled
-	3 = active high level sensitive type enabled
+	2 = active high level sensitive type enabled
+	3 = high to low edge sensitive type enabled
 
    ISA PIC interrupt controllers should adhere to the ISA PIC
    encodings listed below:
