Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5518CDE034
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 16:43:17 +1000 (EST)
Date: Fri, 23 May 2008 16:31:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linux-pcmcia@lists.infradead.org
Subject: [PATCH 07/12] pcmcia: use linux/of_{device,platform}.h instead of asm
Message-Id: <20080523163108.2762a15a.sfr@canb.auug.org.au>
In-Reply-To: <20080523161627.a75d5010.sfr@canb.auug.org.au>
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, ppc-dev <linuxppc-dev@ozlabs.org>,
	vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/pcmcia/electra_cf.c  |    2 +-
 drivers/pcmcia/m8xx_pcmcia.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index 0a6cea1..0f5cea8 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -29,9 +29,9 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/vmalloc.h>
+#include <linux/of_platform.h>
 
 #include <pcmcia/ss.h>
-#include <asm/of_platform.h>
 
 static const char driver_name[] = "electra-cf";
 
diff --git a/drivers/pcmcia/m8xx_pcmcia.c b/drivers/pcmcia/m8xx_pcmcia.c
index ac70d2c..9c5be9a 100644
--- a/drivers/pcmcia/m8xx_pcmcia.c
+++ b/drivers/pcmcia/m8xx_pcmcia.c
@@ -49,6 +49,8 @@
 #include <linux/interrupt.h>
 #include <linux/fsl_devices.h>
 #include <linux/bitops.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
@@ -57,8 +59,6 @@
 #include <asm/8xx_immap.h>
 #include <asm/irq.h>
 #include <asm/fs_pd.h>
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
-- 
1.5.5.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
