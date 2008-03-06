Return-Path: <gvb.linuxppc.dev@cgmail.com>
Received: from QMTA06.westchester.pa.mail.comcast.net
	(qmta06.westchester.pa.mail.comcast.net [76.96.62.56])
	by ozlabs.org (Postfix) with ESMTP id 010DADDF05
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 11:38:54 +1100 (EST)
Date: Wed, 5 Mar 2008 19:33:16 -0500
From: Gerald Van Baren <gvb.linuxppc.dev@cgmail.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH] The MPC83xx family doesn't support performance monitor
	instructions
Message-ID: <20080306003316.GA14068@cideas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"Errata to MPC8349EA PowerQUICC[tm] II Pro Integrated Host Processor Family
Reference Manual, Rev. 1" (Freescale)

Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
---

Hi Kumar,

Please apply this fix to 2.6.25rc4 if possible.  Without this
patch, the PPC_83xx family configuration is broken (will not compile).

 arch/powerpc/platforms/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 0afd225..a578b96 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -22,7 +22,6 @@ config PPC_83xx
 	select FSL_SOC
 	select MPC83xx
 	select IPIC
-	select FSL_EMB_PERFMON
 
 config PPC_86xx
 	bool "Freescale 86xx"
-- 
1.5.4.1
