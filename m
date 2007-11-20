Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 48387DDEAB
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 17:08:58 +1100 (EST)
Received: from pd2mr1so.prod.shaw.ca
	(pd2mr1so-qfe3.prod.shaw.ca [10.0.141.110]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JRS0063LJQRBC80@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 19 Nov 2007 23:08:51 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd2mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JRS000B7JQQZL10@pd2mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 19 Nov 2007 23:08:51 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JRS00GS7JQP1V70@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 19 Nov 2007 23:08:50 -0700 (MST)
Date: Mon, 19 Nov 2007 23:08:49 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [PPC] Remove xmon from ml300 and ml403 defconfig
To: "jwboyer@"@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
Message-id: <20071120060435.18259.23444.stgit@trillian.cg.shawcable.net>
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

xmon is broken under arch/ppc so remove it from the defconfig.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Josh; I'm not going to even bother doing a full defconfig update for these
boards right now; it's probably not worth it.  This change just eliminates
the xmon build issue.  Plus doing it this way is trivial to review.  :-)

In fact; looking at the code, I don't think xmon builds for *any* arch/ppc
platforms at the moment.  :-/  Probably not even worth worrying about.

As we discussed, this should go in for .24

Cheers,
g.

 arch/ppc/configs/ml300_defconfig |    2 +-
 arch/ppc/configs/ml403_defconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/configs/ml300_defconfig b/arch/ppc/configs/ml300_defconfig
index 69bad91..d66cacd 100644
--- a/arch/ppc/configs/ml300_defconfig
+++ b/arch/ppc/configs/ml300_defconfig
@@ -719,7 +719,7 @@ CONFIG_DEBUG_INFO=y
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_KGDB is not set
-CONFIG_XMON=y
+# CONFIG_XMON is not set
 # CONFIG_BDI_SWITCH is not set
 # CONFIG_SERIAL_TEXT_DEBUG is not set
 
diff --git a/arch/ppc/configs/ml403_defconfig b/arch/ppc/configs/ml403_defconfig
index a78896e..71bcfa7 100644
--- a/arch/ppc/configs/ml403_defconfig
+++ b/arch/ppc/configs/ml403_defconfig
@@ -720,7 +720,7 @@ CONFIG_DEBUG_INFO=y
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_KGDB is not set
-CONFIG_XMON=y
+# CONFIG_XMON is not set
 # CONFIG_BDI_SWITCH is not set
 # CONFIG_SERIAL_TEXT_DEBUG is not set
 
