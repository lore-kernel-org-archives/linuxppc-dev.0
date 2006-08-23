Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2FB7167BB4
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 19:36:08 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7N9a3Tp195232
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 09:36:03 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7N9c1HM565306
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 10:38:01 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7N9a2AI004963
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 10:36:03 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 0/7] ehea: IBM eHEA Ethernet Device Driver
Date: Wed, 23 Aug 2006 10:55:49 +0200
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608231055.49375.ossthema@de.ibm.com>
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

in this latest version of the IBM eHEA Ethernet Device Driver
we removed all unnecessary variable initializations and did some
code cleanup. We hope that we didn't miss to respond to any of your
suggestions. Please feel free to send us further feedback. We highly
appreciate your efforts.

Thanks,
Jan-Bernd

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
Changelog-by: =A0Jan-Bernd Themann <themann@de.ibm.com>

Differences to patch set http://www.spinics.net/lists/netdev/msg12702.html

Changelog:

=2D Unnecessary variable initializations removed
=2D Promiscuous mode support included

 drivers/net/Kconfig             |    9=20
 drivers/net/Makefile            |    1=20
 drivers/net/ehea/Makefile       |    7=20
 drivers/net/ehea/ehea.h         |  438 ++++++
 drivers/net/ehea/ehea_ethtool.c |  244 +++
 drivers/net/ehea/ehea_hcall.h   |   51=20
 drivers/net/ehea/ehea_hw.h      |  290 ++++
 drivers/net/ehea/ehea_main.c    | 2677 +++++++++++++++++++++++++++++++++++=
+++++
 drivers/net/ehea/ehea_phyp.c    |  784 +++++++++++
 drivers/net/ehea/ehea_phyp.h    |  463 ++++++
 drivers/net/ehea/ehea_qmr.c     |  607 +++++++++
 drivers/net/ehea/ehea_qmr.h     |  361 +++++
 12 files changed, 5932 insertions(+)
