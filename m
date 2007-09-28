Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id DF150DDEFC
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 04:17:04 +1000 (EST)
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300AS2C43WC60@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:16:51 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP300919C42VT20@pd3mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Sep 2007 12:16:51 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300C5IC427I70@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:16:50 -0600 (MDT)
Date: Fri, 28 Sep 2007 12:16:59 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 05/18] Add PowerPC Xilinx Virtex entry to maintainers
In-reply-to: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20070928181627.18608.29878.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Paul, is this okay by you?  Josh has already okayed it.

Cheers,
g.

 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f80068..ea4ff15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2304,6 +2304,13 @@ L:	linuxppc-embedded@ozlabs.org
 T:	git kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc.git
 S:	Maintained
 
+LINUX FOR POWERPC EMBEDDED XILINX VIRTEX
+P:	Grant Likely
+M:	grant.likely@secretlab.ca
+W:	http://www.secretlab.ca/
+L:	linuxppc-embedded@ozlabs.org
+S:	Maintained
+
 LINUX FOR POWERPC BOOT CODE
 P:	Tom Rini
 M:	trini@kernel.crashing.org
