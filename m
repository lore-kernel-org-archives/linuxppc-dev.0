Return-Path: <olof@lixom.net>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 10D862C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jan 2014 19:23:21 +1100 (EST)
Received: by mail-pd0-f170.google.com with SMTP id g10so15142817pdj.29
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jan 2014 00:23:18 -0800 (PST)
From: Olof Johansson <olof@lixom.net>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: add SATA_MV to ppc64_defconfig
Date: Fri,  3 Jan 2014 00:24:19 -0800
Message-Id: <1388737459-9547-1-git-send-email-olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes ppc64_defconfig bootable without initrd on pasemi systems,
most of whom have MV SATA controllers. Some have SIL24, but that driver
is already enabled.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/powerpc/configs/ppc64_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 581a3bc..e015896 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -186,6 +186,7 @@ CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_ALUA=m
 CONFIG_ATA=y
 CONFIG_SATA_SIL24=y
+CONFIG_SATA_MV=y
 CONFIG_SATA_SVW=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
-- 
1.7.10.4
