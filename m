Return-Path: <osstklei@de.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5CE9367D86
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 03:47:58 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id kA3GlqWP255562
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 16:47:52 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kA3GoXk72441220
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 16:50:33 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kA3GlqiD002937
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 16:47:52 GMT
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.19-rc4 2/3] ehea: Removed redundant define
Date: Fri, 3 Nov 2006 17:47:52 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200611031747.52210.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removed define H_CB_ALIGNMENT which is already defined in include/asm-powerpc/hvcall.h

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---

diff -Nurp git.netdev-2.6.base/drivers/net/ehea/ehea.h git.netdev-2.6/drivers/net/ehea/ehea.h
--- git.netdev-2.6.base/drivers/net/ehea/ehea.h	2006-11-03 14:19:51.000000000 +0100
+++ git.netdev-2.6/drivers/net/ehea/ehea.h	2006-11-03 14:37:30.000000000 +0100
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0034"
+#define DRV_VERSION	"EHEA_0043"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
@@ -105,9 +105,6 @@
 #define EHEA_BCMC_VLANID_ALL	0x01
 #define EHEA_BCMC_VLANID_SINGLE	0x00
 
-/* Use this define to kmallocate pHYP control blocks */
-#define H_CB_ALIGNMENT		4096
-
 #define EHEA_CACHE_LINE          128
 
 /* Memory Regions */
