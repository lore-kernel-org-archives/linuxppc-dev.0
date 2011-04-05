Return-Path: <justinmattock@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C384FB6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 02:58:52 +1000 (EST)
Received: by pwi9 with SMTP id 9so259052pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Apr 2011 09:58:49 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: trivial@kernel.org
Subject: [RFC 2/5]arch:powerpc:sysdev:Makefile Remove unused config in the
	Makefile.
Date: Tue,  5 Apr 2011 09:58:19 -0700
Message-Id: <1302022702-24541-2-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1302022702-24541-1-git-send-email-justinmattock@gmail.com>
References: <1302022702-24541-1-git-send-email-justinmattock@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	"Justin P. Mattock" <justinmattock@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch below removes an unused config variable found by using a kernel
cleanup script.
Note: I did try to cross compile these but hit erros while doing so..
(gcc is not setup to cross compile) and am unsure if anymore needs to be done.
Please have a look if/when anybody has free time.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org

---
 arch/powerpc/sysdev/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 1e0c933..243b6ad 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_FSL_PMC)		+= fsl_pmc.o
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
 obj-$(CONFIG_MPC8xxx_GPIO)	+= mpc8xxx_gpio.o
-obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+= fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o
 obj-$(CONFIG_SIMPLE_GPIO)	+= simple_gpio.o
 obj-$(CONFIG_FSL_RIO)		+= fsl_rio.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
-- 
1.7.4.2
