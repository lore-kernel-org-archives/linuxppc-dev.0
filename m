Return-Path: <bzolnier@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by ozlabs.org (Postfix) with ESMTP id 49EDFDE5CF
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 09:11:00 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so2639026fga.39
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 16:11:00 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 13 Jun 2008 01:12:43 +0200
Message-Id: <20080612231243.18335.14596.sendpatchset@localhost.localdomain>
In-Reply-To: <20080612231224.18335.91182.sendpatchset@localhost.localdomain>
References: <20080612231224.18335.91182.sendpatchset@localhost.localdomain>
Subject: [PATCH 3/7] ide-pmac: remove bogus comment about
	pmac_ide_setup_device()
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -975,10 +975,7 @@ static const struct ide_port_info pmac_p
 
 /*
  * Setup, register & probe an IDE channel driven by this driver, this is
- * called by one of the 2 probe functions (macio or PCI). Note that a channel
- * that ends up beeing free of any device is not kept around by this driver
- * (it is kept in 2.4). This introduce an interface numbering change on some
- * rare machines unfortunately, but it's better this way.
+ * called by one of the 2 probe functions (macio or PCI).
  */
 static int __devinit
 pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif, hw_regs_t *hw)
