Return-Path: <sfr@canb.auug.org.au>
Date: Thu, 15 Sep 2005 16:04:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050915160430.550d02ed.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: don't execute a temporary comment
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/ppc/Makefile   |    2 +-
 arch/ppc64/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

86f7688825b1f1e6fa4c43bce001b2a232f7d1bc
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -102,9 +102,9 @@ define archhelp
   @echo '  *_defconfig     - Select default config from arch/$(ARCH)/ppc/configs'
 endef
 
+# arch/$(ARCH)/include is a temporary hack until we have migrated to asm-powerpc
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/ppc/boot
-	# Temporary hack until we have migrated to asm-powerpc
 	$(Q)rm -rf arch/$(ARCH)/include
 
 archprepare: checkbin
diff --git a/arch/ppc64/Makefile b/arch/ppc64/Makefile
--- a/arch/ppc64/Makefile
+++ b/arch/ppc64/Makefile
@@ -113,9 +113,9 @@ defaultimage-$(CONFIG_PPC_ISERIES) := vm
 KBUILD_IMAGE := $(defaultimage-y)
 all: $(KBUILD_IMAGE)
 
+# arch/$(ARCH)/include is a temporary hack until we have migrated to asm-powerpc
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
-	# Temporary hack until we have migrated to asm-powerpc
 	$(Q)rm -rf arch/$(ARCH)/include
 
 
