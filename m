Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Wn6s0RztzF24b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 16:22:45 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	oohall@gmail.com,
	mikey@neuling.org
Subject: [PATCH] powerpc: Add NVDIMM to powernv_defconfig
Date: Thu, 26 Apr 2018 16:22:31 +1000
Message-Id: <20180426062231.19128-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables greater testing NVDIMMs as it becomes more
prevalent. This is also the minimal required to enable persistent
memory in mambo.

This adds 100KB to the kernel text and 170KB to the vmlinux

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/configs/powernv_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 9e92aa6a52..0f94b7dc11 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -238,6 +238,8 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_GENERIC=y
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
+CONFIG_LIBNVDIMM=y
+# CONFIG_ND_BLK is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
2.14.1
