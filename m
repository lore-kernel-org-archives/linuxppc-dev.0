Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkDB32DmKzDsQ8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 16:14:35 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u656ESZN106804
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 02:14:32 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23x9mdk449-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jul 2016 02:14:31 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 5 Jul 2016 16:14:27 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 71895357805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 16:14:24 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u656EOgQ8978772
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 16:14:24 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u656EOr4028988
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 16:14:24 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, oss@buserror.net, geoff@infradead.org
Subject: [PATCH 3/3] powerpc/configs: remove old symbols from defconfigs
Date: Tue,  5 Jul 2016 16:12:35 +1000
In-Reply-To: <1467699155-19108-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1467699155-19108-1-git-send-email-andrew.donnellan@au1.ibm.com>
Message-Id: <1467699155-19108-3-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update defconfigs to remove old symbols and comments referencing old
symbols.

Dropped:

* AVERAGE
* INET_LRO
* EXT3_DEFAULTS_TO_ORDERED
* EXT3_FS_XATTR
* I2O
* INFINIBAND_AMSO1100
* INFINIBAND_EHCA
* IP1000

Replaced:

* BLK_DEV_XIP -> BLK_DEV_RAM_DAX
* CLK_PPC_CORENET -> CLK_QORIQ
* EXT2_FS_XIP -> FS_DAX
* EXT3_FS* -> EXT4_FS*

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Please let me know if any of these are problematic - I've built a few
configurations (pseries, powernv, ppc64) but haven't tested all of them.
---
 arch/powerpc/configs/40x/acadia_defconfig         | 1 -
 arch/powerpc/configs/40x/ep405_defconfig          | 1 -
 arch/powerpc/configs/40x/kilauea_defconfig        | 1 -
 arch/powerpc/configs/40x/klondike_defconfig       | 3 ---
 arch/powerpc/configs/40x/makalu_defconfig         | 1 -
 arch/powerpc/configs/40x/obs600_defconfig         | 1 -
 arch/powerpc/configs/40x/virtex_defconfig         | 1 -
 arch/powerpc/configs/40x/walnut_defconfig         | 1 -
 arch/powerpc/configs/44x/akebono_defconfig        | 8 +++-----
 arch/powerpc/configs/44x/arches_defconfig         | 1 -
 arch/powerpc/configs/44x/bamboo_defconfig         | 1 -
 arch/powerpc/configs/44x/bluestone_defconfig      | 2 +-
 arch/powerpc/configs/44x/canyonlands_defconfig    | 1 -
 arch/powerpc/configs/44x/currituck_defconfig      | 8 +++-----
 arch/powerpc/configs/44x/ebony_defconfig          | 1 -
 arch/powerpc/configs/44x/eiger_defconfig          | 2 --
 arch/powerpc/configs/44x/icon_defconfig           | 4 +---
 arch/powerpc/configs/44x/iss476-smp_defconfig     | 8 +++-----
 arch/powerpc/configs/44x/katmai_defconfig         | 1 -
 arch/powerpc/configs/44x/rainier_defconfig        | 1 -
 arch/powerpc/configs/44x/redwood_defconfig        | 2 --
 arch/powerpc/configs/44x/sam440ep_defconfig       | 6 ++----
 arch/powerpc/configs/44x/sequoia_defconfig        | 1 -
 arch/powerpc/configs/44x/taishan_defconfig        | 1 -
 arch/powerpc/configs/44x/virtex5_defconfig        | 1 -
 arch/powerpc/configs/44x/warp_defconfig           | 5 +----
 arch/powerpc/configs/52xx/cm5200_defconfig        | 4 +---
 arch/powerpc/configs/52xx/lite5200b_defconfig     | 4 +---
 arch/powerpc/configs/52xx/motionpro_defconfig     | 4 +---
 arch/powerpc/configs/52xx/pcm030_defconfig        | 4 +---
 arch/powerpc/configs/52xx/tqm5200_defconfig       | 4 +---
 arch/powerpc/configs/83xx/asp8347_defconfig       | 4 +---
 arch/powerpc/configs/83xx/kmeter1_defconfig       | 1 -
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   | 4 +---
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   | 4 +---
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   | 4 +---
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   | 4 +---
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   | 4 +---
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig | 4 +---
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   | 4 +---
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   | 4 +---
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   | 4 +---
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   | 4 +---
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   | 4 +---
 arch/powerpc/configs/83xx/sbc834x_defconfig       | 5 +----
 arch/powerpc/configs/85xx/ge_imp3a_defconfig      | 4 +---
 arch/powerpc/configs/85xx/kmp204x_defconfig       | 3 +--
 arch/powerpc/configs/85xx/ksi8560_defconfig       | 4 +---
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   | 4 +---
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   | 4 +---
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   | 4 +---
 arch/powerpc/configs/85xx/sbc8548_defconfig       | 1 -
 arch/powerpc/configs/85xx/socrates_defconfig      | 4 +---
 arch/powerpc/configs/85xx/stx_gp3_defconfig       | 4 +---
 arch/powerpc/configs/85xx/tqm8540_defconfig       | 4 +---
 arch/powerpc/configs/85xx/tqm8541_defconfig       | 4 +---
 arch/powerpc/configs/85xx/tqm8548_defconfig       | 1 -
 arch/powerpc/configs/85xx/tqm8555_defconfig       | 4 +---
 arch/powerpc/configs/85xx/tqm8560_defconfig       | 4 +---
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   | 4 +---
 arch/powerpc/configs/adder875_defconfig           | 1 -
 arch/powerpc/configs/amigaone_defconfig           | 2 --
 arch/powerpc/configs/c2k_defconfig                | 8 +++-----
 arch/powerpc/configs/cell_defconfig               | 2 +-
 arch/powerpc/configs/chrp32_defconfig             | 1 -
 arch/powerpc/configs/ep8248e_defconfig            | 5 +----
 arch/powerpc/configs/ep88xc_defconfig             | 1 -
 arch/powerpc/configs/fsl-emb-nonhw.config         | 4 +---
 arch/powerpc/configs/g5_defconfig                 | 7 +++----
 arch/powerpc/configs/gamecube_defconfig           | 5 +----
 arch/powerpc/configs/holly_defconfig              | 3 +--
 arch/powerpc/configs/linkstation_defconfig        | 4 +---
 arch/powerpc/configs/maple_defconfig              | 5 +----
 arch/powerpc/configs/mgcoge_defconfig             | 1 -
 arch/powerpc/configs/mpc512x_defconfig            | 8 +++-----
 arch/powerpc/configs/mpc5200_defconfig            | 4 +---
 arch/powerpc/configs/mpc7448_hpc2_defconfig       | 4 +---
 arch/powerpc/configs/mpc8272_ads_defconfig        | 4 +---
 arch/powerpc/configs/mpc83xx_defconfig            | 4 +---
 arch/powerpc/configs/mpc866_ads_defconfig         | 4 +---
 arch/powerpc/configs/mpc885_ads_defconfig         | 1 -
 arch/powerpc/configs/mvme5100_defconfig           | 4 +---
 arch/powerpc/configs/pasemi_defconfig             | 3 +--
 arch/powerpc/configs/pmac32_defconfig             | 5 +----
 arch/powerpc/configs/powernv_defconfig            | 6 +++---
 arch/powerpc/configs/ppc40x_defconfig             | 4 +---
 arch/powerpc/configs/ppc44x_defconfig             | 4 +---
 arch/powerpc/configs/ppc64_defconfig              | 6 +-----
 arch/powerpc/configs/ppc64e_defconfig             | 6 +-----
 arch/powerpc/configs/ppc6xx_defconfig             | 9 ++++-----
 arch/powerpc/configs/pq2fads_defconfig            | 4 +---
 arch/powerpc/configs/ps3_defconfig                | 1 -
 arch/powerpc/configs/pseries_defconfig            | 6 +-----
 arch/powerpc/configs/storcenter_defconfig         | 4 +---
 arch/powerpc/configs/tqm8xx_defconfig             | 1 -
 arch/powerpc/configs/wii_defconfig                | 5 +----
 96 files changed, 84 insertions(+), 253 deletions(-)

diff --git a/arch/powerpc/configs/40x/acadia_defconfig b/arch/powerpc/configs/40x/acadia_defconfig
index 9110a5c..3438ed9 100644
--- a/arch/powerpc/configs/40x/acadia_defconfig
+++ b/arch/powerpc/configs/40x/acadia_defconfig
@@ -21,7 +21,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/40x/ep405_defconfig b/arch/powerpc/configs/40x/ep405_defconfig
index 7903666..36c44c0 100644
--- a/arch/powerpc/configs/40x/ep405_defconfig
+++ b/arch/powerpc/configs/40x/ep405_defconfig
@@ -20,7 +20,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/40x/kilauea_defconfig b/arch/powerpc/configs/40x/kilauea_defconfig
index 01bd71b..ad2156c 100644
--- a/arch/powerpc/configs/40x/kilauea_defconfig
+++ b/arch/powerpc/configs/40x/kilauea_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/40x/klondike_defconfig b/arch/powerpc/configs/40x/klondike_defconfig
index e2036b7..28adb78 100644
--- a/arch/powerpc/configs/40x/klondike_defconfig
+++ b/arch/powerpc/configs/40x/klondike_defconfig
@@ -32,8 +32,6 @@ CONFIG_SCSI_SAS_ATTRS=y
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
@@ -44,7 +42,6 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_AVERAGE=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
diff --git a/arch/powerpc/configs/40x/makalu_defconfig b/arch/powerpc/configs/40x/makalu_defconfig
index efd5170..a00f434 100644
--- a/arch/powerpc/configs/40x/makalu_defconfig
+++ b/arch/powerpc/configs/40x/makalu_defconfig
@@ -20,7 +20,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/40x/obs600_defconfig b/arch/powerpc/configs/40x/obs600_defconfig
index 5ded3dcd..e500e6a 100644
--- a/arch/powerpc/configs/40x/obs600_defconfig
+++ b/arch/powerpc/configs/40x/obs600_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/40x/virtex_defconfig b/arch/powerpc/configs/40x/virtex_defconfig
index bcb0c4d..65dc084 100644
--- a/arch/powerpc/configs/40x/virtex_defconfig
+++ b/arch/powerpc/configs/40x/virtex_defconfig
@@ -27,7 +27,6 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_LRO is not set
 CONFIG_NETFILTER=y
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_FILTER=m
diff --git a/arch/powerpc/configs/40x/walnut_defconfig b/arch/powerpc/configs/40x/walnut_defconfig
index 37c838f..567f99b 100644
--- a/arch/powerpc/configs/40x/walnut_defconfig
+++ b/arch/powerpc/configs/40x/walnut_defconfig
@@ -18,7 +18,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/44x/akebono_defconfig b/arch/powerpc/configs/44x/akebono_defconfig
index ea4ef02a..143b2fb 100644
--- a/arch/powerpc/configs/44x/akebono_defconfig
+++ b/arch/powerpc/configs/44x/akebono_defconfig
@@ -32,7 +32,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
@@ -110,10 +109,9 @@ CONFIG_MMC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_M41T80=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
 CONFIG_VFAT_FS=y
diff --git a/arch/powerpc/configs/44x/arches_defconfig b/arch/powerpc/configs/44x/arches_defconfig
index 9549420..6bba1a5 100644
--- a/arch/powerpc/configs/44x/arches_defconfig
+++ b/arch/powerpc/configs/44x/arches_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/44x/bamboo_defconfig b/arch/powerpc/configs/44x/bamboo_defconfig
index a046f08..477d99f 100644
--- a/arch/powerpc/configs/44x/bamboo_defconfig
+++ b/arch/powerpc/configs/44x/bamboo_defconfig
@@ -21,7 +21,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/44x/bluestone_defconfig b/arch/powerpc/configs/44x/bluestone_defconfig
index a326b77..6b77aea 100644
--- a/arch/powerpc/configs/44x/bluestone_defconfig
+++ b/arch/powerpc/configs/44x/bluestone_defconfig
@@ -49,7 +49,7 @@ CONFIG_SENSORS_AD7414=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_M41T80=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
diff --git a/arch/powerpc/configs/44x/canyonlands_defconfig b/arch/powerpc/configs/44x/canyonlands_defconfig
index d939e71..c8e6f04 100644
--- a/arch/powerpc/configs/44x/canyonlands_defconfig
+++ b/arch/powerpc/configs/44x/canyonlands_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/44x/currituck_defconfig b/arch/powerpc/configs/44x/currituck_defconfig
index 5aa312a..3799a26 100644
--- a/arch/powerpc/configs/44x/currituck_defconfig
+++ b/arch/powerpc/configs/44x/currituck_defconfig
@@ -30,7 +30,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
@@ -71,10 +70,9 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_M41T80=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
diff --git a/arch/powerpc/configs/44x/ebony_defconfig b/arch/powerpc/configs/44x/ebony_defconfig
index 5909e01..c265f54 100644
--- a/arch/powerpc/configs/44x/ebony_defconfig
+++ b/arch/powerpc/configs/44x/ebony_defconfig
@@ -19,7 +19,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/44x/eiger_defconfig b/arch/powerpc/configs/44x/eiger_defconfig
index 57499d2..bb6bd6d 100644
--- a/arch/powerpc/configs/44x/eiger_defconfig
+++ b/arch/powerpc/configs/44x/eiger_defconfig
@@ -24,7 +24,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
@@ -43,7 +42,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_FUSION=y
 CONFIG_FUSION_SAS=y
-CONFIG_I2O=y
 CONFIG_NETDEVICES=y
 CONFIG_IBM_EMAC=y
 CONFIG_IBM_EMAC_RXB=256
diff --git a/arch/powerpc/configs/44x/icon_defconfig b/arch/powerpc/configs/44x/icon_defconfig
index 5d52185..060f2ed 100644
--- a/arch/powerpc/configs/44x/icon_defconfig
+++ b/arch/powerpc/configs/44x/icon_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
@@ -76,8 +75,7 @@ CONFIG_LOGO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/powerpc/configs/44x/iss476-smp_defconfig b/arch/powerpc/configs/44x/iss476-smp_defconfig
index 0ad3e44..115a6b2 100644
--- a/arch/powerpc/configs/44x/iss476-smp_defconfig
+++ b/arch/powerpc/configs/44x/iss476-smp_defconfig
@@ -32,7 +32,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
@@ -56,10 +55,9 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_THERMAL=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
diff --git a/arch/powerpc/configs/44x/katmai_defconfig b/arch/powerpc/configs/44x/katmai_defconfig
index a042335..b999048 100644
--- a/arch/powerpc/configs/44x/katmai_defconfig
+++ b/arch/powerpc/configs/44x/katmai_defconfig
@@ -21,7 +21,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/44x/rainier_defconfig b/arch/powerpc/configs/44x/rainier_defconfig
index 91c2aff..b8c9ee4 100644
--- a/arch/powerpc/configs/44x/rainier_defconfig
+++ b/arch/powerpc/configs/44x/rainier_defconfig
@@ -22,7 +22,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/44x/redwood_defconfig b/arch/powerpc/configs/44x/redwood_defconfig
index 7fddf3f..a4bb0484 100644
--- a/arch/powerpc/configs/44x/redwood_defconfig
+++ b/arch/powerpc/configs/44x/redwood_defconfig
@@ -24,7 +24,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
@@ -41,7 +40,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_FUSION=y
 CONFIG_FUSION_SAS=y
-CONFIG_I2O=y
 CONFIG_NETDEVICES=y
 CONFIG_IBM_EMAC=y
 CONFIG_IBM_EMAC_RXB=256
diff --git a/arch/powerpc/configs/44x/sam440ep_defconfig b/arch/powerpc/configs/44x/sam440ep_defconfig
index 6928012..63302fb 100644
--- a/arch/powerpc/configs/44x/sam440ep_defconfig
+++ b/arch/powerpc/configs/44x/sam440ep_defconfig
@@ -26,7 +26,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
@@ -85,9 +84,8 @@ CONFIG_RTC_DRV_M41T80_WDT=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_REISERFS_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_ISO9660_FS=y
diff --git a/arch/powerpc/configs/44x/sequoia_defconfig b/arch/powerpc/configs/44x/sequoia_defconfig
index c294369..b3792fd 100644
--- a/arch/powerpc/configs/44x/sequoia_defconfig
+++ b/arch/powerpc/configs/44x/sequoia_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/44x/taishan_defconfig b/arch/powerpc/configs/44x/taishan_defconfig
index e779228..ff6f862 100644
--- a/arch/powerpc/configs/44x/taishan_defconfig
+++ b/arch/powerpc/configs/44x/taishan_defconfig
@@ -21,7 +21,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
diff --git a/arch/powerpc/configs/44x/virtex5_defconfig b/arch/powerpc/configs/44x/virtex5_defconfig
index 53d0300..ce05206 100644
--- a/arch/powerpc/configs/44x/virtex5_defconfig
+++ b/arch/powerpc/configs/44x/virtex5_defconfig
@@ -26,7 +26,6 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_LRO is not set
 CONFIG_NETFILTER=y
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_FILTER=m
diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index ee43437..ab93248 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -23,7 +23,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_VLAN_8021Q=y
@@ -73,9 +72,7 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/52xx/cm5200_defconfig b/arch/powerpc/configs/52xx/cm5200_defconfig
index 19fad0e..c1faac8 100644
--- a/arch/powerpc/configs/52xx/cm5200_defconfig
+++ b/arch/powerpc/configs/52xx/cm5200_defconfig
@@ -22,7 +22,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -61,8 +60,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_DMADEVICES=y
 CONFIG_PPC_BESTCOMM=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/52xx/lite5200b_defconfig b/arch/powerpc/configs/52xx/lite5200b_defconfig
index 5f40ba9..9493b02 100644
--- a/arch/powerpc/configs/52xx/lite5200b_defconfig
+++ b/arch/powerpc/configs/52xx/lite5200b_defconfig
@@ -24,7 +24,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -53,8 +52,7 @@ CONFIG_I2C_MPC=y
 CONFIG_DMADEVICES=y
 CONFIG_PPC_BESTCOMM=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/52xx/motionpro_defconfig b/arch/powerpc/configs/52xx/motionpro_defconfig
index 909e185..fe8126b 100644
--- a/arch/powerpc/configs/52xx/motionpro_defconfig
+++ b/arch/powerpc/configs/52xx/motionpro_defconfig
@@ -22,7 +22,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -73,8 +72,7 @@ CONFIG_RTC_DRV_DS1307=y
 CONFIG_DMADEVICES=y
 CONFIG_PPC_BESTCOMM=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/52xx/pcm030_defconfig b/arch/powerpc/configs/52xx/pcm030_defconfig
index 649a01a..1554de6 100644
--- a/arch/powerpc/configs/52xx/pcm030_defconfig
+++ b/arch/powerpc/configs/52xx/pcm030_defconfig
@@ -34,7 +34,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
@@ -74,8 +73,7 @@ CONFIG_RTC_DRV_PCF8563=m
 CONFIG_DMADEVICES=y
 CONFIG_PPC_BESTCOMM=y
 CONFIG_EXT2_FS=m
-CONFIG_EXT3_FS=m
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=m
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=m
 CONFIG_FAT_DEFAULT_CODEPAGE=850
diff --git a/arch/powerpc/configs/52xx/tqm5200_defconfig b/arch/powerpc/configs/52xx/tqm5200_defconfig
index efab838..b8b316b 100644
--- a/arch/powerpc/configs/52xx/tqm5200_defconfig
+++ b/arch/powerpc/configs/52xx/tqm5200_defconfig
@@ -26,7 +26,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -75,8 +74,7 @@ CONFIG_RTC_DRV_DS1374=y
 CONFIG_DMADEVICES=y
 CONFIG_PPC_BESTCOMM=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/83xx/asp8347_defconfig b/arch/powerpc/configs/83xx/asp8347_defconfig
index bcdfb07..b60cac0 100644
--- a/arch/powerpc/configs/83xx/asp8347_defconfig
+++ b/arch/powerpc/configs/83xx/asp8347_defconfig
@@ -26,7 +26,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -63,8 +62,7 @@ CONFIG_USB_EHCI_FSL=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1374=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/powerpc/configs/83xx/kmeter1_defconfig b/arch/powerpc/configs/83xx/kmeter1_defconfig
index 11a9592..9547dcd 100644
--- a/arch/powerpc/configs/83xx/kmeter1_defconfig
+++ b/arch/powerpc/configs/83xx/kmeter1_defconfig
@@ -28,7 +28,6 @@ CONFIG_IP_PNP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_TIPC=y
 CONFIG_BRIDGE=m
diff --git a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
index b47a41f..80aa844 100644
--- a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -79,8 +78,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
index e28c83f..d89d13b 100644
--- a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -77,8 +76,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
index e84d35b..e789518 100644
--- a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
@@ -26,7 +26,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -52,8 +51,7 @@ CONFIG_WATCHDOG=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1374=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
index ae145f4..917a49c 100644
--- a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
@@ -26,7 +26,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -64,8 +63,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
index 87fc15b..00f636e 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
@@ -24,7 +24,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -75,8 +74,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
index 9a2ff25..a539d44 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
@@ -24,7 +24,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -66,8 +65,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
index e44edc5..9f0ddc83 100644
--- a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
@@ -25,7 +25,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -51,8 +50,7 @@ CONFIG_WATCHDOG=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1374=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
index 94a7d85..ceed4c1 100644
--- a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
@@ -25,7 +25,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -57,8 +56,7 @@ CONFIG_WATCHDOG=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1374=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
index 761ed8e..a6819bf 100644
--- a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
@@ -24,7 +24,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
@@ -65,8 +64,7 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
index bcf1b48..4bd1992 100644
--- a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
@@ -22,7 +22,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -50,8 +49,7 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
 CONFIG_WATCHDOG=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
index f0f0ebf..2d4bb63 100644
--- a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
@@ -24,7 +24,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -77,8 +76,7 @@ CONFIG_USB_MON=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_FSL=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/83xx/sbc834x_defconfig b/arch/powerpc/configs/83xx/sbc834x_defconfig
index d2e4d82..b3380db 100644
--- a/arch/powerpc/configs/83xx/sbc834x_defconfig
+++ b/arch/powerpc/configs/83xx/sbc834x_defconfig
@@ -22,7 +22,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -65,9 +64,7 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_FSL=y
 CONFIG_USB_STORAGE=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
index b0939dd..c79283b 100644
--- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
+++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
@@ -165,10 +165,8 @@ CONFIG_FSL_DMA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_FUSE_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
diff --git a/arch/powerpc/configs/85xx/kmp204x_defconfig b/arch/powerpc/configs/85xx/kmp204x_defconfig
index e94d3eb..aaaaa60 100644
--- a/arch/powerpc/configs/85xx/kmp204x_defconfig
+++ b/arch/powerpc/configs/85xx/kmp204x_defconfig
@@ -64,7 +64,6 @@ CONFIG_IP_PIMSM_V2=y
 CONFIG_INET_AH=y
 CONFIG_INET_ESP=y
 CONFIG_INET_IPCOMP=y
-# CONFIG_INET_LRO is not set
 CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_TIPC=y
@@ -189,7 +188,7 @@ CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_UIO=y
 CONFIG_STAGING=y
-CONFIG_CLK_PPC_CORENET=y
+CONFIG_CLK_QORIQ=y
 CONFIG_EXT2_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/85xx/ksi8560_defconfig b/arch/powerpc/configs/85xx/ksi8560_defconfig
index 6f753a7..bd814df 100644
--- a/arch/powerpc/configs/85xx/ksi8560_defconfig
+++ b/arch/powerpc/configs/85xx/ksi8560_defconfig
@@ -21,7 +21,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -49,8 +48,7 @@ CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
 CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/85xx/mpc8540_ads_defconfig b/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
index e38c373..32af10d 100644
--- a/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
@@ -22,7 +22,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -41,8 +40,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/85xx/mpc8560_ads_defconfig b/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
index 48fc8e3..a52b217 100644
--- a/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
@@ -21,7 +21,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -44,8 +43,7 @@ CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
 CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig b/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
index ecb0c3b..002bb48 100644
--- a/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
+++ b/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -46,8 +45,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/85xx/sbc8548_defconfig b/arch/powerpc/configs/85xx/sbc8548_defconfig
index 72b7ccf..97ae023 100644
--- a/arch/powerpc/configs/85xx/sbc8548_defconfig
+++ b/arch/powerpc/configs/85xx/sbc8548_defconfig
@@ -20,7 +20,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
diff --git a/arch/powerpc/configs/85xx/socrates_defconfig b/arch/powerpc/configs/85xx/socrates_defconfig
index 0ad7bd5..13579cb 100644
--- a/arch/powerpc/configs/85xx/socrates_defconfig
+++ b/arch/powerpc/configs/85xx/socrates_defconfig
@@ -22,7 +22,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_CAN=y
 CONFIG_MTD=y
@@ -79,8 +78,7 @@ CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
 CONFIG_USB_STORAGE=y
 CONFIG_RTC_CLASS=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/powerpc/configs/85xx/stx_gp3_defconfig b/arch/powerpc/configs/85xx/stx_gp3_defconfig
index b451905..384926f 100644
--- a/arch/powerpc/configs/85xx/stx_gp3_defconfig
+++ b/arch/powerpc/configs/85xx/stx_gp3_defconfig
@@ -17,7 +17,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_IP_NF_IPTABLES=m
@@ -53,8 +52,7 @@ CONFIG_AGP=m
 CONFIG_DRM=m
 CONFIG_SOUND=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_ISO9660_FS=m
 CONFIG_UDF_FS=m
diff --git a/arch/powerpc/configs/85xx/tqm8540_defconfig b/arch/powerpc/configs/85xx/tqm8540_defconfig
index 4daaf29..908f388 100644
--- a/arch/powerpc/configs/85xx/tqm8540_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8540_defconfig
@@ -20,7 +20,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -50,8 +49,7 @@ CONFIG_I2C_MPC=y
 CONFIG_HWMON_DEBUG_CHIP=y
 CONFIG_SENSORS_LM75=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/powerpc/configs/85xx/tqm8541_defconfig b/arch/powerpc/configs/85xx/tqm8541_defconfig
index bb402b3..f47e576 100644
--- a/arch/powerpc/configs/85xx/tqm8541_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8541_defconfig
@@ -20,7 +20,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -52,8 +51,7 @@ CONFIG_I2C_MPC=y
 CONFIG_HWMON_DEBUG_CHIP=y
 CONFIG_SENSORS_LM75=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/powerpc/configs/85xx/tqm8548_defconfig b/arch/powerpc/configs/85xx/tqm8548_defconfig
index 685d0fb..42f5d0a 100644
--- a/arch/powerpc/configs/85xx/tqm8548_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8548_defconfig
@@ -28,7 +28,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
diff --git a/arch/powerpc/configs/85xx/tqm8555_defconfig b/arch/powerpc/configs/85xx/tqm8555_defconfig
index 02a931d..71552b7 100644
--- a/arch/powerpc/configs/85xx/tqm8555_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8555_defconfig
@@ -20,7 +20,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -52,8 +51,7 @@ CONFIG_I2C_MPC=y
 CONFIG_HWMON_DEBUG_CHIP=y
 CONFIG_SENSORS_LM75=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/powerpc/configs/85xx/tqm8560_defconfig b/arch/powerpc/configs/85xx/tqm8560_defconfig
index 633d5b7..25aac97 100644
--- a/arch/powerpc/configs/85xx/tqm8560_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8560_defconfig
@@ -20,7 +20,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -52,8 +51,7 @@ CONFIG_I2C_MPC=y
 CONFIG_HWMON_DEBUG_CHIP=y
 CONFIG_SENSORS_LM75=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
index 858b539..dbd961d 100644
--- a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
+++ b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
@@ -54,7 +54,6 @@ CONFIG_IP_PIMSM_V2=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 CONFIG_IPV6=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
@@ -124,8 +123,7 @@ CONFIG_RTC_DRV_CMOS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_ZISOFS=y
diff --git a/arch/powerpc/configs/adder875_defconfig b/arch/powerpc/configs/adder875_defconfig
index d89ff40..6a3f825 100644
--- a/arch/powerpc/configs/adder875_defconfig
+++ b/arch/powerpc/configs/adder875_defconfig
@@ -24,7 +24,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
diff --git a/arch/powerpc/configs/amigaone_defconfig b/arch/powerpc/configs/amigaone_defconfig
index 84f1b41..8b83ce8 100644
--- a/arch/powerpc/configs/amigaone_defconfig
+++ b/arch/powerpc/configs/amigaone_defconfig
@@ -29,7 +29,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
@@ -106,7 +105,6 @@ CONFIG_USB_STORAGE=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_MSDOS_FS=m
diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_defconfig
index 340685c..7c9d953 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -306,15 +306,13 @@ CONFIG_INFINIBAND=m
 CONFIG_INFINIBAND_USER_MAD=m
 CONFIG_INFINIBAND_USER_ACCESS=m
 CONFIG_INFINIBAND_MTHCA=m
-CONFIG_INFINIBAND_AMSO1100=m
 CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_IPOIB_CM=y
 CONFIG_INFINIBAND_SRP=m
 CONFIG_DMADEVICES=y
-CONFIG_EXT3_FS=m
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=m
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_QUOTA=y
 CONFIG_QFMT_V2=y
 CONFIG_AUTOFS4_FS=m
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index db328e6..7b6f30d 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -184,7 +184,7 @@ CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_CELL=y
 CONFIG_UIO=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=m
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
index 253a9f2..ac9a50d 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -110,7 +110,6 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_UHCI_HCD=y
 CONFIG_USB_STORAGE=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_MSDOS_FS=m
diff --git a/arch/powerpc/configs/ep8248e_defconfig b/arch/powerpc/configs/ep8248e_defconfig
index 7c13704..3403b85 100644
--- a/arch/powerpc/configs/ep8248e_defconfig
+++ b/arch/powerpc/configs/ep8248e_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 CONFIG_NETFILTER=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -50,9 +49,7 @@ CONFIG_SERIAL_CPM_CONSOLE=y
 # CONFIG_HWMON is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/powerpc/configs/ep88xc_defconfig b/arch/powerpc/configs/ep88xc_defconfig
index ee96be8..95411ae 100644
--- a/arch/powerpc/configs/ep88xc_defconfig
+++ b/arch/powerpc/configs/ep88xc_defconfig
@@ -26,7 +26,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/configs/fsl-emb-nonhw.config
index 41e4d35..1a61e81 100644
--- a/arch/powerpc/configs/fsl-emb-nonhw.config
+++ b/arch/powerpc/configs/fsl-emb-nonhw.config
@@ -33,8 +33,7 @@ CONFIG_DUMMY=y
 CONFIG_EFS_FS=m
 CONFIG_EXPERT=y
 CONFIG_EXT2_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_FB=y
 CONFIG_FHANDLE=y
 CONFIG_FIXED_PHY=y
@@ -55,7 +54,6 @@ CONFIG_IKCONFIG=y
 CONFIG_INET_AH=y
 CONFIG_INET_ESP=y
 CONFIG_INET_IPCOMP=y
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET=y
 CONFIG_IP_ADVANCED_ROUTER=y
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 1d9ad85..3b2511c 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -216,14 +216,13 @@ CONFIG_USB_SERIAL_CYBERJACK=m
 CONFIG_USB_SERIAL_XIRCOM=m
 CONFIG_USB_SERIAL_OMNINET=m
 CONFIG_USB_APPLEDISPLAY=m
+CONFIG_FS_DAX=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_REISERFS_FS=y
 CONFIG_REISERFS_FS_XATTR=y
diff --git a/arch/powerpc/configs/gamecube_defconfig b/arch/powerpc/configs/gamecube_defconfig
index 6c6c60f..c0eec4a 100644
--- a/arch/powerpc/configs/gamecube_defconfig
+++ b/arch/powerpc/configs/gamecube_defconfig
@@ -32,7 +32,6 @@ CONFIG_IP_PNP_RARP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
@@ -76,9 +75,7 @@ CONFIG_SND_SEQUENCER_OSS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_GENERIC=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_MSDOS_FS=y
diff --git a/arch/powerpc/configs/holly_defconfig b/arch/powerpc/configs/holly_defconfig
index 5e0f255..e56e800 100644
--- a/arch/powerpc/configs/holly_defconfig
+++ b/arch/powerpc/configs/holly_defconfig
@@ -25,7 +25,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -52,7 +51,7 @@ CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index 62ae929..b413c19 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
@@ -109,8 +108,7 @@ CONFIG_USB_SERIAL_FTDI_SIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_XFS_FS=m
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index ac9666f..27abfab 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -35,7 +35,6 @@ CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_RAM=y
@@ -102,9 +101,7 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
 CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 CONFIG_USB_SERIAL_TI=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XIP=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_FS_DAX=y
 CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/mgcoge_defconfig
index 666922c..197acaa 100644
--- a/arch/powerpc/configs/mgcoge_defconfig
+++ b/arch/powerpc/configs/mgcoge_defconfig
@@ -27,7 +27,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_TIPC=y
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index d16d6c5..0b4854c 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -27,7 +27,6 @@ CONFIG_IP_PNP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CAN=y
@@ -53,7 +52,7 @@ CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_BLK_DEV_XIP=y
+CONFIG_BLK_DEV_RAM_DAX=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
 CONFIG_SCSI=y
@@ -113,10 +112,9 @@ CONFIG_RTC_DRV_MPC5121=y
 CONFIG_DMADEVICES=y
 CONFIG_MPC512X_DMA=y
 CONFIG_MPC512x_LPBFIFO=y
+CONFIG_FS_DAX=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XIP=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index 9fd041b..88336d0 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -26,7 +26,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
@@ -114,8 +113,7 @@ CONFIG_RTC_DRV_PCF8563=m
 CONFIG_DMADEVICES=y
 CONFIG_PPC_BESTCOMM=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/mpc7448_hpc2_defconfig b/arch/powerpc/configs/mpc7448_hpc2_defconfig
index e2647d5..d933326 100644
--- a/arch/powerpc/configs/mpc7448_hpc2_defconfig
+++ b/arch/powerpc/configs/mpc7448_hpc2_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -49,8 +48,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/mpc8272_ads_defconfig b/arch/powerpc/configs/mpc8272_ads_defconfig
index 825b052..4cb0f61 100644
--- a/arch/powerpc/configs/mpc8272_ads_defconfig
+++ b/arch/powerpc/configs/mpc8272_ads_defconfig
@@ -22,7 +22,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 CONFIG_NETFILTER=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -56,8 +55,7 @@ CONFIG_SERIAL_CPM_CONSOLE=y
 # CONFIG_HWMON is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 671e220..6574477 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -37,7 +37,6 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
 CONFIG_INET_ESP=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
@@ -101,8 +100,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_DS1374=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/mpc866_ads_defconfig b/arch/powerpc/configs/mpc866_ads_defconfig
index 321412c..9984544 100644
--- a/arch/powerpc/configs/mpc866_ads_defconfig
+++ b/arch/powerpc/configs/mpc866_ads_defconfig
@@ -24,7 +24,6 @@ CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_NETDEVICES=y
@@ -37,8 +36,7 @@ CONFIG_SERIAL_CPM_CONSOLE=y
 CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
index 2a10f98..91f53f1 100644
--- a/arch/powerpc/configs/mpc885_ads_defconfig
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -25,7 +25,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
diff --git a/arch/powerpc/configs/mvme5100_defconfig b/arch/powerpc/configs/mvme5100_defconfig
index 525a2cb..139add9 100644
--- a/arch/powerpc/configs/mvme5100_defconfig
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -32,7 +32,6 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
@@ -92,8 +91,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=m
-CONFIG_EXT3_FS=m
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=m
 CONFIG_XFS_FS=m
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 8f94782..76f4edd 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -152,8 +152,7 @@ CONFIG_RTC_DRV_DS1307=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=y
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index ea8705f..88d5b49 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -40,7 +40,6 @@ CONFIG_INET_AH=y
 CONFIG_INET_ESP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
@@ -281,10 +280,8 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 CONFIG_USB_APPLEDISPLAY=m
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_ISO9660_FS=y
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 0450310..83bedf4 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -233,9 +233,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_REISERFS_FS=y
 CONFIG_REISERFS_FS_XATTR=y
 CONFIG_REISERFS_FS_POSIX_ACL=y
diff --git a/arch/powerpc/configs/ppc40x_defconfig b/arch/powerpc/configs/ppc40x_defconfig
index a43bf6e..370c0bb 100644
--- a/arch/powerpc/configs/ppc40x_defconfig
+++ b/arch/powerpc/configs/ppc40x_defconfig
@@ -25,7 +25,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
 CONFIG_MTD=y
@@ -67,8 +66,7 @@ CONFIG_THERMAL=y
 CONFIG_FB=m
 CONFIG_FB_XILINX=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=m
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index bbc7f76..2766e8f 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -35,7 +35,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 CONFIG_BRIDGE=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
@@ -89,8 +88,7 @@ CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
 # CONFIG_USB_OHCI_HCD_PCI is not set
 CONFIG_USB_STORAGE=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=m
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index b041fb6..0a8d250 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -247,7 +247,6 @@ CONFIG_INFINIBAND=m
 CONFIG_INFINIBAND_USER_MAD=m
 CONFIG_INFINIBAND_USER_ACCESS=m
 CONFIG_INFINIBAND_MTHCA=m
-CONFIG_INFINIBAND_EHCA=m
 CONFIG_INFINIBAND_CXGB3=m
 CONFIG_INFINIBAND_CXGB4=m
 CONFIG_MLX4_INFINIBAND=m
@@ -262,14 +261,11 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
+CONFIG_FS_DAX=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index ddf9773..fd2edd6 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -178,15 +178,11 @@ CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
+CONFIG_FS_DAX=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 99ccbeba..db1bde3 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -512,7 +512,6 @@ CONFIG_E1000E=m
 CONFIG_IGB=m
 CONFIG_IXGB=m
 CONFIG_IXGBE=m
-CONFIG_IP1000=m
 CONFIG_MV643XX_ETH=m
 CONFIG_SKGE=m
 CONFIG_SKY2=m
@@ -1029,14 +1028,14 @@ CONFIG_UIO_CIF=m
 CONFIG_UIO_PDRV_GENIRQ=m
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
+CONFIG_FS_DAX=y
 CONFIG_EXT2_FS=m
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
-CONFIG_EXT3_FS=m
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=m
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_JBD2_DEBUG=y
 CONFIG_REISERFS_FS=m
diff --git a/arch/powerpc/configs/pq2fads_defconfig b/arch/powerpc/configs/pq2fads_defconfig
index 3e336ee..5432c7a 100644
--- a/arch/powerpc/configs/pq2fads_defconfig
+++ b/arch/powerpc/configs/pq2fads_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 CONFIG_NETFILTER=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
@@ -59,8 +58,7 @@ CONFIG_SERIAL_CPM_CONSOLE=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ETH=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index c400460..ee0ec5a 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -51,7 +51,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 36871a4..99dec9d 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -223,7 +223,6 @@ CONFIG_INFINIBAND=m
 CONFIG_INFINIBAND_USER_MAD=m
 CONFIG_INFINIBAND_USER_ACCESS=m
 CONFIG_INFINIBAND_MTHCA=m
-CONFIG_INFINIBAND_EHCA=m
 CONFIG_INFINIBAND_CXGB3=m
 CONFIG_INFINIBAND_CXGB4=m
 CONFIG_MLX4_INFINIBAND=m
@@ -233,14 +232,11 @@ CONFIG_INFINIBAND_SRP=m
 CONFIG_INFINIBAND_ISER=m
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
+CONFIG_FS_DAX=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
diff --git a/arch/powerpc/configs/storcenter_defconfig b/arch/powerpc/configs/storcenter_defconfig
index b5db7df..e9122b1 100644
--- a/arch/powerpc/configs/storcenter_defconfig
+++ b/arch/powerpc/configs/storcenter_defconfig
@@ -25,7 +25,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
@@ -72,8 +71,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
 CONFIG_XFS_FS=m
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/powerpc/configs/tqm8xx_defconfig b/arch/powerpc/configs/tqm8xx_defconfig
index 4c973c5..78fddf2 100644
--- a/arch/powerpc/configs/tqm8xx_defconfig
+++ b/arch/powerpc/configs/tqm8xx_defconfig
@@ -29,7 +29,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 34eaf52..dcdd51b 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -32,7 +32,6 @@ CONFIG_IP_PNP_RARP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_BT=y
@@ -96,9 +95,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_GENERIC=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
 CONFIG_FUSE_FS=m
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
