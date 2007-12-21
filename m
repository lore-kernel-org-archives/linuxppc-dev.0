Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18283.44454.618519.155696@cargo.ozlabs.ibm.com>
Date: Fri, 21 Dec 2007 23:12:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Yet more patches added to for-2.6.25/master branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Aegis Lin (1):
      [POWERPC] spufs: Use separate timer for /proc/spu_loadavg calculation

Andre Detsch (1):
      [POWERPC] spufs: DMA Restart after SIGSEGV

Arnd Bergmann (1):
      [POWERPC] spufs: block fault handlers in spu_acquire_runnable

Benjamin Herrenschmidt (2):
      [POWERPC] Fix for via-pmu based backlight control
      [POWERPC] Fix possible NULL deref in ppc32 PCI

Christoph Hellwig (2):
      [POWERPC] spufs: add enchanced simple attr macros
      [POWERPC] spufs: make state_mutex interruptible

Emil Medve (1):
      [POWERPC] Optimize counting distinct entries in the relocation sections

Jeremy Kerr (5):
      [POWERPC] spufs: move fault, lscsa_alloc and switch code to spufs module
      [POWERPC] spufs: fix incorrect interrupt status clearing in backing mbox stat poll
      [POWERPC] spufs: use #defines for SPU class [012] exception status
      [POWERPC] spufs: rework class 0 and 1 interrupt handling
      [POWERPC] spufs: Don't leak kernel stack through an empty {i,m}box_info read

Julio M. Merino Vidal (1):
      [POWERPC] spufs: fix typos in sched.c comments

Luke Browning (4):
      [POWERPC] spufs: add backing ops for privcntl register
      [POWERPC] spufs: reorganize spu_run_init
      [POWERPC] spufs: spu_find_victim may choose wrong victim
      [POWERPC] spufs: decouple spu scheduler from spufs_spu_run (asynchronous scheduling)

Masato Noguchi (2):
      [POWERPC] cell: wrap master run control bit
      [POWERPC] spufs: don't set reserved bits in spu interrupt status

Scott Wood (1):
      [POWERPC] Implement arch disable/enable irq hooks.

Stephen Rothwell (5):
      [POWERPC] Add EHEA and EHCA as modules in the ppc64_defconfig
      [POWERPC] The builtin matches for ibmebus.c can be __initdata
      [POWERPC] Constify the of_device_id passed to of_platform_bus_probe
      [POWERPC] Pointers marked as __iomem do not need to be volatile
      [POWERPC] Make non-PCI build work again
