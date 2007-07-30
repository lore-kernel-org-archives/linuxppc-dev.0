Return-Path: <ossthema@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C60EBDDFA6
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 01:54:14 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l6UFsArY065466
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 15:54:10 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6UFsALH3088408
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 16:54:10 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6UFrrDo004436
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 16:53:53 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 4/4][RFC] ehea: Kconfig
Date: Mon, 30 Jul 2007 17:24:55 +0200
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707301724.55804.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Andrew Gallatin <gallatin@myri.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kconfig changes for LRO

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

---
 drivers/net/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index f8a602c..fec4004 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2399,6 +2399,7 @@ config CHELSIO_T3
 config EHEA
 	tristate "eHEA Ethernet support"
 	depends on IBMEBUS
+	select INET_LRO
 	---help---
 	  This driver supports the IBM pSeries eHEA ethernet adapter.
 
-- 
1.5.2
