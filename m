Return-Path: <ossthema@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF3A367BEA
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 23:30:22 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7MDUAvW139364
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 13:30:10 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7MDW6kk827410
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 14:32:06 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7MDU9VZ003599
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 14:30:09 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 0/7] ehea: IBM eHEA Ethernet Device Driver
Date: Tue, 22 Aug 2006 14:50:03 +0200
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608221450.03344.ossthema@de.ibm.com>
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

this is our current version of the IBM eHEA Ethernet Device Driver.
Thanks for the quick and helpful comments so far. Further comments
are highly appreciated.

Things we are currently working on:
=2D Implementation of promiscious mode support


Thanks,
Jan-Bernd

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
Changelog-by: =A0Jan-Bernd Themann <themann@de.ibm.com>

Differences to patch set http://www.spinics.net/lists/netdev/msg12326.html

Changelog:

=2D Error recovery
=2D improvements according to mailing list comments


 drivers/net/Kconfig             |    9=20
 drivers/net/Makefile            |    1=20
 drivers/net/ehea/Makefile       |    7=20
 drivers/net/ehea/ehea.h         |  437 ++++++
 drivers/net/ehea/ehea_ethtool.c |  244 +++
 drivers/net/ehea/ehea_hcall.h   |   51=20
 drivers/net/ehea/ehea_hw.h      |  290 ++++
 drivers/net/ehea/ehea_main.c    | 2636 +++++++++++++++++++++++++++++++++++=
+++++
 drivers/net/ehea/ehea_phyp.c    |  834 ++++++++++++
 drivers/net/ehea/ehea_phyp.h    |  479 +++++++
 drivers/net/ehea/ehea_qmr.c     |  634 +++++++++
 drivers/net/ehea/ehea_qmr.h     |  367 +++++
 12 files changed, 5989 insertions(+)
