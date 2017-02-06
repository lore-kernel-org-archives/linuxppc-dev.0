Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGsXy3qn0zDqDv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 13:55:46 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Michael Neuling <mikey@neuling.org>
Subject: [PATCH 2/2] powerpc/powernv: Add more BPF in defconfig
Date: Mon,  6 Feb 2017 13:55:44 +1100
Message-Id: <20170206025544.3292-2-mikey@neuling.org>
In-Reply-To: <20170206025544.3292-1-mikey@neuling.org>
References: <20170206025544.3292-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables BCC (https://github.com/iovisor/bcc) on powernv.

This adds 225KB to the vmlinux size.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/configs/powernv_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 7028dbc753..911b43e2c7 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -29,6 +29,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_PERF=y
 CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_BPF_SYSCALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
@@ -79,6 +80,10 @@ CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
+CONFIG_NET_SCHED=y
+CONFIG_NET_CLS_BPF=y
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_ACT_BPF=y
 CONFIG_BPF_JIT=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
-- 
2.9.3
