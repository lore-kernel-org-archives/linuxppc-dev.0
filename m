Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 44078DDDE9
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 01:41:28 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ide/ppc/pmac: Remove a few unused variables
Date: Wed,  1 Aug 2007 17:41:16 +0200
Message-Id: <11859828801254-git-send-email-segher@kernel.crashing.org>
In-Reply-To: <11859828792347-git-send-email-segher@kernel.crashing.org>
References: <11859828761541-git-send-email-segher@kernel.crashing.org>
	<11859828781513-git-send-email-segher@kernel.crashing.org>
	<11859828792347-git-send-email-segher@kernel.crashing.org>
Message-Id: <a2e1409163c00627f53c305f28b6d5feb530d96c.1185982424.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 drivers/ide/ppc/pmac.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index 33630ad..0f5a6b4 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1810,9 +1810,7 @@ pmac_ide_dma_check(ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
 	ide_hwif_t *hwif = HWIF(drive);
-	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
 	int enable = 1;
-	int map;
 	drive->using_dma = 0;
 	
 	if (drive->media == ide_floppy)
-- 
1.5.2.1.144.gabc40-dirty
