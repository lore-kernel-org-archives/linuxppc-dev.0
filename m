Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 14/16] powerpc: Add config option for transactional memory
Date: Tue, 27 Nov 2012 13:48:06 +1100
Message-Id: <1353984488-1283-15-git-send-email-mikey@neuling.org>
In-Reply-To: <1353984488-1283-1-git-send-email-mikey@neuling.org>
References: <1353984488-1283-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kconfig option for transactional memory on powerpc.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/Kconfig |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a902a5c..ece67ca 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -308,6 +308,14 @@ config MATH_EMULATION
 	  unit, which will allow programs that use floating-point
 	  instructions to run.
 
+config TRANSACTIONAL_MEM
+       bool "Transactional Memory support"
+       depends on PPC64
+       depends on SMP
+       default n
+       ---help---
+         Support user-mode Transactional Memory.
+
 config 8XX_MINIMAL_FPEMU
 	bool "Minimal math emulation for 8xx"
 	depends on 8xx && !MATH_EMULATION
-- 
1.7.9.5
