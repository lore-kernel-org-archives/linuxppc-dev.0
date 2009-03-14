Return-Path: <jdaniel@computer.org>
Received: from smtp104.sbc.mail.mud.yahoo.com (smtp104.sbc.mail.mud.yahoo.com
	[68.142.198.203]) by ozlabs.org (Postfix) with SMTP id 36091DE0F8
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Mar 2009 02:10:33 +1100 (EST)
Message-ID: <49BBC757.7090001@computer.org>
Date: Sat, 14 Mar 2009 10:03:51 -0500
From: Johns Daniel <jdaniel@computer.org>
MIME-Version: 1.0
To: greg@kroah.com
Subject: [PATCH] powerpc: Remove extra semicolon in fsl_soc.c (2nd try)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com, stable@kernel.org
Reply-To: jdaniel@computer.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

TSEC/MDIO will not work with older device trees because of a semicolon 
at the end of a macro resulting in an empty for loop body.

This fix only applies to 2.6.28; this code is gone in 2.6.29, according 
to Grant Likely!

Signed-off-by: Johns Daniel <johns.daniel@gmail.com 
<mailto:johns.daniel@gmail.com>>
======================================

--- linux-2.6.28.7/arch/powerpc/sysdev/fsl_soc.c.orig	2009-02-20 16:41:27.000000000 -0600
+++ linux-2.6.28.7/arch/powerpc/sysdev/fsl_soc.c	2009-03-14 09:01:38.994630400 -0500
@@ -257,7 +257,7 @@ static int __init gfar_mdio_of_init(void
		gfar_mdio_of_init_one(np);

	/* try the deprecated version */
-	for_each_compatible_node(np, "mdio", "gianfar");
+	for_each_compatible_node(np, "mdio", "gianfar")
		gfar_mdio_of_init_one(np);

	return 0;
