Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46D8A1A0027
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 01:44:37 +1000 (EST)
From: Michal Marek <mmarek@suse.cz>
To: sfr@canb.auug.org.au,
	rdunlap@infradead.org,
	davem@davemloft.net
Subject: [PATCH 3/5] powerpc: Set CONFIG_NET=y in defconfigs
Date: Tue, 23 Sep 2014 17:44:02 +0200
Message-Id: <1411487044-14071-3-git-send-email-mmarek@suse.cz>
In-Reply-To: <1411487044-14071-1-git-send-email-mmarek@suse.cz>
References: <54218AEF.5090200@suse.cz>
 <1411487044-14071-1-git-send-email-mmarek@suse.cz>
Cc: netdev@vger.kernel.org, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 5d6be6a5 ("scsi_netlink : Make SCSI_NETLINK dependent on NET
instead of selecting NET") removed what happened to be the only instance
of 'select NET'. Defconfigs that were relying on the select now lack
networking support.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Michal Marek <mmarek@suse.cz>
---
 arch/powerpc/configs/pmac32_defconfig     | 1 +
 arch/powerpc/configs/ppc64_defconfig      | 1 +
 arch/powerpc/configs/ppc64e_defconfig     | 1 +
 arch/powerpc/configs/pseries_defconfig    | 1 +
 arch/powerpc/configs/pseries_le_defconfig | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index 553e662..0351b5f 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -31,6 +31,7 @@ CONFIG_HIBERNATION=y
 CONFIG_APM_EMULATION=y
 CONFIG_PCCARD=m
 CONFIG_YENTA=m
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index f6c02f8..3651887 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -58,6 +58,7 @@ CONFIG_ELECTRA_CF=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_RPA=m
 CONFIG_HOTPLUG_PCI_RPA_DLPAR=m
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=m
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index 587f551..c3a3269 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -33,6 +33,7 @@ CONFIG_SPARSEMEM_MANUAL=y
 CONFIG_PCI_MSI=y
 CONFIG_PCCARD=y
 CONFIG_HOTPLUG_PCI=y
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=m
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 50375f1..dd2a9ca 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -53,6 +53,7 @@ CONFIG_SCHED_SMT=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_RPA=m
 CONFIG_HOTPLUG_PCI_RPA_DLPAR=m
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=m
diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/configs/pseries_le_defconfig
index 4428ee4..63392f4 100644
--- a/arch/powerpc/configs/pseries_le_defconfig
+++ b/arch/powerpc/configs/pseries_le_defconfig
@@ -55,6 +55,7 @@ CONFIG_SCHED_SMT=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_RPA=m
 CONFIG_HOTPLUG_PCI_RPA_DLPAR=m
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=m
-- 
1.8.4.5
