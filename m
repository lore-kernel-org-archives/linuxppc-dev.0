Date: Mon, 1 Mar 2004 15:21:10 -0500 (EST)
From: "Verberk, Bep" <verberk@nortelnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] trivial-correct debug printk's in walnut.c
Message-ID: <Pine.LNX.4.44.0403011517020.3111-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Patch is against BK linuxppc-2.5. It simply corrects
some debug printk's.

--- linuxppc-2.5/arch/ppc/platforms/4xx/walnut.c	2004-03-01 15:10:23.000000000 -0500
+++ linuxppc-2.5-bep/arch/ppc/platforms/4xx/walnut.c	2004-03-01 15:14:29.000000000 -0500
@@ -146,9 +146,9 @@
 	printk("PCI bridge regs before fixup \n");
 	for (i = 0; i <= 3; i++) {
 		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
+		printk(" pmm%dla\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
+		printk(" pmm%dpcila\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
+		printk(" pmm%dpciha\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
 	}
 	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
 	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
@@ -206,9 +206,9 @@
 	printk("PCI bridge regs after fixup \n");
 	for (i = 0; i <= 3; i++) {
 		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
+		printk(" pmm%dla\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
+		printk(" pmm%dpcila\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
+		printk(" pmm%dpciha\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
 	}
 	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
 	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
