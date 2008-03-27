Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 75367DDF04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 16:36:09 +1100 (EST)
Date: Thu, 27 Mar 2008 16:36:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Remove CONFIG_PCI_LEGACY from some configs
Message-Id: <20080327163608.81f87de2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This will remove some build warnings and doesn't stop us building any
drivers that we were building previously with these configs.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/configs/chrp32_defconfig  |    7 +++----
 arch/powerpc/configs/g5_defconfig      |    7 +++----
 arch/powerpc/configs/iseries_defconfig |    7 +++----
 arch/powerpc/configs/pmac32_defconfig  |    7 +++----
 arch/powerpc/configs/ppc64_defconfig   |    8 ++++----
 arch/powerpc/configs/pseries_defconfig |    8 ++++----
 6 files changed, 20 insertions(+), 24 deletions(-)

I have built all these configs.

diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
index 38b85b2..d7fd298 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.25-rc6
-# Thu Mar 20 10:33:36 2008
+# Thu Mar 27 13:55:37 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -74,8 +74,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=15
 # CONFIG_CGROUPS is not set
 # CONFIG_GROUP_SCHED is not set
-# CONFIG_USER_SCHED is not set
-# CONFIG_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
@@ -243,7 +241,7 @@ CONFIG_PCI_SYSCALL=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
-CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_DEBUG is not set
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
@@ -1328,6 +1326,7 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
 
 #
 # Kernel hacking
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 0f82f66..a20501f 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.25-rc6
-# Thu Mar 20 10:36:41 2008
+# Thu Mar 27 13:55:43 2008
 #
 CONFIG_PPC64=y
 
@@ -77,8 +77,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_CGROUPS is not set
 # CONFIG_GROUP_SCHED is not set
-# CONFIG_USER_SCHED is not set
-# CONFIG_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
@@ -276,7 +274,7 @@ CONFIG_PCI_SYSCALL=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 CONFIG_PCI_MSI=y
-CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_DEBUG is not set
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
@@ -1596,6 +1594,7 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
 
 #
 # Kernel hacking
diff --git a/arch/powerpc/configs/iseries_defconfig b/arch/powerpc/configs/iseries_defconfig
index 8d9a84f..b3128fb 100644
--- a/arch/powerpc/configs/iseries_defconfig
+++ b/arch/powerpc/configs/iseries_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.25-rc6
-# Thu Mar 20 10:43:46 2008
+# Thu Mar 27 13:55:45 2008
 #
 CONFIG_PPC64=y
 
@@ -77,8 +77,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_CGROUPS is not set
 # CONFIG_GROUP_SCHED is not set
-# CONFIG_USER_SCHED is not set
-# CONFIG_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
@@ -261,7 +259,7 @@ CONFIG_PCI_SYSCALL=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
-CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_DEBUG is not set
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
@@ -1065,6 +1063,7 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
 
 #
 # Kernel hacking
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index 558b0d3..fca1142 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.25-rc6
-# Thu Mar 20 11:05:14 2008
+# Thu Mar 27 13:56:21 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -77,8 +77,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
 # CONFIG_GROUP_SCHED is not set
-# CONFIG_USER_SCHED is not set
-# CONFIG_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
@@ -272,7 +270,7 @@ CONFIG_PCI_SYSCALL=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
-CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_DEBUG is not set
 CONFIG_PCCARD=m
 # CONFIG_PCMCIA_DEBUG is not set
@@ -1895,6 +1893,7 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
 
 #
 # Kernel hacking
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 880ab7a..970282b 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.25-rc6
-# Thu Mar 20 11:06:28 2008
+# Thu Mar 27 13:56:24 2008
 #
 CONFIG_PPC64=y
 
@@ -84,8 +84,6 @@ CONFIG_CGROUPS=y
 # CONFIG_CGROUP_NS is not set
 CONFIG_CPUSETS=y
 # CONFIG_GROUP_SCHED is not set
-# CONFIG_USER_SCHED is not set
-# CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUP_CPUACCT is not set
 # CONFIG_RESOURCE_COUNTERS is not set
 CONFIG_SYSFS_DEPRECATED=y
@@ -289,6 +287,7 @@ CONFIG_ARCH_HAS_WALK_MEMORY=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
 CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
+# CONFIG_PHYP_DUMP is not set
 CONFIG_IRQ_ALL_CPUS=y
 # CONFIG_NUMA is not set
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
@@ -335,7 +334,7 @@ CONFIG_PCI_SYSCALL=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 CONFIG_PCI_MSI=y
-CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_DEBUG is not set
 CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
@@ -1881,6 +1880,7 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
 
 #
 # Kernel hacking
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 755aca7..3e2593c 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.25-rc6
-# Thu Mar 20 11:08:01 2008
+# Thu Mar 27 13:56:28 2008
 #
 CONFIG_PPC64=y
 
@@ -83,8 +83,6 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_NS=y
 CONFIG_CPUSETS=y
 # CONFIG_GROUP_SCHED is not set
-# CONFIG_USER_SCHED is not set
-# CONFIG_CGROUP_SCHED is not set
 CONFIG_CGROUP_CPUACCT=y
 # CONFIG_RESOURCE_COUNTERS is not set
 CONFIG_SYSFS_DEPRECATED=y
@@ -237,6 +235,7 @@ CONFIG_ARCH_HAS_WALK_MEMORY=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
 CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
+# CONFIG_PHYP_DUMP is not set
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_NUMA=y
 CONFIG_NODES_SHIFT=4
@@ -283,7 +282,7 @@ CONFIG_PCI_SYSCALL=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 CONFIG_PCI_MSI=y
-CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_DEBUG is not set
 # CONFIG_PCCARD is not set
 CONFIG_HOTPLUG_PCI=m
@@ -1519,6 +1518,7 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
 
 #
 # Kernel hacking
-- 
1.5.4.4

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
