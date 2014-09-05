Return-Path: <cyril.bur@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF6001A011C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 11:16:54 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyril.bur@au1.ibm.com>;
 Fri, 5 Sep 2014 11:16:52 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A40993578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 11:16:51 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s850x2He50790424
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 10:59:02 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s851GpKe014437
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 11:16:51 +1000
From: Cyril Bur <cyril.bur@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Make CONFIG_FHANDLE=y for all 64 bit powerpc defconfigs
Date: Fri,  5 Sep 2014 11:16:43 +1000
Message-Id: <1409879803-18159-1-git-send-email-cyril.bur@au1.ibm.com>
Cc: Cyril Bur <cyril.bur@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_FHANDLE is a requirement for systemd and with the increasing
uptake of systemd within distros it makes sense for 64 bit defconfigs
to include it.

Signed-off-by: Cyril Bur <cyril.bur@au1.ibm.com>
---
 arch/powerpc/configs/cell_defconfig          | 1 +
 arch/powerpc/configs/celleb_defconfig        | 1 +
 arch/powerpc/configs/corenet64_smp_defconfig | 1 +
 arch/powerpc/configs/g5_defconfig            | 1 +
 arch/powerpc/configs/maple_defconfig         | 1 +
 arch/powerpc/configs/pasemi_defconfig        | 1 +
 arch/powerpc/configs/ppc64_defconfig         | 1 +
 arch/powerpc/configs/ppc64e_defconfig        | 1 +
 arch/powerpc/configs/ps3_defconfig           | 1 +
 arch/powerpc/configs/pseries_defconfig       | 1 +
 arch/powerpc/configs/pseries_le_defconfig    | 1 +
 11 files changed, 11 insertions(+)

diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 4bee1a6..45fd06c 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -5,6 +5,7 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=4
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=15
diff --git a/arch/powerpc/configs/celleb_defconfig b/arch/powerpc/configs/celleb_defconfig
index 6d7b22f..77d7bf3 100644
--- a/arch/powerpc/configs/celleb_defconfig
+++ b/arch/powerpc/configs/celleb_defconfig
@@ -5,6 +5,7 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=4
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=15
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 4b07bad..269d6e4 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -4,6 +4,7 @@ CONFIG_ALTIVEC=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=24
 CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 3c72fa6..7594c5a 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -5,6 +5,7 @@ CONFIG_NR_CPUS=4
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_FHANDLE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index 95e545d..c8b6a9d 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -4,6 +4,7 @@ CONFIG_NR_CPUS=4
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_FHANDLE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_COMPAT_BRK is not set
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index cec044a..e5e7838 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -3,6 +3,7 @@ CONFIG_ALTIVEC=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index f26b267..f6c02f8 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -4,6 +4,7 @@ CONFIG_VSX=y
 CONFIG_SMP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_FHANDLE=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index 438e813..587f551 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -3,6 +3,7 @@ CONFIG_PPC_BOOK3E_64=y
 CONFIG_SMP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_TASKSTATS=y
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index fdee37f..2e637c8 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -5,6 +5,7 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_FHANDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_RD_LZMA=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index a905063..50375f1 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -5,6 +5,7 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=2048
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_FHANDLE=y
 CONFIG_AUDIT=y
 CONFIG_AUDITSYSCALL=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/configs/pseries_le_defconfig
index 58e3dbf..4428ee4 100644
--- a/arch/powerpc/configs/pseries_le_defconfig
+++ b/arch/powerpc/configs/pseries_le_defconfig
@@ -6,6 +6,7 @@ CONFIG_NR_CPUS=2048
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_FHANDLE=y
 CONFIG_AUDIT=y
 CONFIG_AUDITSYSCALL=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
-- 
1.9.1
