Return-Path: <justinmattock@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 741F6B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Dec 2010 11:09:39 +1100 (EST)
Received: by gyg8 with SMTP id 8so4993197gyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 16:09:36 -0800 (PST)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: trivial@kernel.org
Subject: [PATCH 1/5]arch:powerpc:platforms:85xx:mpc85xx_mds.c Typo change
	singal to signal
Date: Thu, 30 Dec 2010 16:09:40 -0800
Message-Id: <1293754184-1928-1-git-send-email-justinmattock@gmail.com>
Cc: gregkh@suse.de, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	"Justin P. Mattock" <justinmattock@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patches below fixes a typo "singal" to "signal". Please let me 
know if anything needs to be changed.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index aa34cac..747d1ee 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -309,7 +309,7 @@ static void __init mpc85xx_mds_qe_init(void)
 			/* P1021 has pins muxed for QE and other functions. To
 			 * enable QE UEC mode, we need to set bit QE0 for UCC1
 			 * in Eth mode, QE0 and QE3 for UCC5 in Eth mode, QE9
-			 * and QE12 for QE MII management singals in PMUXCR
+			 * and QE12 for QE MII management signals in PMUXCR
 			 * register.
 			 */
 				setbits32(pmuxcr, MPC85xx_PMUXCR_QE0 |
-- 
1.6.5.2.180.gc5b3e
