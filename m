Return-Path: <segher@gcc12.fsffrance.org>
Received: from snail.fsffrance.org (eucd.info [88.191.250.43])
	by ozlabs.org (Postfix) with ESMTP id 2DE59DDEDE
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 08:58:57 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] ppc: Use ebony_defconfig for defconfig
Date: Wed,  7 May 2008 00:58:48 +0200
Message-Id: <cf74cd88187bdd9378fbb0a0ff7d53ac3a7b23d2.1210114487.git.segher@kernel.crashing.org>
In-Reply-To: <1210114730-5047-1-git-send-email-segher@kernel.crashing.org>
References: <1210114730-5047-1-git-send-email-segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We used to use common_defconfig, but it was removed some time ago.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/ppc/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
index 8df7f0e..2352d13 100644
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -43,7 +43,7 @@ KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)
 
 # Default to the common case.
-KBUILD_DEFCONFIG := common_defconfig
+KBUILD_DEFCONFIG := ebony_defconfig
 
 head-y				:= arch/ppc/kernel/head.o
 head-$(CONFIG_8xx)		:= arch/ppc/kernel/head_8xx.o
-- 
1.5.5.23.g2a5f.dirty
