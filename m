Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 1711C67CAF
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 04:24:57 +1100 (EST)
Date: Tue, 14 Nov 2006 18:19:01 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] set default video mode on PowerBook Wallstreet
Message-ID: <20061114171901.GA25588@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


finally add the third PowerBook Wallstreet 233MHz model to the list of
known display resolutions. 
Without this change, a 640x480 video mode is used.
A workaround so far was to boot with 'video=atyfb:vmode:14'

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/video/aty/atyfb_base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.18.orig/drivers/video/aty/atyfb_base.c
+++ linux-2.6.18/drivers/video/aty/atyfb_base.c
@@ -409,7 +409,7 @@ static struct {
 	{ PCI_CHIP_MACH64LB, "3D RAGE LT PRO (Mach64 LB, AGP)", 236, 75, 100, 135, ATI_CHIP_264LTPRO },
 	{ PCI_CHIP_MACH64LD, "3D RAGE LT PRO (Mach64 LD, AGP)", 230, 100, 100, 135, ATI_CHIP_264LTPRO },
 	{ PCI_CHIP_MACH64LI, "3D RAGE LT PRO (Mach64 LI, PCI)", 230, 100, 100, 135, ATI_CHIP_264LTPRO | M64F_G3_PB_1_1 | M64F_G3_PB_1024x768 },
-	{ PCI_CHIP_MACH64LP, "3D RAGE LT PRO (Mach64 LP, PCI)", 230, 100, 100, 135, ATI_CHIP_264LTPRO },
+	{ PCI_CHIP_MACH64LP, "3D RAGE LT PRO (Mach64 LP, PCI)", 230, 100, 100, 135, ATI_CHIP_264LTPRO | M64F_G3_PB_1024x768 },
 	{ PCI_CHIP_MACH64LQ, "3D RAGE LT PRO (Mach64 LQ, PCI)", 230, 100, 100, 135, ATI_CHIP_264LTPRO },
 
 	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP 2x)", 230, 83, 63, 135, ATI_CHIP_264XL },
