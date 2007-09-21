Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B8F86DDEC8
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 14:41:13 +1000 (EST)
Date: Fri, 21 Sep 2007 14:36:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 07/11] [POWERPC] iSeries: missing newline in printk
Message-Id: <20070921143647.7ceebabc.sfr@canb.auug.org.au>
In-Reply-To: <20070921143540.75f3becf.sfr@canb.auug.org.au>
References: <20070921135533.461eecdf.sfr@canb.auug.org.au>
	<20070921142928.64451ad8.sfr@canb.auug.org.au>
	<20070921143102.eb30d770.sfr@canb.auug.org.au>
	<20070921143205.64271521.sfr@canb.auug.org.au>
	<20070921143337.0e4a2f0a.sfr@canb.auug.org.au>
	<20070921143446.ad55d494.sfr@canb.auug.org.au>
	<20070921143540.75f3becf.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/viopath.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/viopath.c b/arch/powerpc/platforms/iseries/viopath.c
index 7106a05..df23331 100644
--- a/arch/powerpc/platforms/iseries/viopath.c
+++ b/arch/powerpc/platforms/iseries/viopath.c
@@ -594,7 +594,7 @@ int viopath_close(HvLpIndex remoteLp, int subtype, int numReq)
 		numOpen += viopathStatus[remoteLp].users[i];
 
 	if ((viopathStatus[remoteLp].isOpen) && (numOpen == 0)) {
-		printk(VIOPATH_KERN_INFO "closing connection to partition %d",
+		printk(VIOPATH_KERN_INFO "closing connection to partition %d\n",
 				remoteLp);
 
 		HvCallEvent_closeLpEventPath(remoteLp,
-- 
1.5.3.2
