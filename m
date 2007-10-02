Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4EEC2DDFCF
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 07:23:25 +1000 (EST)
Date: Tue, 2 Oct 2007 16:27:28 -0500
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH] [8/11] pasemi_mac: update todo list
Message-ID: <20071002212728.GI2282@lixom.net>
References: <20071002212421.GA2282@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071002212421.GA2282@lixom.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pasemi_mac: update todo list

Remove some stale todo items that have been taken care of. Add a couple
of upcoming ones.

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6.23/drivers/net/pasemi_mac.c
===================================================================
--- 2.6.23.orig/drivers/net/pasemi_mac.c
+++ 2.6.23/drivers/net/pasemi_mac.c
@@ -46,12 +46,10 @@
 
 /* TODO list
  *
- * - Get rid of pci_{read,write}_config(), map registers with ioremap
- *   for performance
- * - PHY support
  * - Multicast support
  * - Large MTU support
- * - Other performance improvements
+ * - SW LRO
+ * - Multiqueue RX/TX
  */
 
 
