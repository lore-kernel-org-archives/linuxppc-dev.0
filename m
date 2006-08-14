Return-Path: <ossthema@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8CAE567C82
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 02:32:19 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7EGW1rS084356
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 16:32:01 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7EGXrUl144290
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 17:33:53 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7EGW1CY031221
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 17:32:01 +0100
Message-ID: <44E0A580.9020507@de.ibm.com>
Date: Mon, 14 Aug 2006 18:32:00 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
Subject: [PATCH 7/7] ehea: Makefile & Kconfig
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>


  drivers/net/Kconfig  |    6 ++++++
  drivers/net/Makefile |    1 +
  2 files changed, 7 insertions(+)



diff -Nurp -X dontdiff linux-2.6.18-rc4/drivers/net/Kconfig patched_kernel/drivers/net/Kconfig
--- linux-2.6.18-rc4/drivers/net/Kconfig	2006-08-06 11:20:11.000000000 -0700
+++ patched_kernel/drivers/net/Kconfig	2006-08-08 03:00:49.526421944 -0700
@@ -2277,6 +2277,12 @@ config CHELSIO_T1
            To compile this driver as a module, choose M here: the module
            will be called cxgb.

+config EHEA
+        tristate "eHEA Ethernet support"
+        depends on IBMEBUS
+        ---help---
+          This driver supports the IBM pSeries ethernet adapter
+
  config IXGB
  	tristate "Intel(R) PRO/10GbE support"
  	depends on PCI
diff -Nurp -X dontdiff linux-2.6.18-rc4/drivers/net/Makefile patched_kernel/drivers/net/Makefile
--- linux-2.6.18-rc4/drivers/net/Makefile	2006-08-06 11:20:11.000000000 -0700
+++ patched_kernel/drivers/net/Makefile	2006-08-08 03:00:30.061451584 -0700
@@ -10,6 +10,7 @@ obj-$(CONFIG_E1000) += e1000/
  obj-$(CONFIG_IBM_EMAC) += ibm_emac/
  obj-$(CONFIG_IXGB) += ixgb/
  obj-$(CONFIG_CHELSIO_T1) += chelsio/
+obj-$(CONFIG_EHEA) += ehea/
  obj-$(CONFIG_BONDING) += bonding/
  obj-$(CONFIG_GIANFAR) += gianfar_driver.o
