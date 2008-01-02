Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 9A5CEDDDF4
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 04:26:28 +1100 (EST)
Received: from pd4mr1so.prod.shaw.ca
	(pd4mr1so-qfe3.prod.shaw.ca [10.0.141.212]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JU100AOA1PL7D80@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 02 Jan 2008 10:24:57 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd4mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JU100I9J1O65I00@pd4mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 02 Jan 2008 10:24:07 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JU100I8R1O6IS30@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 02 Jan 2008 10:24:06 -0700 (MST)
Date: Wed, 02 Jan 2008 10:23:56 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] Sequoia: typo in calling machine_device_initcall()
To: jwboyer@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
Message-id: <20080102172356.26645.63895.stgit@trillian.secretlab.ca>
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

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/44x/sequoia.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/44x/sequoia.c b/arch/powerpc/platforms/44x/sequoia.c
index 374f8c7..d279db4 100644
--- a/arch/powerpc/platforms/44x/sequoia.c
+++ b/arch/powerpc/platforms/44x/sequoia.c
@@ -38,7 +38,7 @@ static int __init sequoia_device_probe(void)
 
 	return 0;
 }
-machien_device_initcall(sequoia, sequoia_device_probe);
+machine_device_initcall(sequoia, sequoia_device_probe);
 
 static int __init sequoia_probe(void)
 {
