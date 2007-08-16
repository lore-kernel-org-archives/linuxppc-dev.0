Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B6AF8DDE9C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 11:19:22 +1000 (EST)
Date: Thu, 16 Aug 2007 11:19:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Remove some duplicate declarations from pmac.h
Message-Id: <20070816111919.c8923dcc.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/powermac/pmac.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
index 6e090a7..fcde070 100644
--- a/arch/powerpc/platforms/powermac/pmac.h
+++ b/arch/powerpc/platforms/powermac/pmac.h
@@ -22,9 +22,6 @@ extern void pmac_read_rtc_time(void);
 extern void pmac_calibrate_decr(void);
 extern void pmac_pci_irq_fixup(struct pci_dev *);
 extern void pmac_pci_init(void);
-extern unsigned long pmac_ide_get_base(int index);
-extern void pmac_ide_init_hwif_ports(hw_regs_t *hw,
-	unsigned long data_port, unsigned long ctrl_port, int *irq);
 
 extern void pmac_nvram_update(void);
 extern unsigned char pmac_nvram_read_byte(int addr);
@@ -33,7 +30,6 @@ extern int pmac_pci_enable_device_hook(struct pci_dev *dev, int initial);
 extern void pmac_pcibios_after_init(void);
 extern int of_show_percpuinfo(struct seq_file *m, int i);
 
-extern void pmac_pci_init(void);
 extern void pmac_setup_pci_dma(void);
 extern void pmac_check_ht_link(void);
 
-- 
1.5.2.4
