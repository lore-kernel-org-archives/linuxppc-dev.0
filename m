Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 3/3] proc_devtree: include linux/of.h
Message-Id: <1261532718.576015.537671965190.3.gpush@pororo>
In-Reply-To: <1261532718.575048.365032094903.0.gpush@pororo>
To: Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs.org
From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Wed, 23 Dec 2009 09:45:18 +0800
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currenly, proc_devtree.c depends on asm/prom.h to include linux/of.h, to
provide some device-tree definitions (eg, struct property).

Instead, include linux/of.h directly. We still need asm/prom.h for
HAVE_ARCH_DEVTREE_FIXUPS.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 fs/proc/proc_devtree.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
index 31fc7e0..2ea10dd 100644
--- a/fs/proc/proc_devtree.c
+++ b/fs/proc/proc_devtree.c
@@ -9,6 +9,7 @@
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/string.h>
+#include <linux/of.h>
 #include <asm/prom.h>
 #include <asm/uaccess.h>
 #include "internal.h"
