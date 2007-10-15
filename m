Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 63EA4DDEBC
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 04:15:08 +1000 (EST)
Date: Mon, 15 Oct 2007 21:58:37 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC: Enable NEW EMAC support for Sequoia 440EPx.
Message-ID: <20071015175837.GA4631@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071015122616.08250b54@weaponx.rchland.ibm.com>
Cc: netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch enables NEW EMAC support for PowerPC 440EPx Sequoia board.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/platforms/44x/Kconfig |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- linux.orig/arch/powerpc/platforms/44x/Kconfig	2007-07-30 15:05:50.000000000 +0400
+++ linux/arch/powerpc/platforms/44x/Kconfig	2007-07-30 17:59:05.000000000 +0400
@@ -48,10 +48,9 @@
 config 440EPX
 	bool
 	select PPC_FPU
-# Disabled until the new EMAC Driver is merged.
-#	select IBM_NEW_EMAC_EMAC4
-#	select IBM_NEW_EMAC_RGMII
-#	select IBM_NEW_EMAC_ZMII
+	select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_RGMII
+	select IBM_NEW_EMAC_ZMII
 
 config 440GP
 	bool
