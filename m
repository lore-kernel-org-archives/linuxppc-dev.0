Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 977AADDFDA
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 02:18:10 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so310705yxg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 09:18:09 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by terra with esmtp (Exim 4.69) (envelope-from <jonsmirl@gmail.com>)
	id 1KKarQ-0002jE-Bu
	for linuxppc-dev@ozlabs.org; Sun, 20 Jul 2008 11:30:08 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Remove fsl-soc.c from mpc5200 build, it is not needed.
To: linuxppc-dev@ozlabs.org
Date: Sun, 20 Jul 2008 11:30:08 -0400
Message-ID: <20080720153008.10459.57753.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove fsl-soc.c from mpc5200 build, it is not needed.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 arch/powerpc/platforms/52xx/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index e91a0d2..76a3411 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -1,7 +1,6 @@
 config PPC_MPC52xx
 	bool "52xx-based boards"
 	depends on PPC_MULTIPLATFORM && PPC32
-	select FSL_SOC
 	select PPC_CLOCK
 
 config PPC_MPC5200_SIMPLE
