Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_75_100,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE19C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 09:23:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FFF20663
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 09:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FFF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433M0l3nDRzDqS2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:23:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433LwQ0TZwzDqQg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 20:19:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 433LwP6p09z9s3C; Mon, 26 Nov 2018 20:19:49 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 433LwP6N3nz9s3q; Mon, 26 Nov 2018 20:19:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/configs: Update ppc64_defconfig with savedefconfig
Date: Mon, 26 Nov 2018 20:19:44 +1100
Message-Id: <20181126091944.21893-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181126091944.21893-1-mpe@ellerman.id.au>
References: <20181126091944.21893-1-mpe@ellerman.id.au>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Update ppc64_defconfig with savedefconfig. No symbols are added or
removed, this is 100% movement.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/ppc64_defconfig | 68 ++++++++++++++--------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 6cdf034e8625..860a3a72b559 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -1,4 +1,3 @@
-CONFIG_PPC64=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ=y
@@ -16,14 +15,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_BPF_SYSCALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=m
-CONFIG_KPROBES=y
-CONFIG_JUMP_LABEL=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_PARTITION_ADVANCED=y
+CONFIG_PPC64=y
 CONFIG_PPC_SPLPAR=y
 CONFIG_DTL=y
 CONFIG_SCANLOG=m
@@ -45,14 +37,11 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_CPU_FREQ_PMAC64=y
 CONFIG_HZ_100=y
-CONFIG_BINFMT_MISC=m
 CONFIG_PPC_TRANSACTIONAL_MEM=y
 CONFIG_KEXEC=y
 CONFIG_KEXEC_FILE=y
 CONFIG_CRASH_DUMP=y
 CONFIG_IRQ_ALL_CPUS=y
-CONFIG_KSM=y
-CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_PPC_64K_PAGES=y
 CONFIG_SCHED_SMT=y
 CONFIG_HOTPLUG_PCI=y
@@ -60,6 +49,21 @@ CONFIG_HOTPLUG_PCI_RPA=m
 CONFIG_HOTPLUG_PCI_RPA_DLPAR=m
 CONFIG_PCCARD=y
 CONFIG_ELECTRA_CF=y
+CONFIG_VIRTUALIZATION=y
+CONFIG_KVM_BOOK3S_64=m
+CONFIG_KVM_BOOK3S_64_HV=m
+CONFIG_VHOST_NET=m
+CONFIG_OPROFILE=m
+CONFIG_KPROBES=y
+CONFIG_JUMP_LABEL=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BINFMT_MISC=m
+CONFIG_KSM=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -163,7 +167,6 @@ CONFIG_TIGON3=y
 CONFIG_BNX2X=m
 CONFIG_CHELSIO_T1=m
 CONFIG_BE2NET=m
-CONFIG_S2IO=m
 CONFIG_IBMVETH=m
 CONFIG_EHEA=m
 CONFIG_E100=y
@@ -174,6 +177,7 @@ CONFIG_IXGBE=m
 CONFIG_I40E=m
 CONFIG_MLX4_EN=m
 CONFIG_MYRI10GE=m
+CONFIG_S2IO=m
 CONFIG_PASEMI_MAC=y
 CONFIG_QLGE=m
 CONFIG_NETXEN_NIC=m
@@ -323,23 +327,6 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_STACK_USAGE=y
-CONFIG_DEBUG_STACKOVERFLOW=y
-CONFIG_SOFTLOCKUP_DETECTOR=y
-CONFIG_HARDLOCKUP_DETECTOR=y
-CONFIG_DEBUG_MUTEXES=y
-CONFIG_LATENCYTOP=y
-CONFIG_FUNCTION_TRACER=y
-CONFIG_SCHED_TRACER=y
-CONFIG_BLK_DEV_IO_TRACE=y
-CONFIG_CODE_PATCHING_SELFTEST=y
-CONFIG_FTR_FIXUP_SELFTEST=y
-CONFIG_MSI_BITMAP_SELFTEST=y
-CONFIG_XMON=y
-CONFIG_BOOTX_TEXT=y
-CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
@@ -362,8 +349,21 @@ CONFIG_CRYPTO_LZO=m
 CONFIG_CRYPTO_DEV_NX=y
 CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
 CONFIG_CRYPTO_DEV_VMX=y
-CONFIG_VIRTUALIZATION=y
-CONFIG_KVM_BOOK3S_64=m
-CONFIG_KVM_BOOK3S_64_HV=m
-CONFIG_VHOST_NET=m
 CONFIG_PRINTK_TIME=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_STACK_USAGE=y
+CONFIG_DEBUG_STACKOVERFLOW=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_HARDLOCKUP_DETECTOR=y
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_LATENCYTOP=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_SCHED_TRACER=y
+CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_CODE_PATCHING_SELFTEST=y
+CONFIG_FTR_FIXUP_SELFTEST=y
+CONFIG_MSI_BITMAP_SELFTEST=y
+CONFIG_XMON=y
+CONFIG_BOOTX_TEXT=y
+CONFIG_PPC_EARLY_DEBUG=y
-- 
2.17.2

