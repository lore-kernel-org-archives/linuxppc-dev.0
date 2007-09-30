Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 8B6A5DE254
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 08:57:45 +1000 (EST)
Received: from pd4mr4so.prod.shaw.ca
	(pd4mr4so-qfe3.prod.shaw.ca [10.0.141.215]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP7000DKEF3T9A0@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:57:03 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd4mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP700C1AEF3YK40@pd4mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 30 Sep 2007 16:57:04 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP700K9DEEVD3UC@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:56:55 -0600 (MDT)
Date: Sun, 30 Sep 2007 16:56:55 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 0/6] SystemACE: rework and of_platform bus binding patches
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	axboe@kernel.dk
Message-id: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a set of rework patches on the Xilinx SystemACE driver which ends
in the addition of an of_platform bus binding.  The of_platform bus binding
is needed to use the driver from arch/powerpc.  SystemACE is most commonly
used in Xilinx Virtex system (ppc405).

Jens, I'm hoping I can get these changes in for 2.6.24.  Assuming nobody
raises any issues, can you please merge these into your tree?

Thanks,
g.

Grant Likely (6):
 Add Xilinx SystemACE entry to maintainers
 Sysace: Use the established platform bus api
 Sysace: Move structure allocation from bus binding into common code
 Sysace: minor rework and cleanup changes
 Sysace: Move IRQ handler registration to occur after FSM is initialized
 Sysace: Add of_platform_bus binding

 MAINTAINERS             |    7 ++
 drivers/block/xsysace.c |  249 +++++++++++++++++++++++++++++++++++-----------
       2 files changed, 196 insertions(+), 60 deletions(-)

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
