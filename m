Return-Path: <ossthema@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5E75167B95
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Sep 2006 21:18:42 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.7/8.13.7) with ESMTP id k84BIbFs114726
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Sep 2006 11:18:37 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k84BMwem2900168
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Sep 2006 13:22:58 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k84BIa8B019169
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Sep 2006 13:18:36 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Date: Mon, 4 Sep 2006 12:36:32 +0200
MIME-Version: 1.0
Subject: [2.6.19 PATCH 0/7] ehea: IBM eHEA Ethernet Device Driver
To: netdev <netdev@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609041236.32279.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

this is our current version of the IBM eHEA Ethernet Device Driver. We adde=
d=20
minor bug fixes and changes to the last version.

Jeff, this driver has been discussed on the netdev, linux-ppc and=20
kernel mailing list. We didn't receive any further comments since our previ=
ous
patch set from August 23. Please consider our driver for
upstream inclusion.

Thanks,

Jan-Bernd Themann & Christoph Raisch

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
Changelog-by: =A0Jan-Bernd Themann <themann@de.ibm.com>

Differences to patch set http://www.spinics.net/lists/netdev/msg12820.html

Changelog:
=2D struct ehea_q_skb_arr introduced to simplify struct ehea_port_res
=2D promiscuous mode added
=2D enhanced ethtool support (set port speed)
=2D destroy functions for QPs, CQs, EQs, MRs reduced to single function
=2D Bux fix: xmit locking


 drivers/net/Kconfig             |    9=20
 drivers/net/Makefile            |    1=20
 drivers/net/ehea/Makefile       |    6=20
 drivers/net/ehea/ehea.h         |  444 ++++++
 drivers/net/ehea/ehea_ethtool.c |  292 ++++
 drivers/net/ehea/ehea_hcall.h   |   51=20
 drivers/net/ehea/ehea_hw.h      |  290 ++++
 drivers/net/ehea/ehea_main.c    | 2694 +++++++++++++++++++++++++++++++++++=
+++++
 drivers/net/ehea/ehea_phyp.c    |  705 ++++++++++
 drivers/net/ehea/ehea_phyp.h    |  454 ++++++
 drivers/net/ehea/ehea_qmr.c     |  605 ++++++++
 drivers/net/ehea/ehea_qmr.h     |  361 +++++
 12 files changed, 5912 insertions(+)
