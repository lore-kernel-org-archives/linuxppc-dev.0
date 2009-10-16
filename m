Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2578B7F43
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 04:21:50 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] powerpc: cleanup init/Kconfig
Date: Fri, 16 Oct 2009 12:21:37 -0500
Message-Id: <1255713699-21852-4-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1255713699-21852-3-git-send-email-galak@kernel.crashing.org>
References: <1255713699-21852-1-git-send-email-galak@kernel.crashing.org>
	<1255713699-21852-2-git-send-email-galak@kernel.crashing.org>
	<1255713699-21852-3-git-send-email-galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We dont need to depend on PPC64 explicitly as all powerpc platforms
(32-bit and 64-bit) define PPC now.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 init/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 09c5c64..f515864 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -297,7 +297,7 @@ config AUDIT
 
 config AUDITSYSCALL
 	bool "Enable system-call auditing support"
-	depends on AUDIT && (X86 || PPC || PPC64 || S390 || IA64 || UML || SPARC64|| SUPERH)
+	depends on AUDIT && (X86 || PPC || S390 || IA64 || UML || SPARC64 || SUPERH)
 	default y if SECURITY_SELINUX
 	help
 	  Enable low-overhead system-call auditing infrastructure that
-- 
1.6.0.6
