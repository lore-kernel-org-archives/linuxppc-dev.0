Return-Path: <paulius.zaleckas@teltonika.lt>
Received: from teltonika.lt (81-7-68-229.static.zebra.lt [81.7.68.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7D75DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 01:39:26 +1100 (EST)
Received: from 82-135-208-232.static.zebra.lt (HELO
	Programuotojas.82-135-208-232.ip.zebra.lt)
	(paulius.zaleckas@[82.135.208.232])
	(envelope-sender <paulius.zaleckas@teltonika.lt>)
	by teltonika.lt (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 17 Nov 2008 14:30:16 -0000
From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Subject: [PATCH] Documentation: fix mdio-gpio name in booting-without-of.txt
To: linuxppc-dev@ozlabs.org
Date: Mon, 17 Nov 2008 16:32:39 +0200
Message-ID: <20081117143238.8214.68389.stgit@Programuotojas.82-135-208-232.ip.zebra.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
---

 Documentation/powerpc/booting-without-of.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 0ab0230..8670acc 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1822,7 +1822,7 @@ platforms are moved over to use the flattened-device-tree model.
    g) MDIO on GPIOs
 
    Currently defined compatibles:
-   - virtual,gpio-mdio
+   - virtual,mdio-gpio
 
    MDC and MDIO lines connected to GPIO controllers are listed in the
    gpios property as described in section VIII.1 in the following order:
