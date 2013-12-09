Return-Path: <olof@lixom.net>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E19DB2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 10:39:35 +1100 (EST)
Received: by mail-pb0-f50.google.com with SMTP id rr13so6422519pbb.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Dec 2013 15:39:33 -0800 (PST)
From: Olof Johansson <olof@lixom.net>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/pasemi: turn on devtmpfs in defconfig
Date: Mon,  9 Dec 2013 15:40:20 -0800
Message-Id: <1386632420-27580-1-git-send-email-olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At least some distros expect it these days; turn it on. Also, random
churn from doing a savedefconfig for the first time in a year or so.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/powerpc/configs/pasemi_defconfig |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index bd8a6f7..cec044a 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -2,7 +2,6 @@ CONFIG_PPC64=y
 CONFIG_ALTIVEC=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -45,8 +44,9 @@ CONFIG_INET_AH=y
 CONFIG_INET_ESP=y
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_SLRAM=y
 CONFIG_MTD_PHRAM=y
@@ -88,7 +88,6 @@ CONFIG_BLK_DEV_DM=y
 CONFIG_DM_CRYPT=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
-CONFIG_MII=y
 CONFIG_TIGON3=y
 CONFIG_E1000=y
 CONFIG_PASEMI_MAC=y
@@ -174,8 +173,8 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_CRC_CCITT=y
 CONFIG_PRINTK_TIME=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
-- 
1.7.10.4
