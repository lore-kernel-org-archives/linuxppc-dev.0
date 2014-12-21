Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F8AA1A0C77
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 08:16:04 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 28/28] macintosh: drop owner assignment from platform_drivers
Date: Sun, 21 Dec 2014 22:14:49 +0100
Message-Id: <1419196495-9626-29-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Cc: linuxppc-dev@lists.ozlabs.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This platform_driver does not need to set an owner, it will be populated by the
driver core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Generated with coccinelle. SmPL file is in the introductory msg. The big
cleanup was pulled in this merge window. This series catches the bits fallen
through. The patches shall go in via the subsystem trees.

 drivers/macintosh/windfarm_pm112.c | 1 -
 drivers/macintosh/windfarm_pm72.c  | 1 -
 drivers/macintosh/windfarm_rm31.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/macintosh/windfarm_pm112.c b/drivers/macintosh/windfarm_pm112.c
index 3024685e4cca..96d16fca68b2 100644
--- a/drivers/macintosh/windfarm_pm112.c
+++ b/drivers/macintosh/windfarm_pm112.c
@@ -668,7 +668,6 @@ static struct platform_driver wf_pm112_driver = {
 	.remove = wf_pm112_remove,
 	.driver = {
 		.name = "windfarm",
-		.owner	= THIS_MODULE,
 	},
 };
 
diff --git a/drivers/macintosh/windfarm_pm72.c b/drivers/macintosh/windfarm_pm72.c
index 2f506b9d5a52..e88cfb36a74d 100644
--- a/drivers/macintosh/windfarm_pm72.c
+++ b/drivers/macintosh/windfarm_pm72.c
@@ -789,7 +789,6 @@ static struct platform_driver wf_pm72_driver = {
 	.remove	= wf_pm72_remove,
 	.driver	= {
 		.name = "windfarm",
-		.owner	= THIS_MODULE,
 	},
 };
 
diff --git a/drivers/macintosh/windfarm_rm31.c b/drivers/macintosh/windfarm_rm31.c
index 82fc86a90c1a..bdfcb8a8bfbb 100644
--- a/drivers/macintosh/windfarm_rm31.c
+++ b/drivers/macintosh/windfarm_rm31.c
@@ -682,7 +682,6 @@ static struct platform_driver wf_rm31_driver = {
 	.remove	= wf_rm31_remove,
 	.driver	= {
 		.name = "windfarm",
-		.owner	= THIS_MODULE,
 	},
 };
 
-- 
2.1.3
