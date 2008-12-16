Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18759.14410.731000.378702@cargo.ozlabs.ibm.com>
Date: Tue, 16 Dec 2008 16:10:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: More commits added to powerpc.git next and master branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have added the following commits to the next and master branches of
my powerpc.git tree (including commits pulled from Kumar's tree).  I
have also pulled in Linus' current tree and the 3 commits that I just
asked him to pull.

Paul.

Anton Vorontsov (2):
      powerpc/qe: Move cmxgcr_lock definition from the ucc.c into the qe.c
      powerpc: Remove `have_of' global variable

Becky Bruce (1):
      powerpc: Fix !CONFIG_PPC_NEED_DMA_SYNC_OPS build warning

Benjamin Herrenschmidt (5):
      powerpc: Fix bogus cache flushing on all 40x and BookE processors v2
      powerpc: Fix asm EMIT_BUG_ENTRY with !CONFIG_BUG
      powerpc/mm: Add local_flush_tlb_mm() to SW loaded TLB implementations
      powerpc/mm: Rename tlb_32.c and tlb_64.c to tlb_hash32.c and tlb_hash64.c
      powerpc/mm: Remove flush_HPTE()

FUJITA Tomonori (1):
      powerpc: Remove dead BIO_VMERGE_BOUNDARY definition

Geert Uytterhoeven (1):
      powerpc/ps3: Add sub-match id modalias support

Geoff Levand (2):
      powerpc: Fix typo in pgtable-ppc64.h
      powerpc/ps3: Quiet dmesg output

Haiying Wang (3):
      powerpc/85xx: Add localbus node in mpc8572ds dts file
      powerpc/85xx: Don't reset the MPIC for CAMP mode on MPC8572DS
      powerpc/85xx: Create dts for each core in CAMP mode for MPC8572DS

Josh Boyer (1):
      powerpc: Introduce ppc_pci_flags accessors

Kay Sievers (2):
      powerpc: struct device - replace bus_id with dev_name(), dev_set_name()
      rapidio: struct device - replace bus_id with dev_name(), dev_set_name()

Kumar Gala (5):
      powerpc: Remove unncessary SPE related compiler flag
      powerpc/85xx: minor head_fsl_booke.S cleanup
      powerpc/85xx: Add support for SMP initialization
      powerpc/85xx: Fix compile warnings in mpc85xx_mds.c
      powerpc/85xx: Fix compile issues with mpc8572ds.dts

Liu Yu (4):
      powerpc/math-emu: Fix single float point division bug
      powerpc/math-emu: Adopt new version of _FP_CHOOSENAN
      powerpc/math-emu: Remove redundant 'ret'
      powerpc: Add SPE/EFP math emulation for E500v1/v2 processors.

Martyn Welch (2):
      powerpc/86xx: Add use of Epson RTX-8581 RTC to GE Fanuc SBC610 dts
      powerpc/86xx: Basic GPIO support for GE Fanuc SBC610

Nathan Lynch (3):
      powerpc: Move smp_hw_index to 32-bit code
      powerpc/powermac: Use set_hard_smp_processor_id() instead of smp_hw_index
      powerpc/pseries: Check for GIQ indicator before calling set-indicator

Nicolas Palix (1):
      powerpc/chrp: Add missing of_node_put in pci.c

Trent Piepho (1):
      powerpc: Better setup of boot page TLB entry
