Return-Path: <jesper.juhl@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 05DAEDDEB9
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Jul 2007 01:03:44 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k40so796642ugc
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jul 2007 08:03:44 -0700 (PDT)
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][12/37] Clean up duplicate includes in drivers/net/
Date: Sat, 21 Jul 2007 17:02:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707211702.46375.jesper.juhl@gmail.com>
Cc: info@netxen.com, Patrick McHardy <kaber@coreworks.de>,
	Judy Fischbach <jfisch@cs.pdx.edu>, Luke Yang <luke.yang@analog.com>,
	bonding-devel@lists.sourceforge.net,
	Bryan Wu <bryan.wu@analog.com>, kong.lai@tundra.com,
	Jay Vosburgh <fubar@us.ibm.com>,
	James Morris <jmorris@namei.org>, linuxppc-embedded@ozlabs.org,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Alex V Lasso <a_villacis@palosanto.com>,
	Ulrich Kunitz <kune@deine-taler.de>,
	Chad Tindel <ctindel@users.sourceforge.net>,
	Amit S Kale <amitkale@netxen.com>, Jay Cliburn <jcliburn@gmail.com>,
	Samuel Ortiz <samuel@sortiz.org>, Brian Pugh <bpugh@cs.pdx.edu>,
	Daniel Drake <dsd@gentoo.org>, Chris Snook <csnook@redhat.com>,
	alexandre.bounine@tundra.com,
	Pantelis Antoniou <panto@intracom.gr>, netdev@vger.kernel.org,
	Jesper Juhl <jesper.juhl@gmail.com>, linux-wireless@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, Vitaly Bordug <vbordug@ru.mvista.com>,
	Lukasz Stelmach <stlman@poczta.fm>, Ron Mercer <linux-driver@qlogic.com>,
	atl1-devel@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	James P Ketrenos <ipw2100-admin@linux.intel.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

This patch cleans up duplicate includes in
	 drivers/net/


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/drivers/net/atl1/atl1_main.c b/drivers/net/atl1/atl1_main.c
index fd1e156..4a18b88 100644
--- a/drivers/net/atl1/atl1_main.c
+++ b/drivers/net/atl1/atl1_main.c
@@ -75,7 +75,6 @@
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/mii.h>
-#include <linux/interrupt.h>
 #include <net/checksum.h>
 
 #include <asm/atomic.h>
diff --git a/drivers/net/bfin_mac.c b/drivers/net/bfin_mac.c
index 9a08d65..01281ee 100644
--- a/drivers/net/bfin_mac.c
+++ b/drivers/net/bfin_mac.c
@@ -47,15 +47,10 @@
 #include <linux/spinlock.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
-
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
-
 #include <linux/platform_device.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
 
 #include <asm/dma.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 60cccf2..9afd172 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -31,7 +31,6 @@
 #include <linux/inetdevice.h>
 #include <linux/in.h>
 #include <linux/sysfs.h>
-#include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/inet.h>
 #include <linux/rtnetlink.h>
diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index a4a2a0e..27de3d8 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -39,8 +39,6 @@
 
 #include <linux/vmalloc.h>
 #include <asm/pgtable.h>
-
-#include <asm/pgtable.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index d8e779c..43c8668 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -45,7 +45,6 @@
 #include <linux/crc32.h>
 #include <linux/workqueue.h>
 #include <linux/ethtool.h>
-#include <linux/netdevice.h>
 #include <linux/fsl_devices.h>
 #include "gianfar_mii.h"
 
diff --git a/drivers/net/gianfar_ethtool.c b/drivers/net/gianfar_ethtool.c
index 7b411c1..2470903 100644
--- a/drivers/net/gianfar_ethtool.c
+++ b/drivers/net/gianfar_ethtool.c
@@ -34,7 +34,6 @@
 #include <linux/module.h>
 #include <linux/crc32.h>
 #include <asm/types.h>
-#include <asm/uaccess.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
diff --git a/drivers/net/irda/kingsun-sir.c b/drivers/net/irda/kingsun-sir.c
index bdd5c97..4c0d379 100644
--- a/drivers/net/irda/kingsun-sir.c
+++ b/drivers/net/irda/kingsun-sir.c
@@ -66,7 +66,6 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/module.h>
 #include <linux/kref.h>
 #include <linux/usb.h>
 #include <linux/device.h>
diff --git a/drivers/net/irda/mcs7780.c b/drivers/net/irda/mcs7780.c
index 0de8672..bfc5752 100644
--- a/drivers/net/irda/mcs7780.c
+++ b/drivers/net/irda/mcs7780.c
@@ -50,7 +50,6 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/module.h>
 #include <linux/kref.h>
 #include <linux/usb.h>
 #include <linux/device.h>
diff --git a/drivers/net/mipsnet.c b/drivers/net/mipsnet.c
index 9853c74..c0f5ad3 100644
--- a/drivers/net/mipsnet.c
+++ b/drivers/net/mipsnet.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/netdevice.h>
 #include <linux/platform_device.h>
 #include <asm/io.h>
 #include <asm/mips-boards/simint.h>
diff --git a/drivers/net/netxen/netxen_nic_main.c b/drivers/net/netxen/netxen_nic_main.c
index b703ccf..6ba8e07 100644
--- a/drivers/net/netxen/netxen_nic_main.c
+++ b/drivers/net/netxen/netxen_nic_main.c
@@ -39,7 +39,6 @@
 #include "netxen_nic_phan_reg.h"
 
 #include <linux/dma-mapping.h>
-#include <linux/vmalloc.h>
 #include <net/ip.h>
 
 MODULE_DESCRIPTION("NetXen Multi port (1/10) Gigabit Network Driver");
diff --git a/drivers/net/qla3xxx.c b/drivers/net/qla3xxx.c
index 8be8be4..c2fc2f7 100755
--- a/drivers/net/qla3xxx.c
+++ b/drivers/net/qla3xxx.c
@@ -31,7 +31,6 @@
 #include <linux/skbuff.h>
 #include <linux/rtnetlink.h>
 #include <linux/if_vlan.h>
-#include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
 
diff --git a/drivers/net/tsi108_eth.c b/drivers/net/tsi108_eth.c
index 1aabc91..a059f3d 100644
--- a/drivers/net/tsi108_eth.c
+++ b/drivers/net/tsi108_eth.c
@@ -47,7 +47,6 @@
 #include <linux/rtnetlink.h>
 #include <linux/timer.h>
 #include <linux/platform_device.h>
-#include <linux/etherdevice.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
diff --git a/drivers/net/wireless/ipw2200.h b/drivers/net/wireless/ipw2200.h
index 626a240..9c973b9 100644
--- a/drivers/net/wireless/ipw2200.h
+++ b/drivers/net/wireless/ipw2200.h
@@ -45,7 +45,6 @@
 
 #include <linux/firmware.h>
 #include <linux/wireless.h>
-#include <linux/dma-mapping.h>
 #include <linux/jiffies.h>
 #include <asm/io.h>
 
diff --git a/drivers/net/wireless/zd1211rw/zd_def.h b/drivers/net/wireless/zd1211rw/zd_def.h
index deb99d1..505b4d7 100644
--- a/drivers/net/wireless/zd1211rw/zd_def.h
+++ b/drivers/net/wireless/zd1211rw/zd_def.h
@@ -21,7 +21,6 @@
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
 
 typedef u16 __nocast zd_addr_t;
 
