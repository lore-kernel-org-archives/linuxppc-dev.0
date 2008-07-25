Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 256D4DE4BB
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 09:06:24 +1000 (EST)
Date: Fri, 25 Jul 2008 18:06:17 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix vio build warnings
Message-ID: <20080725230617.GL9594@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/kernel/vio.c:1034: warning: function declaration isn’t a prototype
arch/powerpc/kernel/vio.c:1035: warning: function declaration isn’t a prototype

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/vio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index ade8aea..6952384 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1031,8 +1031,8 @@ void vio_cmo_set_dev_desired(struct vio_dev *viodev, size_t desired) {}
 static int vio_cmo_bus_probe(struct vio_dev *viodev) { return 0; }
 static void vio_cmo_bus_remove(struct vio_dev *viodev) {}
 static void vio_cmo_set_dma_ops(struct vio_dev *viodev) {}
-static void vio_cmo_bus_init() {}
-static void vio_cmo_sysfs_init() { }
+static void vio_cmo_bus_init(void) {}
+static void vio_cmo_sysfs_init(void) { }
 #endif /* CONFIG_PPC_SMLPAR */
 EXPORT_SYMBOL(vio_cmo_entitlement_update);
 EXPORT_SYMBOL(vio_cmo_set_dev_desired);
-- 
1.5.6.2
