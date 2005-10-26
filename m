Return-Path: <galak@freescale.com>
Date: Wed, 26 Oct 2005 09:56:39 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510260956110.6094@linen.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: only build idle_6xx for 6xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For the current time idle_6xx only applies to 6xx ppc32 CPUs

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit e19eaf379ab1a633eea2d5ff0e0d99ca834324f1
tree cf91db25a28f8f1d9d2426bc8b70c29d94aa249f
parent b6a4ce526a87bd8a99a396ac993240d6d3239852
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 26 Oct 2005 09:37:54 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 26 Oct 2005 09:37:54 -0500

 arch/powerpc/kernel/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -27,13 +27,14 @@ extra-$(CONFIG_40x)		:= head_4xx.o
 extra-$(CONFIG_44x)		:= head_44x.o
 extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
 extra-$(CONFIG_8xx)		:= head_8xx.o
+extra-$(CONFIG_6xx)		+= idle_6xx.o
 extra-$(CONFIG_PPC64)		+= entry_64.o
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
 extra-y				+= vmlinux.lds
 
 obj-y				+= process.o init_task.o time.o \
 				   prom.o systbl.o traps.o setup-common.o
-obj-$(CONFIG_PPC32)		+= entry_32.o idle_6xx.o setup_32.o misc_32.o
+obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o
 obj-$(CONFIG_PPC64)		+= setup_64.o misc_64.o
 obj-$(CONFIG_PPC_OF)		+= prom_init.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
