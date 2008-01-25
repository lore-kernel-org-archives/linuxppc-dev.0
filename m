Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 977AADDF2F
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 13:46:30 +1100 (EST)
Date: Thu, 24 Jan 2008 20:46:21 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 4/9] enable FSL SATA driver config for Freescale SoCs
Message-Id: <20080124204621.2c09359e.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The mpc8315 shares the same SATA controller as the mpc837x,
and likelihood is that future SoCs from Freescale will also.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
Kumar, let me know if you want me to post this to the ata list (I'm
assuming it's not necessary).

 drivers/ata/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 64b4964..75939dd 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -184,7 +184,7 @@ config PATA_ACPI
 
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
-	depends on PPC_MPC837x
+	depends on FSL_SOC
 	help
 	  This option enables support for Freescale 3.0Gbps SATA controller.
 	  It can be found on MPC837x and MPC8315.
-- 
1.5.2.2
