Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7081CB7F37
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 04:21:48 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] powerpc: Limit memory hotplug support to PPC64 Book-3S
	machines
Date: Fri, 16 Oct 2009 12:21:36 -0500
Message-Id: <1255713699-21852-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1255713699-21852-2-git-send-email-galak@kernel.crashing.org>
References: <1255713699-21852-1-git-send-email-galak@kernel.crashing.org>
	<1255713699-21852-2-git-send-email-galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 mm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 57963c6..7ca3777 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -129,7 +129,7 @@ config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
 	depends on SPARSEMEM || X86_64_ACPI_NUMA
 	depends on HOTPLUG && !(HIBERNATION && !S390) && ARCH_ENABLE_MEMORY_HOTPLUG
-	depends on (IA64 || X86 || PPC64 || SUPERH || S390)
+	depends on (IA64 || X86 || PPC_BOOK3S_64 || SUPERH || S390)
 
 comment "Memory hotplug is currently incompatible with Software Suspend"
 	depends on SPARSEMEM && HOTPLUG && HIBERNATION && !S390
-- 
1.6.0.6
