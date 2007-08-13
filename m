Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 6B99DDDEDE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 16:33:53 +1000 (EST)
Date: Sun, 12 Aug 2007 23:27:36 -0700
From: joe@perches.com
To: vbordug@ru.mvista.com, torvalds@linux-foundation.org,
	pantelis.antoniou@gmail.com, netdev@vger.kernel.org,
	linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH] [193/2many] MAINTAINERS - FREESCALE SOC FS_ENET DRIVER
Message-ID: <46bff9d8.wK4SjlojmM1YMQd3%joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index e06f478..2ef0ec4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1859,6 +1859,8 @@ M:	vbordug@ru.mvista.com
 L:	linuxppc-embedded@ozlabs.org
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	drivers/net/fs_enet/
+F:	include/linus/fs_enet_pd.h
 
 FREESCALE HIGHSPEED USB DEVICE DRIVER
 P:	Li Yang
