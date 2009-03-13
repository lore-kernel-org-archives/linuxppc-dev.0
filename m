Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <aab60b994b0b9a8f1ec96a97af8712feda86666d.1236923542.git.michael@ellerman.id.au>
In-Reply-To: <fc1755dacb01bff52fcf77ee18c4d7a075b01c37.1236923542.git.michael@ellerman.id.au>
References: <fc1755dacb01bff52fcf77ee18c4d7a075b01c37.1236923542.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/2] powerpc: Turn on self-tests in ppc64_defconfig
Date: Fri, 13 Mar 2009 16:52:47 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Most of the code enabled by these options is __init, and it's much
more useful to actually run the tests.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/configs/ppc64_defconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 88c6295..2524018 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -2067,9 +2067,9 @@ CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DEBUG_STACK_USAGE=y
 # CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_HCALL_STATS is not set
-# CONFIG_CODE_PATCHING_SELFTEST is not set
-# CONFIG_FTR_FIXUP_SELFTEST is not set
-# CONFIG_MSI_BITMAP_SELFTEST is not set
+CONFIG_CODE_PATCHING_SELFTEST=y
+CONFIG_FTR_FIXUP_SELFTEST=y
+CONFIG_MSI_BITMAP_SELFTEST=y
 CONFIG_XMON=y
 # CONFIG_XMON_DEFAULT is not set
 CONFIG_XMON_DISASSEMBLY=y
-- 
1.6.1.2
