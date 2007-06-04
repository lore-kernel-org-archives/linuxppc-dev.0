Return-Path: <b08248@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C1F16DDEC0
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 07:16:21 +1000 (EST)
Date: Mon, 4 Jun 2007 16:16:15 -0500
From: Stuart Yoder <b08248@freescale.com>
Message-Id: <200706042116.l54LGFuZ022877@ld0164-tx32.am.freescale.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: fix typo in booting-without-of-txt section numbering
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From 799bc4dbad6b4e8c2d88c7c2c4746072b9175222 Mon Sep 17 00:00:00 2001
From: Stuart Yoder <stuart.yoder@freescale.com>
Date: Mon, 4 Jun 2007 16:08:35 -0500
Subject: [PATCH] test

Fix typo in section numbering.


Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index b49ce16..258a279 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1687,7 +1687,7 @@ platforms are moved over to use the flattened-device-tree model.
 		};
 	};
 
-    g) Flash chip nodes
+    j) Flash chip nodes
 
     Flash chips (Memory Technology Devices) are often used for solid state
     file systems on embedded devices.
-- 
1.5.0.3
