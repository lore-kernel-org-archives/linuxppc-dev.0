Return-Path: <hannes.hering@linux.vnet.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8EC31DDE9E
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 22:43:43 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m47ChLQj170704
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 12:43:21 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m47ChKqn1200380
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 13:43:20 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m47ChJa9023888
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 13:43:20 +0100
Subject: [PATCH 2/3] [2.6.26] ehea: Add dependency to Kconfig
From: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
Date: Wed, 7 May 2008 14:43:20 +0200
MIME-Version: 1.0
To: jeff@garzik.org
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805071443.20192.hannes.hering@linux.vnet.ibm.com>
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, raisch@de.ibm.com,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, ossthema@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new ehea memory hot plug implementation depends on MEMORY_HOTPLUG.

Signed-off-by: Hannes Hering <hering2@de.ibm.com>
---

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index f90a86b..181cd86 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2440,7 +2440,7 @@ config CHELSIO_T3
 
 config EHEA
 	tristate "eHEA Ethernet support"
-	depends on IBMEBUS && INET && SPARSEMEM
+	depends on IBMEBUS && INET && SPARSEMEM && MEMORY_HOTPLUG
 	select INET_LRO
 	---help---
 	  This driver supports the IBM pSeries eHEA ethernet adapter.
-- 
1.5.5.1
