Return-Path: <joe@perches.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B6802B7444
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 02:38:55 +1000 (EST)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 05/62] arch/powerpc: Remove unnecessary semicolons
Date: Sun, 28 Jun 2009 09:26:10 -0700
Message-Id: <a55afa18f8b7ba8343072a14d36a2e340e61e816.1246173680.git.joe@perches.com>
In-Reply-To: <cover.1246173664.git.joe@perches.com>
References: <cover.1246173664.git.joe@perches.com>
Cc: trivial@kernel.org, Robert Richter <robert.richter@amd.com>,
	linuxppc-dev@ozlabs.org, oprofile-list@lists.sf.net,
	Andrew Morton <akpm@linux-foundation.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/mm/tlb_hash64.c                 |    2 +-
 arch/powerpc/oprofile/cell/vma_map.c         |    2 +-
 arch/powerpc/platforms/powermac/cpufreq_64.c |    2 +-
 arch/powerpc/platforms/powermac/pic.c        |    2 +-
 arch/powerpc/platforms/ps3/system-bus.c      |    1 -
 arch/powerpc/sysdev/fsl_rio.c                |    2 +-
 arch/powerpc/sysdev/ppc4xx_pci.c             |    4 ++--
 7 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 1be1b5e..937eb90 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -72,7 +72,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	 */
 	if (huge) {
 #ifdef CONFIG_HUGETLB_PAGE
-		psize = get_slice_psize(mm, addr);;
+		psize = get_slice_psize(mm, addr);
 #else
 		BUG();
 		psize = pte_pagesize_index(mm, addr, pte); /* shutup gcc */
diff --git a/arch/powerpc/oprofile/cell/vma_map.c b/arch/powerpc/oprofile/cell/vma_map.c
index 258fa44..c591339 100644
--- a/arch/powerpc/oprofile/cell/vma_map.c
+++ b/arch/powerpc/oprofile/cell/vma_map.c
@@ -185,7 +185,7 @@ struct vma_to_fileoffset_map *create_vma_map(const struct spu *aSpu,
 			goto fail;
 
 		if (shdr_str.sh_type != SHT_STRTAB)
-			goto fail;;
+			goto fail;
 
 		for (j = 0; j < shdr.sh_size / sizeof (sym); j++) {
 			if (copy_from_user(&sym, spu_elf_start +
diff --git a/arch/powerpc/platforms/powermac/cpufreq_64.c b/arch/powerpc/platforms/powermac/cpufreq_64.c
index 22ecfbe..708c751 100644
--- a/arch/powerpc/platforms/powermac/cpufreq_64.c
+++ b/arch/powerpc/platforms/powermac/cpufreq_64.c
@@ -251,7 +251,7 @@ static void g5_pfunc_switch_volt(int speed_mode)
 static struct pmf_function *pfunc_cpu_setfreq_high;
 static struct pmf_function *pfunc_cpu_setfreq_low;
 static struct pmf_function *pfunc_cpu_getfreq;
-static struct pmf_function *pfunc_slewing_done;;
+static struct pmf_function *pfunc_slewing_done;
 
 static int g5_pfunc_switch_freq(int speed_mode)
 {
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index dce7363..d212006 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -609,7 +609,7 @@ static int pmacpic_find_viaint(void)
 	np = of_find_node_by_name(NULL, "via-pmu");
 	if (np == NULL)
 		goto not_found;
-	viaint = irq_of_parse_and_map(np, 0);;
+	viaint = irq_of_parse_and_map(np, 0);
 
 not_found:
 #endif /* CONFIG_ADB_PMU */
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 9fead0f..3f763c5 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -284,7 +284,6 @@ static int ps3_sb_free_mmio_region(struct ps3_mmio_region *r)
 	int result;
 
 	dump_mmio_region(r);
-;
 	result = lv1_unmap_device_mmio_region(r->dev->bus_id, r->dev->dev_id,
 		r->lpar_addr);
 
diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 39db9d1..cbb3bed 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -965,7 +965,7 @@ static inline void fsl_rio_info(struct device *dev, u32 ccsr)
 			break;
 		default:
 			str = "Unknown";
-			break;;
+			break;
 		}
 		dev_info(dev, "Hardware port width: %s\n", str);
 
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index daefc93..6ff9d71 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -1531,7 +1531,7 @@ static void __init ppc4xx_configure_pciex_PIMs(struct ppc4xx_pciex_port *port,
 		 */
 
 		/* Calculate window size */
-		sa = (0xffffffffffffffffull << ilog2(ep_size));;
+		sa = (0xffffffffffffffffull << ilog2(ep_size));
 
 		/* Setup BAR0 */
 		out_le32(mbase + PECFG_BAR0HMPA, RES_TO_U32_HIGH(sa));
@@ -1550,7 +1550,7 @@ static void __init ppc4xx_configure_pciex_PIMs(struct ppc4xx_pciex_port *port,
 		out_le32(mbase + PCI_BASE_ADDRESS_1, RES_TO_U32_HIGH(ep_addr));
 	} else {
 		/* Calculate window size */
-		sa = (0xffffffffffffffffull << ilog2(size));;
+		sa = (0xffffffffffffffffull << ilog2(size));
 		if (res->flags & IORESOURCE_PREFETCH)
 			sa |= 0x8;
 
-- 
1.6.3.1.10.g659a0.dirty
