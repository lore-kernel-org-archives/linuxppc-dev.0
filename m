Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnJ5VtCzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 31/46] powerpc/configs: Drop removed CONFIG_LOGFS
Date: Wed, 23 Aug 2017 15:37:51 +1000
Message-Id: <1503466686-10932-32-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
References: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 1d0fd57a50aa ("logfs: remove from tree"), logfs was removed
from the tree, so we can drop it from our defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/ppc44x_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index 3587527921ec..66dd6bf45cde 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -94,7 +94,6 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_UBIFS_FS=m
-CONFIG_LOGFS=m
 CONFIG_CRAMFS=y
 CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_XATTR=y
-- 
2.7.4
