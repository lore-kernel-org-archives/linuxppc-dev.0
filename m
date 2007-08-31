Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id E8E5DDDE9E
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 13:37:18 +1000 (EST)
Date: Fri, 31 Aug 2007 13:37:18 +1000
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] Remove unused variables in driver/ide/ppc/pmac.c
Message-ID: <20070831033718.GO10345@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixes:
  CC [M]  drivers/ide/ppc/pmac.o
/scratch/tony/tmp/drivers/ide/ppc/pmac.c: In function 'pmac_ide_dma_check':
/scratch/tony/tmp/drivers/ide/ppc/pmac.c:1815: warning: unused variable 'map'
/scratch/tony/tmp/drivers/ide/ppc/pmac.c:1813: warning: unused variable 'pmif'

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
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
1.5.2.5

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
