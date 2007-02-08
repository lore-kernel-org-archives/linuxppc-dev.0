Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 1FF77DDEF8
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 03:57:06 +1100 (EST)
Date: Thu, 8 Feb 2007 10:56:50 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] Added QE to the list of default scanned OF devices
Message-ID: <Pine.LNX.4.61.0702081056250.15256@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Andrew Fleming <afleming@freescale.com>
---
 arch/powerpc/kernel/of_platform.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index b734517..43c5a00 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -51,6 +51,7 @@ static struct of_device_id of_default_bu
 	{ .type = "plb4", },
 	{ .type = "opb", },
 	{ .type = "ebc", },
+	{ .type = "qe", },
 	{},
 };
 
-- 
1.4.4
