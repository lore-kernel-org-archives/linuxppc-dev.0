Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 4B6F5DE044
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 16:01:47 +1000 (EST)
Received: from pd2mr3so.prod.shaw.ca
	(pd2mr3so-qfe3.prod.shaw.ca [10.0.141.108]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPS00JYYBEWQ880@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 12 Oct 2007 00:01:44 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd2mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPS00AKOBEXXY70@pd2mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 12 Oct 2007 00:01:45 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPS00IGQBEVFM10@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 12 Oct 2007 00:01:44 -0600 (MDT)
Date: Fri, 12 Oct 2007 00:01:44 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2] XilinxFB: typo bugfix
In-reply-to: <20071012055826.9718.2510.stgit@trillian.cg.shawcable.net>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Message-id: <20071012060143.9718.86343.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071012055826.9718.2510.stgit@trillian.cg.shawcable.net>
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

 drivers/video/xilinxfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 6ef99b2..e38d3b7 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -84,7 +84,7 @@ static struct xilinxfb_platform_data xilinx_fb_default_pdata = {
 	.xres = 640,
 	.yres = 480,
 	.xvirt = 1024,
-	.yvirt = 480;
+	.yvirt = 480,
 };
 
 /*
