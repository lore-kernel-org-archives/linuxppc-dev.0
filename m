Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f956d1f05ce70c71705d1e04d98e2c549d79dd14.1235446849.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Remove unused asm-offsets entries for cpu_spec
Date: Tue, 24 Feb 2009 14:40:56 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/asm-offsets.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9937fe4..addac07 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -280,9 +280,6 @@ int main(void)
 #endif /* ! CONFIG_PPC64 */
 
 	/* About the CPU features table */
-	DEFINE(CPU_SPEC_ENTRY_SIZE, sizeof(struct cpu_spec));
-	DEFINE(CPU_SPEC_PVR_MASK, offsetof(struct cpu_spec, pvr_mask));
-	DEFINE(CPU_SPEC_PVR_VALUE, offsetof(struct cpu_spec, pvr_value));
 	DEFINE(CPU_SPEC_FEATURES, offsetof(struct cpu_spec, cpu_features));
 	DEFINE(CPU_SPEC_SETUP, offsetof(struct cpu_spec, cpu_setup));
 	DEFINE(CPU_SPEC_RESTORE, offsetof(struct cpu_spec, cpu_restore));
-- 
1.5.5
