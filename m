Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id ACD87DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 02:46:04 +1100 (EST)
Date: Thu, 22 Nov 2007 08:46:03 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/10] powerpc: Cleanup CONFIG_KEXEC dependency
Message-ID: <20071122154603.GA26358@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071122154159.GA24711@xyzzy.farnsworth.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

KEXEC's dependency on PPC_PRPMC2800 is redundant, since PPC_MULTIPLATFORM
is now set for the prpmc2800 platform.  Remove the dependency.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
 arch/powerpc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 18f397c..191cc2c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -236,7 +236,7 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on (PPC_PRPMC2800 || PPC_MULTIPLATFORM) && EXPERIMENTAL
+	depends on PPC_MULTIPLATFORM && EXPERIMENTAL
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-- 
1.5.3.4
