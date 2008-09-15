Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18638.50702.962371.862911@cargo.ozlabs.ibm.com>
Date: Mon, 15 Sep 2008 13:31:10 -0700
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to powerpc.git master and powerpc-next branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patches have been added to the the master and
powerpc-next branches of the powerpc.git repository.

This represents all of the patches that I have from the old
patchwork.  If you have a patch that you want to go in that isn't on
the new patchwork page, please repost it.

Paul.

Becky Bruce (1):
      powerpc: Rename PTE_SIZE to HPTE_SIZE

Chandru (1):
      powerpc: Add support for dynamic reconfiguration memory in kexec/kdump kernels

Christoph Hellwig (1):
      powerpc: Use sys_pause for 32-bit pause entry point

David Gibson (1):
      powerpc: Clean up hugepage pagetable allocation for powerpc with 16G pages

Mark Nelson (2):
      powerpc: Add new CPU feature: CPU_FTR_CP_USE_DCBTZ
      powerpc: New copy_4K_page()

Martin Langer (1):
      powerpc: Fix major revision number for Freescale cores

Nathan Fontenot (1):
      powerpc: Check rc of notifier chain for memory remove

Paul Mackerras (4):
      powerpc: Rearrange head_64.S to move interrupt handler code to the beginning
      powerpc: Make it possible to move the interrupt handlers away from the kernel
      powerpc: Use LOAD_REG_IMMEDIATE only for constants on 64-bit
      powerpc: Make the 64-bit kernel as a position-independent executable

Sebastien Dugue (2):
      powerpc: Separate the irq radix tree insertion and lookup
      powerpc: Make the irq reverse mapping radix tree lockless

Thiemo Seufer (1):
      powerpc: Enforce a non-spe kernel build even on broken compilers

roel kluin (1):
      powerpc: Fix duplicate test of MACIO_FLAG_SCCB_ON
