Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 87FDAB70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Sep 2010 05:48:25 +1000 (EST)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 04/25] drivers/char: Use static const char arrays
Date: Mon, 13 Sep 2010 12:47:42 -0700
Message-Id: <a2936d6a439d294efa41dd567d29d0d301e844de.1284406638.git.joe@perches.com>
In-Reply-To: <cover.1284406638.git.joe@perches.com>
References: <cover.1284406638.git.joe@perches.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/char/hvc_vio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/hvc_vio.c b/drivers/char/hvc_vio.c
index 27370e9..5e2f52b 100644
--- a/drivers/char/hvc_vio.c
+++ b/drivers/char/hvc_vio.c
@@ -39,7 +39,7 @@
 
 #include "hvc_console.h"
 
-char hvc_driver_name[] = "hvc_console";
+static const char hvc_driver_name[] = "hvc_console";
 
 static struct vio_device_id hvc_driver_table[] __devinitdata = {
 	{"serial", "hvterm1"},
-- 
1.7.3.rc1
