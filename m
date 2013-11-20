Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 Ulrich.Weigand@de.ibm.com, alistair@popple.id.au
Subject: [PATCH 8/9] powerpc: Add CONFIG_CPU_LITTLE_ENDIAN kernel config
 option.
Date: Wed, 20 Nov 2013 22:15:05 +1100
Message-Id: <1384946106-18200-9-git-send-email-anton@samba.org>
In-Reply-To: <1384946106-18200-1-git-send-email-anton@samba.org>
References: <1384946106-18200-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the little endian support merged, we can add the
CONFIG_CPU_LITTLE_ENDIAN kernel config option.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/Kconfig.cputype | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index c2a566f..132f872 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -403,3 +403,14 @@ config PPC_DOORBELL
 	default n
 
 endmenu
+
+config CPU_LITTLE_ENDIAN
+	bool "Build little endian kernel"
+	default n
+	help
+	  This option selects whether a big endian or little endian kernel will
+	  be built.
+
+	  Note that if cross compiling a little endian kernel,
+	  CROSS_COMPILE must point to a toolchain capable of targeting
+	  little endian powerpc.
-- 
1.8.3.2
