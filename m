Return-Path: <B21989@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B42362C0093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 18:34:10 +1100 (EST)
Received: from mail10-co1 (localhost [127.0.0.1])	by mail10-co1-R.bigfish.com
 (Postfix) with ESMTP id 1A60A6800C1	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 29 Jan 2013 07:34:06 +0000 (UTC)
Received: from CO1EHSMHS028.bigfish.com (unknown [10.243.78.211])	by
 mail10-co1.bigfish.com (Postfix) with ESMTP id 651A94A0048	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 07:34:04 +0000 (UTC)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/p1023/config: enable hugetlbfs support
Date: Tue, 29 Jan 2013 14:34:09 +0800
Message-ID: <1359441249-3040-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hugetlbfs is missed in current p1023rds_defconfig, enable it by default.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 arch/powerpc/configs/85xx/p1023rds_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/85xx/p1023rds_defconfig b/arch/powerpc/configs/85xx/p1023rds_defconfig
index b80bcc6..98125b0 100644
--- a/arch/powerpc/configs/85xx/p1023rds_defconfig
+++ b/arch/powerpc/configs/85xx/p1023rds_defconfig
@@ -1,4 +1,5 @@
 CONFIG_PPC_85xx=y
+CONFIG_PHYS_64BIT=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_EXPERIMENTAL=y
@@ -138,6 +139,7 @@ CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
+CONFIG_HUGETLBFS=y
 CONFIG_ADFS_FS=m
 CONFIG_AFFS_FS=m
 CONFIG_HFS_FS=m
-- 
1.6.4
