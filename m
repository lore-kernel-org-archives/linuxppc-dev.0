Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 8687ADDE1D
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 08:20:08 +1000 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP700K16CPJOE20@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:20:07 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd3mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP700JMECPIO480@pd3mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 30 Sep 2007 16:20:07 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP700261CPI8UG0@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:20:06 -0600 (MDT)
Date: Sun, 30 Sep 2007 16:20:06 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCHv2 0/4] Xilinx Virtex support for arch/powerpc
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20070930221613.583.252.stgit@trillian.cg.shawcable.net>
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

2nd version of Xilinx Virtex patches.  I've addressed all the comments
that I've received so far.  This series is just the arch/powerpc support
code.  I'll send the device driver changes in a seperate series for
each driver.

Cheers,
g.

 arch/powerpc/boot/Makefile          |    2 +-
 arch/powerpc/boot/ops.h             |    1 +
 arch/powerpc/boot/serial.c          |    2 +
 arch/powerpc/boot/uartlite.c        |   64 +++++++++++++++
 arch/powerpc/platforms/40x/Kconfig  |   38 ++++++---
 arch/powerpc/platforms/40x/Makefile |    1 +
 arch/powerpc/platforms/40x/virtex.c |   50 ++++++++++++
 arch/powerpc/sysdev/Makefile        |    1 +
 arch/powerpc/sysdev/xilinx_intc.c   |  151 +++++++++++++++++++++++++++++++++++
 include/asm-powerpc/xilinx_intc.h   |   20 +++++
 10 files changed, 316 insertions(+), 14 deletions(-)

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
