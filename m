Return-Path: <arnd@arndb.de>
Message-Id: <20061219143453.419520000@arndb.de>
References: <20061219143240.705255000@arndb.de>
Date: Tue, 19 Dec 2006 15:32:46 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 6/6] powerpc: add scanning of ebc bus to of_platform
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch add scanning of ebc bus to of_platform, which is needed
to recognize devices located on that bus.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/kernel/of_platform.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/of_platform.c
+++ linux-2.6/arch/powerpc/kernel/of_platform.c
@@ -50,6 +50,7 @@ static struct of_device_id of_default_bu
 	{ .type = "plb5", },
 	{ .type = "plb4", },
 	{ .type = "opb", },
+	{ .type = "ebc", },
 	{},
 };
 

--
