Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C53A1DDE43
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 07:56:45 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l9ILuelk030477
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 16:56:41 -0500
Date: Thu, 18 Oct 2007 16:55:59 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] powerpc: Add -mno-spe for ARCH=powerpc builds
Message-ID: <Pine.LNX.4.64.0710181655270.28684@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 4e16534..bd87626 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -107,6 +107,9 @@ endif
 # No AltiVec instruction when building kernel
 KBUILD_CFLAGS += $(call cc-option,-mno-altivec)

+# No SPE instruction when building kernel
+KBUILD_CFLAGS += $(call cc-option,-mno-spe)
+
 # Enable unit-at-a-time mode when possible. It shrinks the
 # kernel considerably.
 KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
-- 
1.5.2.4
