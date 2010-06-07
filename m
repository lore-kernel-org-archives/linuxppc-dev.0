Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id 0BA5D1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Jun 2010 13:46:05 +1000 (EST)
Received: by gwj15 with SMTP id 15so2032535gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 06 Jun 2010 20:46:03 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100506033041.GA12203@kryten>
References: <20100506033041.GA12203@kryten>
Date: Sun, 6 Jun 2010 21:46:03 -0600
Message-ID: <AANLkTinbdf8gXPR1w96US0wX4pAm9lRQ4qqysYO2JPTa@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Disable CONFIG_SYSFS_DEPRECATED
From: Grant Likely <grant.likely@secretlab.ca>
To: Anton Blanchard <anton@samba.org>
Content-Type: multipart/alternative; boundary=000e0cd2c5d210280a04886883b8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd2c5d210280a04886883b8
Content-Type: text/plain; charset=ISO-8859-1

Acked-by: Grant Likely <grant.likely@secretlab.ca>

On 5 May 2010 21:33, "Anton Blanchard" <anton@samba.org> wrote:


CONFIG_SYSFS_DEPRECATED can cause issues with newer distros and should not
be required for any distro in the last 3 or 4 years, so disable it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/configs/40x/acadia_defconfig
b/arch/powerpc/configs/40x/acadia_defconfig
index 8e95f8d..4aa17b6 100644
--- a/arch/powerpc/configs/40x/acadia_defconfig
+++ b/arch/powerpc/configs/40x/acadia_defconfig
@@ -98,8 +98,7 @@ CONFIG_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/40x/ep405_defconfig
b/arch/powerpc/configs/40x/ep405_defconfig
index 918f23f..9a5f1ab 100644
--- a/arch/powerpc/configs/40x/ep405_defconfig
+++ b/arch/powerpc/configs/40x/ep405_defconfig
@@ -98,8 +98,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/40x/hcu4_defconfig
b/arch/powerpc/configs/40x/hcu4_defconfig
index f87ef03..0b45213 100644
--- a/arch/powerpc/configs/40x/hcu4_defconfig
+++ b/arch/powerpc/configs/40x/hcu4_defconfig
@@ -98,8 +98,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/40x/kilauea_defconfig
b/arch/powerpc/configs/40x/kilauea_defconfig
index 19fbcb0..4d2de0b 100644
--- a/arch/powerpc/configs/40x/kilauea_defconfig
+++ b/arch/powerpc/configs/40x/kilauea_defconfig
@@ -98,8 +98,7 @@ CONFIG_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/40x/makalu_defconfig
b/arch/powerpc/configs/40x/makalu_defconfig
index eb41cd6..a1f3f50 100644
--- a/arch/powerpc/configs/40x/makalu_defconfig
+++ b/arch/powerpc/configs/40x/makalu_defconfig
@@ -98,8 +98,7 @@ CONFIG_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/40x/virtex_defconfig
b/arch/powerpc/configs/40x/virtex_defconfig
index 416e79a..c763135 100644
--- a/arch/powerpc/configs/40x/virtex_defconfig
+++ b/arch/powerpc/configs/40x/virtex_defconfig
@@ -77,8 +77,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/40x/walnut_defconfig
b/arch/powerpc/configs/40x/walnut_defconfig
index bfff0ea..6597b2f 100644
--- a/arch/powerpc/configs/40x/walnut_defconfig
+++ b/arch/powerpc/configs/40x/walnut_defconfig
@@ -98,8 +98,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/44x/arches_defconfig
b/arch/powerpc/configs/44x/arches_defconfig
index 1f6d049..2d3dfb5 100644
--- a/arch/powerpc/configs/44x/arches_defconfig
+++ b/arch/powerpc/configs/44x/arches_defconfig
@@ -98,8 +98,7 @@ CONFIG_RCU_FANOUT=32
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/44x/bamboo_defconfig
b/arch/powerpc/configs/44x/bamboo_defconfig
index 788faac..51a00c4 100644
--- a/arch/powerpc/configs/44x/bamboo_defconfig
+++ b/arch/powerpc/configs/44x/bamboo_defconfig
@@ -102,8 +102,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/44x/canyonlands_defconfig
b/arch/powerpc/configs/44x/canyonlands_defconfig
index 4ef8bca..1028b1b 100644
--- a/arch/powerpc/configs/44x/canyonlands_defconfig
+++ b/arch/powerpc/configs/44x/canyonlands_defconfig
@@ -98,8 +98,7 @@ CONFIG_RCU_FANOUT=32
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/44x/ebony_defconfig
b/arch/powerpc/configs/44x/ebony_defconfig
index ca17b14..69f5633 100644
--- a/arch/powerpc/configs/44x/ebony_defconfig
+++ b/arch/powerpc/configs/44x/ebony_defconfig
@@ -101,8 +101,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/44x/eiger_defconfig
b/arch/powerpc/configs/44x/eiger_defconfig
index e3149ba..dcd859c 100644
--- a/arch/powerpc/configs/44x/eiger_defconfig
+++ b/arch/powerpc/configs/44x/eiger_defconfig
@@ -98,8 +98,7 @@ CONFIG_RCU_FANOUT=32
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/44x/katmai_defconfig
b/arch/powerpc/configs/44x/katmai_defconfig
index af244e1..a2c24d1 100644
--- a/arch/powerpc/configs/44x/katmai_defconfig
+++ b/arch/powerpc/configs/44x/katmai_defconfig
@@ -97,8 +97,7 @@ CONFIG_RCU_FANOUT=32
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/44x/rainier_defconfig
b/arch/powerpc/configs/44x/rainier_defconfig
index 8fed3b2..3bb55b5 100644
--- a/arch/powerpc/configs/44x/rainier_defconfig
+++ b/arch/powerpc/configs/44x/rainier_defconfig
@@ -101,8 +101,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/44x/redwood_defconfig
b/arch/powerpc/configs/44x/redwood_defconfig
index a67ec91..684f40d 100644
--- a/arch/powerpc/configs/44x/redwood_defconfig
+++ b/arch/powerpc/configs/44x/redwood_defconfig
@@ -98,8 +98,7 @@ CONFIG_RCU_FANOUT=32
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/44x/sam440ep_defconfig
b/arch/powerpc/configs/44x/sam440ep_defconfig
index 886cb6a..e202924 100644
--- a/arch/powerpc/configs/44x/sam440ep_defconfig
+++ b/arch/powerpc/configs/44x/sam440ep_defconfig
@@ -103,8 +103,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/44x/sequoia_defconfig
b/arch/powerpc/configs/44x/sequoia_defconfig
index 1b2f41d..c348a46 100644
--- a/arch/powerpc/configs/44x/sequoia_defconfig
+++ b/arch/powerpc/configs/44x/sequoia_defconfig
@@ -102,8 +102,7 @@ CONFIG_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/44x/taishan_defconfig
b/arch/powerpc/configs/44x/taishan_defconfig
index 12041d3..f4cb7e8 100644
--- a/arch/powerpc/configs/44x/taishan_defconfig
+++ b/arch/powerpc/configs/44x/taishan_defconfig
@@ -101,8 +101,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/44x/virtex5_defconfig
b/arch/powerpc/configs/44x/virtex5_defconfig
index 2518b85..c7ead0e 100644
--- a/arch/powerpc/configs/44x/virtex5_defconfig
+++ b/arch/powerpc/configs/44x/virtex5_defconfig
@@ -80,8 +80,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/52xx/cm5200_defconfig
b/arch/powerpc/configs/52xx/cm5200_defconfig
index 218d49b..7664c83 100644
--- a/arch/powerpc/configs/52xx/cm5200_defconfig
+++ b/arch/powerpc/configs/52xx/cm5200_defconfig
@@ -95,8 +95,7 @@ CONFIG_RCU_FANOUT=32
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/52xx/lite5200b_defconfig
b/arch/powerpc/configs/52xx/lite5200b_defconfig
index 90492ff..eac7c17 100644
--- a/arch/powerpc/configs/52xx/lite5200b_defconfig
+++ b/arch/powerpc/configs/52xx/lite5200b_defconfig
@@ -96,8 +96,7 @@ CONFIG_RCU_FANOUT=32
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/52xx/motionpro_defconfig
b/arch/powerpc/configs/52xx/motionpro_defconfig
index dffc8ca..27afb6e 100644
--- a/arch/powerpc/configs/52xx/motionpro_defconfig
+++ b/arch/powerpc/configs/52xx/motionpro_defconfig
@@ -95,8 +95,7 @@ CONFIG_RCU_FANOUT=32
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/52xx/pcm030_defconfig
b/arch/powerpc/configs/52xx/pcm030_defconfig
index 3cb2a52..5fe39dd 100644
--- a/arch/powerpc/configs/52xx/pcm030_defconfig
+++ b/arch/powerpc/configs/52xx/pcm030_defconfig
@@ -98,8 +98,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 # CONFIG_BLK_DEV_INITRD is not set
diff --git a/arch/powerpc/configs/52xx/tqm5200_defconfig
b/arch/powerpc/configs/52xx/tqm5200_defconfig
index 96181c6..a108b84 100644
--- a/arch/powerpc/configs/52xx/tqm5200_defconfig
+++ b/arch/powerpc/configs/52xx/tqm5200_defconfig
@@ -95,8 +95,7 @@ CONFIG_RCU_FANOUT=32
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
index 183c59c..b728a7d 100644
--- a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
+++ b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
@@ -103,8 +103,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 CONFIG_RELAY=y
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/86xx/gef_sbc310_defconfig
b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
index 1524d94..8e738de 100644
--- a/arch/powerpc/configs/86xx/gef_sbc310_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
@@ -103,8 +103,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 CONFIG_RELAY=y
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/86xx/gef_sbc610_defconfig
b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
index 767c204..59bf9e2 100644
--- a/arch/powerpc/configs/86xx/gef_sbc610_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
@@ -103,8 +103,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 CONFIG_RELAY=y
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
index 55b9e4e..4e8b01e 100644
--- a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
@@ -98,8 +98,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
index 1be38eb..20fde63 100644
--- a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
+++ b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
@@ -103,8 +103,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/86xx/sbc8641d_defconfig
b/arch/powerpc/configs/86xx/sbc8641d_defconfig
index a630094..74f714d 100644
--- a/arch/powerpc/configs/86xx/sbc8641d_defconfig
+++ b/arch/powerpc/configs/86xx/sbc8641d_defconfig
@@ -102,8 +102,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 CONFIG_RELAY=y
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/adder875_defconfig
b/arch/powerpc/configs/adder875_defconfig
index 9f89d5c..a670cee 100644
--- a/arch/powerpc/configs/adder875_defconfig
+++ b/arch/powerpc/configs/adder875_defconfig
@@ -92,8 +92,7 @@ CONFIG_RCU_FANOUT=32
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 # CONFIG_BLK_DEV_INITRD is not set
diff --git a/arch/powerpc/configs/amigaone_defconfig
b/arch/powerpc/configs/amigaone_defconfig
index b63cc38..851287e 100644
--- a/arch/powerpc/configs/amigaone_defconfig
+++ b/arch/powerpc/configs/amigaone_defconfig
@@ -87,8 +87,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=15
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/c2k_defconfig
b/arch/powerpc/configs/c2k_defconfig
index 4ab6074..b429a65 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -102,8 +102,7 @@ CONFIG_RCU_FANOUT=32
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/cell_defconfig
b/arch/powerpc/configs/cell_defconfig
index c6d2baa..9433719 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -83,8 +83,7 @@ CONFIG_CPUSETS=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUP_CPUACCT is not set
 # CONFIG_RESOURCE_COUNTERS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 CONFIG_PROC_PID_CPUSET=y
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
diff --git a/arch/powerpc/configs/celleb_defconfig
b/arch/powerpc/configs/celleb_defconfig
index d212377..6be6c09 100644
--- a/arch/powerpc/configs/celleb_defconfig
+++ b/arch/powerpc/configs/celleb_defconfig
@@ -78,8 +78,7 @@ CONFIG_LOG_BUF_SHIFT=15
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_USER_SCHED is not set
 # CONFIG_CGROUP_SCHED is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/chrp32_defconfig
b/arch/powerpc/configs/chrp32_defconfig
index 5094a65..2fdab66 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -77,8 +77,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=15
 # CONFIG_CGROUPS is not set
 # CONFIG_GROUP_SCHED is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/ep8248e_defconfig
b/arch/powerpc/configs/ep8248e_defconfig
index 81e904e..6b70839 100644
--- a/arch/powerpc/configs/ep8248e_defconfig
+++ b/arch/powerpc/configs/ep8248e_defconfig
@@ -96,8 +96,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 # CONFIG_BLK_DEV_INITRD is not set
diff --git a/arch/powerpc/configs/ep88xc_defconfig
b/arch/powerpc/configs/ep88xc_defconfig
index c5af46e..1cee889 100644
--- a/arch/powerpc/configs/ep88xc_defconfig
+++ b/arch/powerpc/configs/ep88xc_defconfig
@@ -91,8 +91,7 @@ CONFIG_RCU_FANOUT=32
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 # CONFIG_BLK_DEV_INITRD is not set
diff --git a/arch/powerpc/configs/g5_defconfig
b/arch/powerpc/configs/g5_defconfig
index 826a65d..57d3ffa 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -82,8 +82,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_CGROUPS is not set
 # CONFIG_GROUP_SCHED is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/gamecube_defconfig
b/arch/powerpc/configs/gamecube_defconfig
index 942e119..1c2dbf0 100644
--- a/arch/powerpc/configs/gamecube_defconfig
+++ b/arch/powerpc/configs/gamecube_defconfig
@@ -101,8 +101,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/holly_defconfig
b/arch/powerpc/configs/holly_defconfig
index a211a79..a60d61b 100644
--- a/arch/powerpc/configs/holly_defconfig
+++ b/arch/powerpc/configs/holly_defconfig
@@ -73,7 +73,6 @@ CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
 # CONFIG_FAIR_GROUP_SCHED is not set
-CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
diff --git a/arch/powerpc/configs/iseries_defconfig
b/arch/powerpc/configs/iseries_defconfig
index 76982c5..151c8e1 100644
--- a/arch/powerpc/configs/iseries_defconfig
+++ b/arch/powerpc/configs/iseries_defconfig
@@ -81,8 +81,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_CGROUPS is not set
 # CONFIG_GROUP_SCHED is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/linkstation_defconfig
b/arch/powerpc/configs/linkstation_defconfig
index 588a2ad..8ecacf7 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -97,8 +97,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/maple_defconfig
b/arch/powerpc/configs/maple_defconfig
index 8b24400..dc50eec 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -78,8 +78,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_CGROUPS is not set
 # CONFIG_GROUP_SCHED is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/mgcoge_defconfig
b/arch/powerpc/configs/mgcoge_defconfig
index 0cbd56f..b36ebb7 100644
--- a/arch/powerpc/configs/mgcoge_defconfig
+++ b/arch/powerpc/configs/mgcoge_defconfig
@@ -96,8 +96,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/mgsuvd_defconfig
b/arch/powerpc/configs/mgsuvd_defconfig
index c1be261..0dd5015 100644
--- a/arch/powerpc/configs/mgsuvd_defconfig
+++ b/arch/powerpc/configs/mgsuvd_defconfig
@@ -90,8 +90,7 @@ CONFIG_RCU_FANOUT=32
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/mpc512x_defconfig
b/arch/powerpc/configs/mpc512x_defconfig
index a047272..aa2654e 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -97,8 +97,7 @@ CONFIG_RCU_FANOUT=32
 CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/mpc5200_defconfig
b/arch/powerpc/configs/mpc5200_defconfig
index 7012ac0..f875ec2 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -97,8 +97,7 @@ CONFIG_RCU_FANOUT=32
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/mpc7448_hpc2_defconfig
b/arch/powerpc/configs/mpc7448_hpc2_defconfig
index 27c63ce..b1e88fe 100644
--- a/arch/powerpc/configs/mpc7448_hpc2_defconfig
+++ b/arch/powerpc/configs/mpc7448_hpc2_defconfig
@@ -95,8 +95,7 @@ CONFIG_RCU_FANOUT=32
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/pasemi_defconfig
b/arch/powerpc/configs/pasemi_defconfig
index 20ba0cf..74a7216 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -98,8 +98,7 @@ CONFIG_RCU_FANOUT=64
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/pmac32_defconfig
b/arch/powerpc/configs/pmac32_defconfig
index ea8870a..753bb79 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -93,8 +93,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/ppc40x_defconfig
b/arch/powerpc/configs/ppc40x_defconfig
index 35b6068..afb4d1b 100644
--- a/arch/powerpc/configs/ppc40x_defconfig
+++ b/arch/powerpc/configs/ppc40x_defconfig
@@ -99,8 +99,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/ppc44x_defconfig
b/arch/powerpc/configs/ppc44x_defconfig
index 46f5c47..bd3d23f 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -103,8 +103,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/ppc64_defconfig
b/arch/powerpc/configs/ppc64_defconfig
index 12980d5..85be3d8 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -93,8 +93,7 @@ CONFIG_CPUSETS=y
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUP_CPUACCT is not set
 # CONFIG_RESOURCE_COUNTERS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 CONFIG_PROC_PID_CPUSET=y
 CONFIG_RELAY=y
 CONFIG_NAMESPACES=y
diff --git a/arch/powerpc/configs/ppc64e_defconfig
b/arch/powerpc/configs/ppc64e_defconfig
index 8195f16..403e82e 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -107,8 +107,7 @@ CONFIG_CPUSETS=y
 CONFIG_PROC_PID_CPUSET=y
 # CONFIG_CGROUP_CPUACCT is not set
 # CONFIG_RESOURCE_COUNTERS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 CONFIG_RELAY=y
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/pq2fads_defconfig
b/arch/powerpc/configs/pq2fads_defconfig
index 68c175e..12c8ee8 100644
--- a/arch/powerpc/configs/pq2fads_defconfig
+++ b/arch/powerpc/configs/pq2fads_defconfig
@@ -96,8 +96,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/prpmc2800_defconfig
b/arch/powerpc/configs/prpmc2800_defconfig
index 93f4505..a18f597 100644
--- a/arch/powerpc/configs/prpmc2800_defconfig
+++ b/arch/powerpc/configs/prpmc2800_defconfig
@@ -98,8 +98,7 @@ CONFIG_RCU_FANOUT=32
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
diff --git a/arch/powerpc/configs/pseries_defconfig
b/arch/powerpc/configs/pseries_defconfig
index 41de3dd..ea63b8b 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -92,8 +92,7 @@ CONFIG_CPUSETS=y
 # CONFIG_GROUP_SCHED is not set
 CONFIG_CGROUP_CPUACCT=y
 # CONFIG_RESOURCE_COUNTERS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 CONFIG_PROC_PID_CPUSET=y
 CONFIG_RELAY=y
 CONFIG_NAMESPACES=y
diff --git a/arch/powerpc/configs/storcenter_defconfig
b/arch/powerpc/configs/storcenter_defconfig
index b162580..01be0e2 100644
--- a/arch/powerpc/configs/storcenter_defconfig
+++ b/arch/powerpc/configs/storcenter_defconfig
@@ -95,8 +95,7 @@ CONFIG_RCU_FANOUT=32
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 # CONFIG_BLK_DEV_INITRD is not set
diff --git a/arch/powerpc/configs/wii_defconfig
b/arch/powerpc/configs/wii_defconfig
index c386828..ee054f8 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -102,8 +102,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 CONFIG_RELAY=y
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev

--000e0cd2c5d210280a04886883b8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Acked-by: Grant Likely &lt;<a href=3D"mailto:grant.likely@secretlab.ca">=
grant.likely@secretlab.ca</a>&gt;</p>
<p><blockquote type=3D"cite">On 5 May 2010 21:33, &quot;Anton Blanchard&quo=
t; &lt;<a href=3D"mailto:anton@samba.org">anton@samba.org</a>&gt; wrote:<br=
><br><br>
CONFIG_SYSFS_DEPRECATED can cause issues with newer distros and should not<=
br>
be required for any distro in the last 3 or 4 years, so disable it.<br>
<br>
Signed-off-by: Anton Blanchard &lt;<a href=3D"mailto:anton@samba.org">anton=
@samba.org</a>&gt;<br>
---<br>
<br>
diff --git a/arch/powerpc/configs/40x/acadia_defconfig b/arch/powerpc/confi=
gs/40x/acadia_defconfig<br>
index 8e95f8d..4aa17b6 100644<br>
--- a/arch/powerpc/configs/40x/acadia_defconfig<br>
+++ b/arch/powerpc/configs/40x/acadia_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/40x/ep405_defconfig b/arch/powerpc/config=
s/40x/ep405_defconfig<br>
index 918f23f..9a5f1ab 100644<br>
--- a/arch/powerpc/configs/40x/ep405_defconfig<br>
+++ b/arch/powerpc/configs/40x/ep405_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_FAIR_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/40x/hcu4_defconfig b/arch/powerpc/configs=
/40x/hcu4_defconfig<br>
index f87ef03..0b45213 100644<br>
--- a/arch/powerpc/configs/40x/hcu4_defconfig<br>
+++ b/arch/powerpc/configs/40x/hcu4_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_FAIR_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/40x/kilauea_defconfig b/arch/powerpc/conf=
igs/40x/kilauea_defconfig<br>
index 19fbcb0..4d2de0b 100644<br>
--- a/arch/powerpc/configs/40x/kilauea_defconfig<br>
+++ b/arch/powerpc/configs/40x/kilauea_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/40x/makalu_defconfig b/arch/powerpc/confi=
gs/40x/makalu_defconfig<br>
index eb41cd6..a1f3f50 100644<br>
--- a/arch/powerpc/configs/40x/makalu_defconfig<br>
+++ b/arch/powerpc/configs/40x/makalu_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/40x/virtex_defconfig b/arch/powerpc/confi=
gs/40x/virtex_defconfig<br>
index 416e79a..c763135 100644<br>
--- a/arch/powerpc/configs/40x/virtex_defconfig<br>
+++ b/arch/powerpc/configs/40x/virtex_defconfig<br>
@@ -77,8 +77,7 @@ CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/40x/walnut_defconfig b/arch/powerpc/confi=
gs/40x/walnut_defconfig<br>
index bfff0ea..6597b2f 100644<br>
--- a/arch/powerpc/configs/40x/walnut_defconfig<br>
+++ b/arch/powerpc/configs/40x/walnut_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_FAIR_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/44x/arches_defconfig b/arch/powerpc/confi=
gs/44x/arches_defconfig<br>
index 1f6d049..2d3dfb5 100644<br>
--- a/arch/powerpc/configs/44x/arches_defconfig<br>
+++ b/arch/powerpc/configs/44x/arches_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/44x/bamboo_defconfig b/arch/powerpc/confi=
gs/44x/bamboo_defconfig<br>
index 788faac..51a00c4 100644<br>
--- a/arch/powerpc/configs/44x/bamboo_defconfig<br>
+++ b/arch/powerpc/configs/44x/bamboo_defconfig<br>
@@ -102,8 +102,7 @@ CONFIG_FAIR_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/44x/canyonlands_defconfig b/arch/powerpc/=
configs/44x/canyonlands_defconfig<br>
index 4ef8bca..1028b1b 100644<br>
--- a/arch/powerpc/configs/44x/canyonlands_defconfig<br>
+++ b/arch/powerpc/configs/44x/canyonlands_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/44x/ebony_defconfig b/arch/powerpc/config=
s/44x/ebony_defconfig<br>
index ca17b14..69f5633 100644<br>
--- a/arch/powerpc/configs/44x/ebony_defconfig<br>
+++ b/arch/powerpc/configs/44x/ebony_defconfig<br>
@@ -101,8 +101,7 @@ CONFIG_FAIR_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/44x/eiger_defconfig b/arch/powerpc/config=
s/44x/eiger_defconfig<br>
index e3149ba..dcd859c 100644<br>
--- a/arch/powerpc/configs/44x/eiger_defconfig<br>
+++ b/arch/powerpc/configs/44x/eiger_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/44x/katmai_defconfig b/arch/powerpc/confi=
gs/44x/katmai_defconfig<br>
index af244e1..a2c24d1 100644<br>
--- a/arch/powerpc/configs/44x/katmai_defconfig<br>
+++ b/arch/powerpc/configs/44x/katmai_defconfig<br>
@@ -97,8 +97,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/44x/rainier_defconfig b/arch/powerpc/conf=
igs/44x/rainier_defconfig<br>
index 8fed3b2..3bb55b5 100644<br>
--- a/arch/powerpc/configs/44x/rainier_defconfig<br>
+++ b/arch/powerpc/configs/44x/rainier_defconfig<br>
@@ -101,8 +101,7 @@ CONFIG_FAIR_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/44x/redwood_defconfig b/arch/powerpc/conf=
igs/44x/redwood_defconfig<br>
index a67ec91..684f40d 100644<br>
--- a/arch/powerpc/configs/44x/redwood_defconfig<br>
+++ b/arch/powerpc/configs/44x/redwood_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/44x/sam440ep_defconfig b/arch/powerpc/con=
figs/44x/sam440ep_defconfig<br>
index 886cb6a..e202924 100644<br>
--- a/arch/powerpc/configs/44x/sam440ep_defconfig<br>
+++ b/arch/powerpc/configs/44x/sam440ep_defconfig<br>
@@ -103,8 +103,7 @@ CONFIG_FAIR_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/44x/sequoia_defconfig b/arch/powerpc/conf=
igs/44x/sequoia_defconfig<br>
index 1b2f41d..c348a46 100644<br>
--- a/arch/powerpc/configs/44x/sequoia_defconfig<br>
+++ b/arch/powerpc/configs/44x/sequoia_defconfig<br>
@@ -102,8 +102,7 @@ CONFIG_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/44x/taishan_defconfig b/arch/powerpc/conf=
igs/44x/taishan_defconfig<br>
index 12041d3..f4cb7e8 100644<br>
--- a/arch/powerpc/configs/44x/taishan_defconfig<br>
+++ b/arch/powerpc/configs/44x/taishan_defconfig<br>
@@ -101,8 +101,7 @@ CONFIG_FAIR_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/44x/virtex5_defconfig b/arch/powerpc/conf=
igs/44x/virtex5_defconfig<br>
index 2518b85..c7ead0e 100644<br>
--- a/arch/powerpc/configs/44x/virtex5_defconfig<br>
+++ b/arch/powerpc/configs/44x/virtex5_defconfig<br>
@@ -80,8 +80,7 @@ CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/52xx/cm5200_defconfig b/arch/powerpc/conf=
igs/52xx/cm5200_defconfig<br>
index 218d49b..7664c83 100644<br>
--- a/arch/powerpc/configs/52xx/cm5200_defconfig<br>
+++ b/arch/powerpc/configs/52xx/cm5200_defconfig<br>
@@ -95,8 +95,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0# CONFIG_IKCONFIG is not set<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/52xx/lite5200b_defconfig b/arch/powerpc/c=
onfigs/52xx/lite5200b_defconfig<br>
index 90492ff..eac7c17 100644<br>
--- a/arch/powerpc/configs/52xx/lite5200b_defconfig<br>
+++ b/arch/powerpc/configs/52xx/lite5200b_defconfig<br>
@@ -96,8 +96,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0# CONFIG_IKCONFIG is not set<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/52xx/motionpro_defconfig b/arch/powerpc/c=
onfigs/52xx/motionpro_defconfig<br>
index dffc8ca..27afb6e 100644<br>
--- a/arch/powerpc/configs/52xx/motionpro_defconfig<br>
+++ b/arch/powerpc/configs/52xx/motionpro_defconfig<br>
@@ -95,8 +95,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0# CONFIG_IKCONFIG is not set<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/52xx/pcm030_defconfig b/arch/powerpc/conf=
igs/52xx/pcm030_defconfig<br>
index 3cb2a52..5fe39dd 100644<br>
--- a/arch/powerpc/configs/52xx/pcm030_defconfig<br>
+++ b/arch/powerpc/configs/52xx/pcm030_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_IKCONFIG=3Dy<br>
=A0CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0# CONFIG_BLK_DEV_INITRD is not set<br>
diff --git a/arch/powerpc/configs/52xx/tqm5200_defconfig b/arch/powerpc/con=
figs/52xx/tqm5200_defconfig<br>
index 96181c6..a108b84 100644<br>
--- a/arch/powerpc/configs/52xx/tqm5200_defconfig<br>
+++ b/arch/powerpc/configs/52xx/tqm5200_defconfig<br>
@@ -95,8 +95,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0# CONFIG_IKCONFIG is not set<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig b/arch/powerpc/c=
onfigs/86xx/gef_ppc9a_defconfig<br>
index 183c59c..b728a7d 100644<br>
--- a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig<br>
+++ b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig<br>
@@ -103,8 +103,7 @@ CONFIG_IKCONFIG=3Dy<br>
=A0CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0CONFIG_RELAY=3Dy<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/86xx/gef_sbc310_defconfig b/arch/powerpc/=
configs/86xx/gef_sbc310_defconfig<br>
index 1524d94..8e738de 100644<br>
--- a/arch/powerpc/configs/86xx/gef_sbc310_defconfig<br>
+++ b/arch/powerpc/configs/86xx/gef_sbc310_defconfig<br>
@@ -103,8 +103,7 @@ CONFIG_IKCONFIG=3Dy<br>
=A0CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0CONFIG_RELAY=3Dy<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/86xx/gef_sbc610_defconfig b/arch/powerpc/=
configs/86xx/gef_sbc610_defconfig<br>
index 767c204..59bf9e2 100644<br>
--- a/arch/powerpc/configs/86xx/gef_sbc610_defconfig<br>
+++ b/arch/powerpc/configs/86xx/gef_sbc610_defconfig<br>
@@ -103,8 +103,7 @@ CONFIG_IKCONFIG=3Dy<br>
=A0CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0CONFIG_RELAY=3Dy<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig b/arch/powerp=
c/configs/86xx/mpc8610_hpcd_defconfig<br>
index 55b9e4e..4e8b01e 100644<br>
--- a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig<br>
+++ b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_IKCONFIG=3Dy<br>
=A0CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig b/arch/powerp=
c/configs/86xx/mpc8641_hpcn_defconfig<br>
index 1be38eb..20fde63 100644<br>
--- a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig<br>
+++ b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig<br>
@@ -103,8 +103,7 @@ CONFIG_IKCONFIG=3Dy<br>
=A0CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/86xx/sbc8641d_defconfig b/arch/powerpc/co=
nfigs/86xx/sbc8641d_defconfig<br>
index a630094..74f714d 100644<br>
--- a/arch/powerpc/configs/86xx/sbc8641d_defconfig<br>
+++ b/arch/powerpc/configs/86xx/sbc8641d_defconfig<br>
@@ -102,8 +102,7 @@ CONFIG_IKCONFIG=3Dy<br>
=A0CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0CONFIG_RELAY=3Dy<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/adder875_defconfig b/arch/powerpc/configs=
/adder875_defconfig<br>
index 9f89d5c..a670cee 100644<br>
--- a/arch/powerpc/configs/adder875_defconfig<br>
+++ b/arch/powerpc/configs/adder875_defconfig<br>
@@ -92,8 +92,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0# CONFIG_IKCONFIG is not set<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0# CONFIG_BLK_DEV_INITRD is not set<br>
diff --git a/arch/powerpc/configs/amigaone_defconfig b/arch/powerpc/configs=
/amigaone_defconfig<br>
index b63cc38..851287e 100644<br>
--- a/arch/powerpc/configs/amigaone_defconfig<br>
+++ b/arch/powerpc/configs/amigaone_defconfig<br>
@@ -87,8 +87,7 @@ CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D15<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_=
defconfig<br>
index 4ab6074..b429a65 100644<br>
--- a/arch/powerpc/configs/c2k_defconfig<br>
+++ b/arch/powerpc/configs/c2k_defconfig<br>
@@ -102,8 +102,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0# CONFIG_IKCONFIG is not set<br>
=A0CONFIG_LOG_BUF_SHIFT=3D17<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cel=
l_defconfig<br>
index c6d2baa..9433719 100644<br>
--- a/arch/powerpc/configs/cell_defconfig<br>
+++ b/arch/powerpc/configs/cell_defconfig<br>
@@ -83,8 +83,7 @@ CONFIG_CPUSETS=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUP_CPUACCT is not set<br>
=A0# CONFIG_RESOURCE_COUNTERS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0CONFIG_PROC_PID_CPUSET=3Dy<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
diff --git a/arch/powerpc/configs/celleb_defconfig b/arch/powerpc/configs/c=
elleb_defconfig<br>
index d212377..6be6c09 100644<br>
--- a/arch/powerpc/configs/celleb_defconfig<br>
+++ b/arch/powerpc/configs/celleb_defconfig<br>
@@ -78,8 +78,7 @@ CONFIG_LOG_BUF_SHIFT=3D15<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0# CONFIG_USER_SCHED is not set<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/c=
hrp32_defconfig<br>
index 5094a65..2fdab66 100644<br>
--- a/arch/powerpc/configs/chrp32_defconfig<br>
+++ b/arch/powerpc/configs/chrp32_defconfig<br>
@@ -77,8 +77,7 @@ CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D15<br>
=A0# CONFIG_CGROUPS is not set<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/ep8248e_defconfig b/arch/powerpc/configs/=
ep8248e_defconfig<br>
index 81e904e..6b70839 100644<br>
--- a/arch/powerpc/configs/ep8248e_defconfig<br>
+++ b/arch/powerpc/configs/ep8248e_defconfig<br>
@@ -96,8 +96,7 @@ CONFIG_IKCONFIG=3Dy<br>
=A0CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0# CONFIG_BLK_DEV_INITRD is not set<br>
diff --git a/arch/powerpc/configs/ep88xc_defconfig b/arch/powerpc/configs/e=
p88xc_defconfig<br>
index c5af46e..1cee889 100644<br>
--- a/arch/powerpc/configs/ep88xc_defconfig<br>
+++ b/arch/powerpc/configs/ep88xc_defconfig<br>
@@ -91,8 +91,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0# CONFIG_IKCONFIG is not set<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0# CONFIG_BLK_DEV_INITRD is not set<br>
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_de=
fconfig<br>
index 826a65d..57d3ffa 100644<br>
--- a/arch/powerpc/configs/g5_defconfig<br>
+++ b/arch/powerpc/configs/g5_defconfig<br>
@@ -82,8 +82,7 @@ CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D17<br>
=A0# CONFIG_CGROUPS is not set<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/gamecube_defconfig b/arch/powerpc/configs=
/gamecube_defconfig<br>
index 942e119..1c2dbf0 100644<br>
--- a/arch/powerpc/configs/gamecube_defconfig<br>
+++ b/arch/powerpc/configs/gamecube_defconfig<br>
@@ -101,8 +101,7 @@ CONFIG_FAIR_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/holly_defconfig b/arch/powerpc/configs/ho=
lly_defconfig<br>
index a211a79..a60d61b 100644<br>
--- a/arch/powerpc/configs/holly_defconfig<br>
+++ b/arch/powerpc/configs/holly_defconfig<br>
@@ -73,7 +73,6 @@ CONFIG_SYSVIPC_SYSCTL=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
=A0# CONFIG_FAIR_GROUP_SCHED is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
=A0CONFIG_INITRAMFS_SOURCE=3D&quot;&quot;<br>
diff --git a/arch/powerpc/configs/iseries_defconfig b/arch/powerpc/configs/=
iseries_defconfig<br>
index 76982c5..151c8e1 100644<br>
--- a/arch/powerpc/configs/iseries_defconfig<br>
+++ b/arch/powerpc/configs/iseries_defconfig<br>
@@ -81,8 +81,7 @@ CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D17<br>
=A0# CONFIG_CGROUPS is not set<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/conf=
igs/linkstation_defconfig<br>
index 588a2ad..8ecacf7 100644<br>
--- a/arch/powerpc/configs/linkstation_defconfig<br>
+++ b/arch/powerpc/configs/linkstation_defconfig<br>
@@ -97,8 +97,7 @@ CONFIG_IKCONFIG=3Dy<br>
=A0CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/ma=
ple_defconfig<br>
index 8b24400..dc50eec 100644<br>
--- a/arch/powerpc/configs/maple_defconfig<br>
+++ b/arch/powerpc/configs/maple_defconfig<br>
@@ -78,8 +78,7 @@ CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D17<br>
=A0# CONFIG_CGROUPS is not set<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/m=
gcoge_defconfig<br>
index 0cbd56f..b36ebb7 100644<br>
--- a/arch/powerpc/configs/mgcoge_defconfig<br>
+++ b/arch/powerpc/configs/mgcoge_defconfig<br>
@@ -96,8 +96,7 @@ CONFIG_IKCONFIG=3Dy<br>
=A0CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/mgsuvd_defconfig b/arch/powerpc/configs/m=
gsuvd_defconfig<br>
index c1be261..0dd5015 100644<br>
--- a/arch/powerpc/configs/mgsuvd_defconfig<br>
+++ b/arch/powerpc/configs/mgsuvd_defconfig<br>
@@ -90,8 +90,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0# CONFIG_IKCONFIG is not set<br>
=A0CONFIG_LOG_BUF_SHIFT=3D17<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/=
mpc512x_defconfig<br>
index a047272..aa2654e 100644<br>
--- a/arch/powerpc/configs/mpc512x_defconfig<br>
+++ b/arch/powerpc/configs/mpc512x_defconfig<br>
@@ -97,8 +97,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0CONFIG_LOG_BUF_SHIFT=3D16<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/=
mpc5200_defconfig<br>
index 7012ac0..f875ec2 100644<br>
--- a/arch/powerpc/configs/mpc5200_defconfig<br>
+++ b/arch/powerpc/configs/mpc5200_defconfig<br>
@@ -97,8 +97,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0# CONFIG_IKCONFIG is not set<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/mpc7448_hpc2_defconfig b/arch/powerpc/con=
figs/mpc7448_hpc2_defconfig<br>
index 27c63ce..b1e88fe 100644<br>
--- a/arch/powerpc/configs/mpc7448_hpc2_defconfig<br>
+++ b/arch/powerpc/configs/mpc7448_hpc2_defconfig<br>
@@ -95,8 +95,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0# CONFIG_IKCONFIG is not set<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/p=
asemi_defconfig<br>
index 20ba0cf..74a7216 100644<br>
--- a/arch/powerpc/configs/pasemi_defconfig<br>
+++ b/arch/powerpc/configs/pasemi_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_RCU_FANOUT=3D64<br>
=A0CONFIG_LOG_BUF_SHIFT=3D17<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/p=
mac32_defconfig<br>
index ea8870a..753bb79 100644<br>
--- a/arch/powerpc/configs/pmac32_defconfig<br>
+++ b/arch/powerpc/configs/pmac32_defconfig<br>
@@ -93,8 +93,7 @@ CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/ppc40x_defconfig b/arch/powerpc/configs/p=
pc40x_defconfig<br>
index 35b6068..afb4d1b 100644<br>
--- a/arch/powerpc/configs/ppc40x_defconfig<br>
+++ b/arch/powerpc/configs/ppc40x_defconfig<br>
@@ -99,8 +99,7 @@ CONFIG_FAIR_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/p=
pc44x_defconfig<br>
index 46f5c47..bd3d23f 100644<br>
--- a/arch/powerpc/configs/ppc44x_defconfig<br>
+++ b/arch/powerpc/configs/ppc44x_defconfig<br>
@@ -103,8 +103,7 @@ CONFIG_FAIR_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/pp=
c64_defconfig<br>
index 12980d5..85be3d8 100644<br>
--- a/arch/powerpc/configs/ppc64_defconfig<br>
+++ b/arch/powerpc/configs/ppc64_defconfig<br>
@@ -93,8 +93,7 @@ CONFIG_CPUSETS=3Dy<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0# CONFIG_CGROUP_CPUACCT is not set<br>
=A0# CONFIG_RESOURCE_COUNTERS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0CONFIG_PROC_PID_CPUSET=3Dy<br>
=A0CONFIG_RELAY=3Dy<br>
=A0CONFIG_NAMESPACES=3Dy<br>
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/p=
pc64e_defconfig<br>
index 8195f16..403e82e 100644<br>
--- a/arch/powerpc/configs/ppc64e_defconfig<br>
+++ b/arch/powerpc/configs/ppc64e_defconfig<br>
@@ -107,8 +107,7 @@ CONFIG_CPUSETS=3Dy<br>
=A0CONFIG_PROC_PID_CPUSET=3Dy<br>
=A0# CONFIG_CGROUP_CPUACCT is not set<br>
=A0# CONFIG_RESOURCE_COUNTERS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0CONFIG_RELAY=3Dy<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/pq2fads_defconfig b/arch/powerpc/configs/=
pq2fads_defconfig<br>
index 68c175e..12c8ee8 100644<br>
--- a/arch/powerpc/configs/pq2fads_defconfig<br>
+++ b/arch/powerpc/configs/pq2fads_defconfig<br>
@@ -96,8 +96,7 @@ CONFIG_IKCONFIG=3Dy<br>
=A0CONFIG_IKCONFIG_PROC=3Dy<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
diff --git a/arch/powerpc/configs/prpmc2800_defconfig b/arch/powerpc/config=
s/prpmc2800_defconfig<br>
index 93f4505..a18f597 100644<br>
--- a/arch/powerpc/configs/prpmc2800_defconfig<br>
+++ b/arch/powerpc/configs/prpmc2800_defconfig<br>
@@ -98,8 +98,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0# CONFIG_IKCONFIG is not set<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0CONFIG_NAMESPACES=3Dy<br>
=A0# CONFIG_UTS_NS is not set<br>
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/=
pseries_defconfig<br>
index 41de3dd..ea63b8b 100644<br>
--- a/arch/powerpc/configs/pseries_defconfig<br>
+++ b/arch/powerpc/configs/pseries_defconfig<br>
@@ -92,8 +92,7 @@ CONFIG_CPUSETS=3Dy<br>
=A0# CONFIG_GROUP_SCHED is not set<br>
=A0CONFIG_CGROUP_CPUACCT=3Dy<br>
=A0# CONFIG_RESOURCE_COUNTERS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0CONFIG_PROC_PID_CPUSET=3Dy<br>
=A0CONFIG_RELAY=3Dy<br>
=A0CONFIG_NAMESPACES=3Dy<br>
diff --git a/arch/powerpc/configs/storcenter_defconfig b/arch/powerpc/confi=
gs/storcenter_defconfig<br>
index b162580..01be0e2 100644<br>
--- a/arch/powerpc/configs/storcenter_defconfig<br>
+++ b/arch/powerpc/configs/storcenter_defconfig<br>
@@ -95,8 +95,7 @@ CONFIG_RCU_FANOUT=3D32<br>
=A0# CONFIG_IKCONFIG is not set<br>
=A0CONFIG_LOG_BUF_SHIFT=3D14<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0# CONFIG_RELAY is not set<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0# CONFIG_BLK_DEV_INITRD is not set<br>
diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_=
defconfig<br>
index c386828..ee054f8 100644<br>
--- a/arch/powerpc/configs/wii_defconfig<br>
+++ b/arch/powerpc/configs/wii_defconfig<br>
@@ -102,8 +102,7 @@ CONFIG_FAIR_GROUP_SCHED=3Dy<br>
=A0CONFIG_USER_SCHED=3Dy<br>
=A0# CONFIG_CGROUP_SCHED is not set<br>
=A0# CONFIG_CGROUPS is not set<br>
-CONFIG_SYSFS_DEPRECATED=3Dy<br>
-CONFIG_SYSFS_DEPRECATED_V2=3Dy<br>
+# CONFIG_SYSFS_DEPRECATED_V2 is not set<br>
=A0CONFIG_RELAY=3Dy<br>
=A0# CONFIG_NAMESPACES is not set<br>
=A0CONFIG_BLK_DEV_INITRD=3Dy<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
</blockquote></p>

--000e0cd2c5d210280a04886883b8--
