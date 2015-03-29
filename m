Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 914011A0144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 00:40:25 +1100 (AEDT)
Date: Sun, 29 Mar 2015 15:40:16 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 33/86] edac/pasemi: use uapi/linux/pci_ids.h directly
Message-ID: <1427635734-24786-34-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Borislav Petkov <bp@alien8.de>, Doug Thompson <dougthompson@xmission.com>,
 Olof Johansson <olof@lixom.net>, Egor Martovetsky <egor@pasemi.com>,
 linuxppc-dev@lists.ozlabs.org, linux-edac@vger.kernel.org
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
 drivers/edac/pasemi_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/pasemi_edac.c b/drivers/edac/pasemi_edac.c
index 9c971b5..cd0da08 100644
--- a/drivers/edac/pasemi_edac.c
+++ b/drivers/edac/pasemi_edac.c
@@ -24,7 +24,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include <linux/edac.h>
 #include "edac_core.h"
 
-- 
MST
