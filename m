Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18179.13902.936820.573996@cargo.ozlabs.ibm.com>
Date: Wed, 3 Oct 2007 16:27:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to powerpc.git for-2.6.24 branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adrian Bunk (1):
      [POWERPC] Select proper defconfig for crosscompiles

Aristeu Rozanski (1):
      [POWERPC] adbhid: Enable KEY_FN key reporting

Arnd Bergmann (3):
      [POWERPC] add Kconfig option for optimizing for cell
      [POWERPC] Move embedded6xx into multiplatform
      [POWERPC] Fix pci domain detection

Benjamin Herrenschmidt (1):
      [POWERPC] Fix platinumfb framebuffer

Cyrill Gorcunov (6):
      [POWERPC] Sky Cpu and Nexus: code style improvement
      [POWERPC] Sky Cpu and Nexus: include io.h
      [POWERPC] Sky Cpu and Nexus: check for platform_get_resource retcode
      [POWERPC] Sky Cpu and Nexus: check for create_proc_entry ret code
      [POWERPC] Sky Cpu: use C99 style for struct init
      [POWERPC] Sky Cpu and Nexus: use seq_file/single_open on proc interface

Dale Farnsworth (1):
      [POWERPC] Add Marvell mv64x60 udbg putc/getc functions

David Woodhouse (1):
      [POWERPC] Optionally use new device number for pmac_zilog

Domen Puncer (1):
      [POWERPC] clk.h interface for platforms

Ed Swarthout (1):
      [POWERPC] Add memory regions to the kcore list for 32-bit machines

Emil Medve (1):
      [POWERPC] Fix build errors when BLOCK=n

Grant Likely (2):
      [POWERPC] mpc8349: Add linux,network-index to ethernet nodes in device tree
      [POWERPC] mpc5200: Add cuimage support for mpc5200 boards

Hugh Dickins (1):
      [POWERPC] ppc64: support CONFIG_DEBUG_PREEMPT

Ishizaki Kou (5):
      [POWERPC] Celleb: Move pause, kexec_cpu_down to beat.c
      [POWERPC] Celleb: Support for Power/Reset buttons
      [POWERPC] Celleb: New HTAB Guest OS Interface on Beat
      [POWERPC] Celleb: Serial I/O update
      [POWERPC] Celleb: update for PCI

Jeremy Kerr (1):
      [POWERPC] cell: Don't cast the result of of_get_property()

Joachim Fenkes (1):
      [POWERPC] ibmebus: More descriptive error return code in ibmebus_store_probe()

Jochen Friedrich (4):
      [POWERPC] Fix copy'n'paste typo in commproc.c
      [PPC] Fix cpm_dpram_addr returning phys mem instead of virt mem
      [PPC] Compile fix for 8xx CPM Ehernet driver
      [POWERPC] Fix cpm_uart driver

Linas Vepstas (2):
      [POWERPC] pseries: device node status can be "ok" or "okay"
      [POWERPC] Use alloc_maybe_bootmem() in pcibios_alloc_controller

Mark A. Greer (1):
      [POWERPC] MAINTAINERS shouldn't reference linuxppc-embedded

Mathieu Desnoyers (1):
      [POWERPC] Include pagemap.h in asm/powerpc/tlb.h

Meelis Roos (1):
      [POWERPC] Fix ppc kernels after build-id addition

Michael Ellerman (8):
      [POWERPC] Make sure to of_node_get() the result of pci_device_to_OF_node()
      [POWERPC] Simplify error logic in u3msi_setup_msi_irqs()
      [POWERPC] Simplify error logic in rtas_setup_msi_irqs()
      [POWERPC] Simplify rtas_change_msi() error semantics
      [POWERPC] Inline u3msi_compose_msi_msg()
      [POWERPC] Store the base address in dcr_host_t
      [POWERPC] Update mpic to use dcr_host_t.base
      [POWERPC] Update axon_msi to use dcr_host_t.base

Mike Frysinger (1):
      [POWERPC] Use __attribute__ in asm-powerpc

Milton Miller (2):
      [POWERPC] boot: Record header bytes in gunzip_start
      [POWERPC] boot: Simplify gunzip_finish

Olof Johansson (2):
      [POWERPC] Support setting affinity for U3/U4 MSI sources
      [POWERPC] Separate out legacy machine check exception parsers

Paul Mackerras (1):
      [POWERPC] Disable power management for arch/ppc

Robert P. J. Day (1):
      [POWERPC] Prevent direct inclusion of <asm/rwsem.h>.

Roland McGrath (2):
      [POWERPC] Add CHECK_FULL_REGS in several places in ptrace code
      [POWERPC] powerpc vDSO: install unstripped copies on disk

Satyam Sharma (1):
      [POWERPC] Avoid pointless WARN_ON(irqs_disabled()) from panic codepath

Scott Wood (3):
      [POWERPC] bootwrapper: Factor out dt_set_mac_address()
      [POWERPC] bootwrapper: Add PlanetCore firmware support
      [POWERPC] Make instruction dumping work in real mode

Stephen Rothwell (5):
      [POWERPC] Create and use CONFIG_WORD_SIZE
      [POWERPC] Remove debug printk from vio_bus_init
      [POWERPC] Simplify vio_bus_init a little for legacy iSeries
      [POWERPC] Make vio_bus_type static
      [POWERPC] Limit range of __init_ref_ok somewhat

Tony Breeds (6):
      [POWERPC] Convert define_machine(mpc885_ads) to C99 initializer syntax
      [POWERPC] Implement {read,update}_persistent_clock
      [POWERPC] Implement generic time of day clocksource for powerpc
      [POWERPC] Fix panic in RTAS code
      [POWERPC] Implement clockevents driver for powerpc
      [POWERPC] Enable tickless idle and high res timers for powerpc
