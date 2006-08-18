Return-Path: <ossthema@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1BFD67A3A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 22:07:37 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7IC7XiW031880
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 12:07:33 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7ICBR64153912
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 14:11:27 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7IC7XpW024077
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 14:07:33 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 0/7] ehea: IBM eHEA Ethernet Device Driver
Date: Fri, 18 Aug 2006 13:28:04 +0200
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200608181328.04607.ossthema@de.ibm.com>
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

Hello,

this is the latest version of the IBM eHEA Ethernet Device Driver.
The main difference to the previous version is the rework of the debug
mechanism. 
We highly appreciate further comments.

Thanks,
Jan-Bernd

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
Changelog-by:  Jan-Bernd Themann <themann@de.ibm.com>

Differences to patch set: http://www.spinics.net/lists/netdev/msg11593.html

Changelog:

- Logging rework (EDEB macros removed, netif_msg_X mechansim used)


 drivers/net/Kconfig             |    6 
 drivers/net/Makefile            |    1 
 drivers/net/ehea/Makefile       |    7 
 drivers/net/ehea/ehea.h         |  442 +++++++
 drivers/net/ehea/ehea_ethtool.c |  264 ++++
 drivers/net/ehea/ehea_hcall.h   |   51 
 drivers/net/ehea/ehea_hw.h      |  292 ++++
 drivers/net/ehea/ehea_main.c    | 2480 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/ehea/ehea_phyp.c    |  884 ++++++++++++++
 drivers/net/ehea/ehea_phyp.h    |  523 ++++++++
 drivers/net/ehea/ehea_qmr.c     |  643 ++++++++++
 drivers/net/ehea/ehea_qmr.h     |  367 +++++
 12 files changed, 5960 insertions(+)
