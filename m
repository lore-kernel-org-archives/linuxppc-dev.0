Return-Path: <tony@bakeyournoodle.com>
Received: from thor.bakeyournoodle.com (ibmaus65.lnk.telstra.net
 [165.228.126.9])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPSA id 3FD021007D6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 10:42:48 +1100 (EST)
Date: Wed, 23 Nov 2011 10:42:45 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20111122234245.GA28234@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 1a44c074e3ce572cbf60d31ac704e6ce42be4708 Mon Sep 17 00:00:00 2001
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 23 Nov 2011 10:16:40 +1100
Subject: [PATCH] powerpc: 44x: Add mtd ndfc to the ppx44x defconfig

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/configs/ppc44x_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index 6cdf1c0..3b98d73 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -52,6 +52,8 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_NAND=m
+CONFIG_MTD_NAND_NDFC=m
 CONFIG_MTD_UBI=m
 CONFIG_MTD_UBI_GLUEBI=m
 CONFIG_PROC_DEVICETREE=y
-- 
1.7.6.4
