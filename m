Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc: make POWER7 setup code generic name
Date: Wed, 31 Oct 2012 16:34:13 +1100
Message-Id: <1351661656-6986-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are going to reuse this in POWER8 so make the name generic.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/Makefile                       |    2 +-
 .../{cpu_setup_power7.S => cpu_setup_power.S}      |    0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/kernel/{cpu_setup_power7.S => cpu_setup_power.S} (100%)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index cde12f8..8f61934 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   paca.o nvram_64.o firmware.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power7.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
 obj-$(CONFIG_PPC_A2)		+= cpu_setup_a2.o
diff --git a/arch/powerpc/kernel/cpu_setup_power7.S b/arch/powerpc/kernel/cpu_setup_power.S
similarity index 100%
rename from arch/powerpc/kernel/cpu_setup_power7.S
rename to arch/powerpc/kernel/cpu_setup_power.S
-- 
1.7.9.5
