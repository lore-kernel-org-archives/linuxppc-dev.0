Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id BB17FDDE16
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 08:57:04 +1000 (EST)
Received: from pd4mr4so.prod.shaw.ca
	(pd4mr4so-qfe3.prod.shaw.ca [10.0.141.215]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP700EEWEF33K50@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:57:03 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd4mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP700C1AEF3YK40@pd4mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 30 Sep 2007 16:57:04 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP700FEAEF26C94@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:57:02 -0600 (MDT)
Date: Sun, 30 Sep 2007 16:57:02 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 1/6] Add Xilinx SystemACE entry to maintainers
In-reply-to: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	axboe@kernel.dk
Message-id: <20070930225700.2476.2216.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

I'm the author of the SystemACE driver

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f80068..cb6323e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4179,6 +4179,13 @@ W:	http://oss.sgi.com/projects/xfs
 T:	git git://oss.sgi.com:8090/xfs/xfs-2.6.git
 S:	Supported
 
+XILINX SYSTEMACE DRIVER
+P:	Grant Likely
+M:	grant.likely@secretlab.ca
+W:	http://www.secretlab.ca/
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 XILINX UARTLITE SERIAL DRIVER
 P:	Peter Korsgaard
 M:	jacmet@sunsite.dk
