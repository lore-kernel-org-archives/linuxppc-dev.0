Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 22E2AB7C0A
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 04:21:45 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] powerpc: Limit hugetlbfs support to PPC64 Book-3S machines
Date: Fri, 16 Oct 2009 12:21:35 -0500
Message-Id: <1255713699-21852-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1255713699-21852-1-git-send-email-galak@kernel.crashing.org>
References: <1255713699-21852-1-git-send-email-galak@kernel.crashing.org>
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
 fs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index d4bf8ca..f93d0ed 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -135,7 +135,7 @@ config TMPFS_POSIX_ACL
 
 config HUGETLBFS
 	bool "HugeTLB file system support"
-	depends on X86 || IA64 || PPC64 || SPARC64 || (SUPERH && MMU) || \
+	depends on X86 || IA64 || PPC_BOOK3S_64 || SPARC64 || (SUPERH && MMU) || \
 		   (S390 && 64BIT) || SYS_SUPPORTS_HUGETLBFS || BROKEN
 	help
 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
-- 
1.6.0.6
