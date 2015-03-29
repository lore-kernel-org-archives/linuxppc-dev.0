Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EDB41A0144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 00:37:51 +1100 (AEDT)
Date: Sun, 29 Mar 2015 15:37:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 04/86] powerpc/pci: use uapi/linux/pci_ids.h directly
Message-ID: <1427635734-24786-5-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
use the new header directly so we can drop
the wrapper in include/linux/pci_ids.h.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/powerpc/platforms/embedded6xx/mpc10x.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/mpc10x.h b/arch/powerpc/platforms/embedded6xx/mpc10x.h
index b290b63..4175800 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc10x.h
+++ b/arch/powerpc/platforms/embedded6xx/mpc10x.h
@@ -13,7 +13,7 @@
 #ifndef __PPC_KERNEL_MPC10X_H
 #define __PPC_KERNEL_MPC10X_H
 
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include <asm/pci-bridge.h>
 
 /*
@@ -35,7 +35,7 @@
 
 /*
  * Define the vendor/device IDs for the various bridges--should be added to
- * <linux/pci_ids.h>
+ * <uapi/linux/pci_ids.h>
  */
 #define	MPC10X_BRIDGE_106	((PCI_DEVICE_ID_MOTOROLA_MPC106 << 16) |  \
 				  PCI_VENDOR_ID_MOTOROLA)
-- 
MST
