Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 1E745DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 19:52:00 +1100 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id CDD0BF4919C
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 09:51:57 +0100 (CET)
Subject: [PATCH] using mii-bitbang on different processor ports - update
	the booting-without-of.txt-file
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jgarzik@pobox.com
Date: Tue, 06 Nov 2007 09:51:57 +0100
Message-Id: <1194339117.3467.8.camel@p60635-ste.ids.de>
Mime-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch updates the booting-without-of.txt-file.
There is a description for the case
if mdio data and clock pins are on different processor ports.
It is a extending for e-mail "[PATCH v3] using mii-bitbang on different processor ports".

Signed-off-by: Sergej Stepanov <Sergej.Stepanov@ids.de>
--

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index a96e853..497d8d8 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1956,6 +1956,12 @@ platforms are moved over to use the flattened-device-tree model.
 		fsl,mdc-pin = <13>;
 	};
 
+   The "reg"-property may have also depending on board design
+   the following form:
+	reg = <10d40 14 10d60 14>;
+   In that case the pin for mdio data controlling is on the port C,
+   and the pin for mdio clock controlling is on the port D.
+
    v) Baud Rate Generators
 
    Currently defined compatibles:
