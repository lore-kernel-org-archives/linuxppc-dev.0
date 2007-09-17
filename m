Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EA9C1DDDF5
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 14:06:51 +1000 (EST)
Date: Mon, 17 Sep 2007 14:06:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Remove unused variabls from drivers/ide/ppc/pmac.c
Message-Id: <20070917140644.f62abe1e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removes these warnings:

/home/sfr/kernels/linus/drivers/ide/ppc/pmac.c: In function 'pmac_ide_dma_check':
/home/sfr/kernels/linus/drivers/ide/ppc/pmac.c:1807: warning: unused variable 'map'
/home/sfr/kernels/linus/drivers/ide/ppc/pmac.c:1805: warning: unused variable 'pmif'

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/ide/ppc/pmac.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index 4b13cd9..f19eb6d 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1802,9 +1802,7 @@ pmac_ide_dma_check(ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
 	ide_hwif_t *hwif = HWIF(drive);
-	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
 	int enable = 1;
-	int map;
 	drive->using_dma = 0;
 	
 	if (drive->media == ide_floppy)
-- 
1.5.3.1
