Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <3c7d6d2c5c99a226535215b2658c74a1e38c1174.1240450296.git.michael@ellerman.id.au>
In-Reply-To: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
References: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 6/6] powerpc: We don't need __do_IRQ() anymore
Date: Thu, 23 Apr 2009 11:31:45 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So select GENERIC_HARDIRQS_NO__DO_IRQ to disable it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4c78045..3ba167a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -42,6 +42,10 @@ config GENERIC_HARDIRQS
 	bool
 	default y
 
+config GENERIC_HARDIRQS_NO__DO_IRQ
+	bool
+	default y
+
 config HAVE_SETUP_PER_CPU_AREA
 	def_bool PPC64
 
-- 
1.6.2.1
