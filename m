Return-Path: <anton@ozlabs.org>
Date: Wed, 1 Apr 2009 17:14:25 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: powerpc: Enable relay in pseries_defconfig
Message-ID: <20090401061425.GF27084@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Enable relay in pseries config, ppc64_defconfig had it enabled but pseries
did not.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 61b1008..f1889ab 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -95,7 +95,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_PROC_PID_CPUSET=y
-# CONFIG_RELAY is not set
+CONFIG_RELAY=y
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_IPC_NS is not set
