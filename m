Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BD7A1A0029
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Oct 2014 20:17:35 +1100 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: sync pseries_le_defconfig with pseries_defconfig
Date: Mon, 13 Oct 2014 20:17:33 +1100
Message-Id: <1413191853-2095-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now KVM is working on LE, enable it. Also enable transarent
hugepage which has already been enabled on BE.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/pseries_le_defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/configs/pseries_le_defconfig
index 4428ee4..96a230c 100644
--- a/arch/powerpc/configs/pseries_le_defconfig
+++ b/arch/powerpc/configs/pseries_le_defconfig
@@ -48,7 +48,6 @@ CONFIG_KEXEC=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
-CONFIG_CMA=y
 CONFIG_PPC_64K_PAGES=y
 CONFIG_PPC_SUBPAGE_PROT=y
 CONFIG_SCHED_SMT=y
@@ -137,6 +136,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_NETPOLL_TRAP=y
 CONFIG_TUN=m
 CONFIG_VIRTIO_NET=m
+CONFIG_VHOST_NET=m
 CONFIG_VORTEX=y
 CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
@@ -302,4 +302,9 @@ CONFIG_CRYPTO_LZO=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_NX=y
 CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
+CONFIG_VIRTUALIZATION=y
+CONFIG_KVM_BOOK3S_64=m
+CONFIG_KVM_BOOK3S_64_HV=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
-- 
1.9.1
