Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18723.61207.718092.349803@cargo.ozlabs.ibm.com>
Date: Wed, 19 Nov 2008 21:48:55 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: More commits pushed to powerpc.git next branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have just pushed the following commits to the "next" branch of my
powerpc.git repository, and also merged in Linus' current tree.  The
"master" branch is at the same point as "next".

Paul.

Chris J Arges (1):
      serial/pmac_zilog: Add console polling support

David Gibson (1):
      powerpc: udbg-based backend for hvc_console

Geert Uytterhoeven (1):
      powerpc/ps3: Replace the flip_ctl logic in ps3av and ps3fb by a mutex

Hollis Blanchard (1):
      powerpc: Remove superfluous WARN_ON() from dma-noncoherent.c

Mark Nelson (1):
      powerpc: Update 64bit __copy_tofrom_user() using CPU_FTR_UNALIGNED_LD_STD

Michael Ellerman (4):
      of: Add helpers for finding device nodes which have a given property
      powerpc: Use for_each_node_with_property() in of_irq_map_init()
      powerpc: Use of_find_node_with_property() in cell_iommu_fixed_mapping_init()
      powerpc/pmac: Use of_find_node_with_property() in pmac_setup_arch()

Milton Miller (2):
      powerpc: Provide a separate handler for each IPI action
      powerpc/mpic: Use new smp_request_message_ipi

Nick Piggin (3):
      powerpc: Optimise smp_wmb
      powerpc: Optimise smp_rmb
      powerpc: Optimise mutex

Paul Mackerras (1):
      powerpc: Tell gcc when we clobber the carry in inline asm

Robert Jennings (1):
      powerpc: Correct page-in counter for CMM with 64k pages
