Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CB542DE175
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 21:22:15 +1000 (EST)
Date: Wed, 12 Sep 2007 15:25:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] ucc_fast: fix debug output
Message-ID: <20070912112521.GC15556@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur, want to take this along with your qe_lib cleanup queue?

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/ucc_fast.c |   40 ++++++++++++++++----------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
index 3df202e..ab4b3cf 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -30,45 +30,45 @@
 
 void ucc_fast_dump_regs(struct ucc_fast_private * uccf)
 {
-	printk(KERN_INFO "UCC%d Fast registers:", uccf->uf_info->ucc_num);
-	printk(KERN_INFO "Base address: 0x%08x", (u32) uccf->uf_regs);
+	printk(KERN_INFO "UCC%d Fast registers:\n", uccf->uf_info->ucc_num);
+	printk(KERN_INFO "Base address: 0x%08x\n", (u32) uccf->uf_regs);
 
-	printk(KERN_INFO "gumr  : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "gumr  : addr - 0x%08x, val - 0x%08x\n",
 		  (u32) & uccf->uf_regs->gumr, in_be32(&uccf->uf_regs->gumr));
-	printk(KERN_INFO "upsmr : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "upsmr : addr - 0x%08x, val - 0x%08x\n",
 		  (u32) & uccf->uf_regs->upsmr, in_be32(&uccf->uf_regs->upsmr));
-	printk(KERN_INFO "utodr : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "utodr : addr - 0x%08x, val - 0x%04x\n",
 		  (u32) & uccf->uf_regs->utodr, in_be16(&uccf->uf_regs->utodr));
-	printk(KERN_INFO "udsr  : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "udsr  : addr - 0x%08x, val - 0x%04x\n",
 		  (u32) & uccf->uf_regs->udsr, in_be16(&uccf->uf_regs->udsr));
-	printk(KERN_INFO "ucce  : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "ucce  : addr - 0x%08x, val - 0x%08x\n",
 		  (u32) & uccf->uf_regs->ucce, in_be32(&uccf->uf_regs->ucce));
-	printk(KERN_INFO "uccm  : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "uccm  : addr - 0x%08x, val - 0x%08x\n",
 		  (u32) & uccf->uf_regs->uccm, in_be32(&uccf->uf_regs->uccm));
-	printk(KERN_INFO "uccs  : addr - 0x%08x, val - 0x%02x",
+	printk(KERN_INFO "uccs  : addr - 0x%08x, val - 0x%02x\n",
 		  (u32) & uccf->uf_regs->uccs, uccf->uf_regs->uccs);
-	printk(KERN_INFO "urfb  : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "urfb  : addr - 0x%08x, val - 0x%08x\n",
 		  (u32) & uccf->uf_regs->urfb, in_be32(&uccf->uf_regs->urfb));
-	printk(KERN_INFO "urfs  : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "urfs  : addr - 0x%08x, val - 0x%04x\n",
 		  (u32) & uccf->uf_regs->urfs, in_be16(&uccf->uf_regs->urfs));
-	printk(KERN_INFO "urfet : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "urfet : addr - 0x%08x, val - 0x%04x\n",
 		  (u32) & uccf->uf_regs->urfet, in_be16(&uccf->uf_regs->urfet));
-	printk(KERN_INFO "urfset: addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "urfset: addr - 0x%08x, val - 0x%04x\n",
 		  (u32) & uccf->uf_regs->urfset,
 		  in_be16(&uccf->uf_regs->urfset));
-	printk(KERN_INFO "utfb  : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "utfb  : addr - 0x%08x, val - 0x%08x\n",
 		  (u32) & uccf->uf_regs->utfb, in_be32(&uccf->uf_regs->utfb));
-	printk(KERN_INFO "utfs  : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "utfs  : addr - 0x%08x, val - 0x%04x\n",
 		  (u32) & uccf->uf_regs->utfs, in_be16(&uccf->uf_regs->utfs));
-	printk(KERN_INFO "utfet : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "utfet : addr - 0x%08x, val - 0x%04x\n",
 		  (u32) & uccf->uf_regs->utfet, in_be16(&uccf->uf_regs->utfet));
-	printk(KERN_INFO "utftt : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "utftt : addr - 0x%08x, val - 0x%04x\n",
 		  (u32) & uccf->uf_regs->utftt, in_be16(&uccf->uf_regs->utftt));
-	printk(KERN_INFO "utpt  : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "utpt  : addr - 0x%08x, val - 0x%04x\n",
 		  (u32) & uccf->uf_regs->utpt, in_be16(&uccf->uf_regs->utpt));
-	printk(KERN_INFO "urtry : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "urtry : addr - 0x%08x, val - 0x%08x\n",
 		  (u32) & uccf->uf_regs->urtry, in_be32(&uccf->uf_regs->urtry));
-	printk(KERN_INFO "guemr : addr - 0x%08x, val - 0x%02x",
+	printk(KERN_INFO "guemr : addr - 0x%08x, val - 0x%02x\n",
 		  (u32) & uccf->uf_regs->guemr, uccf->uf_regs->guemr);
 }
 EXPORT_SYMBOL(ucc_fast_dump_regs);
-- 
1.5.0.6
