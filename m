Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id B52CCDDF6E
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 12:15:46 +1000 (EST)
Received: from pd2mr4so.prod.shaw.ca
	(pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP9008J1IA9B850@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 01 Oct 2007 20:15:45 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd2mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP900M05IA7M390@pd2mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 01 Oct 2007 20:15:44 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP900FNLI9VZ7M1@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 01 Oct 2007 20:15:31 -0600 (MDT)
Date: Mon, 01 Oct 2007 20:15:34 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v3 05/12] Add PowerPC Xilinx Virtex entry to maintainers
In-reply-to: <20071002021334.9579.68179.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20071002021534.9579.88411.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071002021334.9579.68179.stgit@trillian.cg.shawcable.net>
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

 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f80068..bca4ca5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2304,6 +2304,13 @@ L:	linuxppc-embedded@ozlabs.org
 T:	git kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc.git
 S:	Maintained
 
+LINUX FOR POWERPC EMBEDDED XILINX VIRTEX
+P:	Grant Likely
+M:	grant.likely@secretlab.ca
+W:	http://www.secretlab.ca/
+L:	linuxppc-dev@ozlabs.org
+S:	Maintained
+
 LINUX FOR POWERPC BOOT CODE
 P:	Tom Rini
 M:	trini@kernel.crashing.org
