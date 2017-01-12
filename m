Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzhXL2NZ0zDqG4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 21:17:38 +1100 (AEDT)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/64: Add BPF_JIT to powernv and pseries defconfigs
Date: Thu, 12 Jan 2017 21:17:34 +1100
Message-Id: <20170112101734.5608-2-anton@ozlabs.org>
In-Reply-To: <20170112101734.5608-1-anton@ozlabs.org>
References: <20170112101734.5608-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

Commit db9112173b18 ("powerpc: Turn on BPF_JIT in ppc64_defconfig")
only added BPF_JIT to the ppc64 defconfig. Add it to our powernv
and pseries defconfigs too.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/powernv_defconfig | 1 +
 arch/powerpc/configs/pseries_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index e4d53fe..b793550 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -79,6 +79,7 @@ CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
+CONFIG_BPF_JIT=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 5a06bdd..d99734f 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -82,6 +82,7 @@ CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
+CONFIG_BPF_JIT=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-- 
2.9.3
