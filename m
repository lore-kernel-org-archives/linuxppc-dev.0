Return-Path: <kim.phillips@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6A8A1DDF91
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 11:28:49 +1100 (EST)
Date: Fri, 25 Jan 2008 11:38:12 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/9] enable FSL SATA driver config for Freescale SoCs
Message-Id: <20080125113812.ddf89c3f.kim.phillips@freescale.com>
In-Reply-To: <089EA00D-8EAB-417D-9A4B-FA500D23FF8D@kernel.crashing.org>
References: <20080124204621.2c09359e.kim.phillips@freescale.com>
	<089EA00D-8EAB-417D-9A4B-FA500D23FF8D@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, jgarzik@pobox.com,
	Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 25 Jan 2008 10:04:08 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Jan 24, 2008, at 8:46 PM, Kim Phillips wrote:
> 
> > The mpc8315 shares the same SATA controller as the mpc837x,
> > and likelihood is that future SoCs from Freescale will also.
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> > ---
> > Kumar, let me know if you want me to post this to the ata list (I'm
> > assuming it's not necessary).
> 
> It is necessary so they are aware.  CC jgarizk, but we'll take it via  
> powerpc.
> 
> - k
> 
ok, cc'ing Jeff, linux-ide here:

From: Kim Phillips <kim.phillips@freescale.com>
Date: Thu, 24 Jan 2008 01:49:24 -0600
Subject: [PATCH] enable FSL SATA driver config for Freescale SoCs

The mpc8315 shares the same SATA controller as the mpc837x,
and likelihood is that future SoCs from Freescale will also.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
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
