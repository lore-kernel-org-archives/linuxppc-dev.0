Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 86EC9B7113
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 05:10:33 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] arch/powerpc/kvm/e500: Additional module.h => export.h fixup
Date: Wed, 21 Dec 2011 13:09:34 -0500
Message-Id: <1324490974-12129-1-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This file, like many others, needs to include <linux/export.h>.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/kvm/e500.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index 26d2090..387c383 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/kvm_host.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 
-- 
1.7.7.3
