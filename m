Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 16/17] powerpc: Add transactional memory to pseries and ppc64
 defconfigs
Date: Fri, 18 Jan 2013 16:48:36 +1100
Message-Id: <1358488117-17363-17-git-send-email-mikey@neuling.org>
In-Reply-To: <1358488117-17363-1-git-send-email-mikey@neuling.org>
References: <1358488117-17363-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/configs/ppc64_defconfig   |    2 ++
 arch/powerpc/configs/pseries_defconfig |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 6cbdeb4..01e2e86 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -49,6 +49,8 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_PMAC64=y
 CONFIG_HZ_100=y
 CONFIG_BINFMT_MISC=m
+CONFIG_TRANSACTIONAL_MEM=y
+CONFIG_HOTPLUG_CPU=y
 CONFIG_KEXEC=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_MEMORY_HOTREMOVE=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 04fa7f2..a50484f 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -43,6 +43,8 @@ CONFIG_RTAS_FLASH=m
 CONFIG_IBMEBUS=y
 CONFIG_HZ_100=y
 CONFIG_BINFMT_MISC=m
+CONFIG_TRANSACTIONAL_MEM=y
+CONFIG_HOTPLUG_CPU=y
 CONFIG_KEXEC=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_MEMORY_HOTPLUG=y
-- 
1.7.10.4
