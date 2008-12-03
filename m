Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18742.28016.872379.380647@cargo.ozlabs.ibm.com>
Date: Wed, 3 Dec 2008 22:28:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Commits added to powerpc.git next and master branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have added the following commits to the next and master branches of
my powerpc.git tree.  I also pulled in Linus' tree plus the fix from
Ben that I just asked him to pull.

Paul.

Anton Vorontsov (3):
      powerpc and sparc: Introduce dev_archdata node accessors
      of/i2c: Fill the archdata for I2C devices
      of/gpio: Implement of_get_gpio_flags()

Becky Bruce (1):
      powerpc: Add sync_*_for_* to dma_ops

Benjamin Herrenschmidt (1):
      powerpc: Fix ppc32 mm_struct CPU tracking in SMP

Hendrik Brueckner (1):
      hvc_console: Always schedule resize work on resize

Johannes Berg (1):
      powerpc: Allow the max stack trace depth to be configured

Julia Lawall (1):
      powerpc: Eliminate NULL test and memset after alloc_bootmem

Kumar Gala (4):
      powerpc: Add MSR[CE, DE] to the MSR bits we print on show_regs()
      powerpc: hash_page_sync should only be used on SMP & STD_MMU_32
      powerpc: Add a local_flush_tlb_page to handle kmap_atomic invalidates
      powerpc: Use RCU based pte freeing mechanism for all powerpc

Nicolas Palix (1):
      drivers/hvc: Add missing of_node_put

Sebastien Dugue (1):
      powerpc/ibmebus: Get rid of the IRQ mapping in ibmebus_free_irq()

Sonny Rao (1):
      powerpc/BSR: Support multiple OF-node description of BSR

roel kluin (2):
      powerpc/macintosh: Fix unsigned check in smu_sat_get_sdb_partition()
      powerpc: Make open count variables signed in hvcs/hvsi/hvc_console
