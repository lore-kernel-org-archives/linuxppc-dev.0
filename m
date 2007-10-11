Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18190.5965.836544.396721@cargo.ozlabs.ibm.com>
Date: Thu, 11 Oct 2007 22:30:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: powerpc commits for 2.6.24
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Below is the list of commits that I plan to ask Linus to pull
tomorrow.  This is the last call for anything else or for objections
to any of these commits going in.  These commits are in powerpc.git on
the master and for-2.6.24 branches.

Paul.

Adrian Bunk (2):
      [POWERPC] Remove APUS support from arch/ppc
      [POWERPC] Select proper defconfig for crosscompiles

Andre Detsch (1):
      [POWERPC] spufs: Fix race condition on gang->aff_ref_spu

Anton Vorontsov (11):
      [POWERPC] QE: extern par_io_config_pin and par_io_data_set funcs
      [POWERPC] fsl_soc: add support for fsl_spi
      [POWERPC] MPC832x_RDB: Update dts to use SPI1 in QE, register mmc_spi stub
      [POWERPC] fsl_soc: fix uninitialized i2c_board_info structure
      [POWERPC] MPC8568E-MDS: add support for ds1374 rtc
      [POWERPC] mpc8568mds.dts: fix PCIe I/O address space location and size
      [POWERPC] mpc85xx_mds: select QUICC_ENGINE
      [POWERPC] QEIC: Implement pluggable handlers, fix MPIC cascading
      [POWERPC] QE: pario - support for MPC85xx layout
      [POWERPC] 85xx: mpc8568mds - update dts to be able to use UCCs
      [POWERPC] 85xx: mpc85xx_mds - reset UCC ethernet properly

Aristeu Rozanski (1):
      [POWERPC] adbhid: Enable KEY_FN key reporting

Arnd Bergmann (3):
      [POWERPC] add Kconfig option for optimizing for cell
      [POWERPC] Move embedded6xx into multiplatform
      [POWERPC] Fix pci domain detection

Becky Bruce (1):
      [POWERPC] Update lmb.h include protection to ASM_POWERPC

Benjamin Herrenschmidt (3):
      [POWERPC] Fix platinumfb framebuffer
      [POWERPC] cell: Move cbe_regs.h to include/asm-powerpc/cell-regs.h
      [POWERPC] cell: Add Cell memory controller register defs and expose it

Cyrill Gorcunov (6):
      [POWERPC] Sky Cpu and Nexus: code style improvement
      [POWERPC] Sky Cpu and Nexus: include io.h
      [POWERPC] Sky Cpu and Nexus: check for platform_get_resource retcode
      [POWERPC] Sky Cpu and Nexus: check for create_proc_entry ret code
      [POWERPC] Sky Cpu: use C99 style for struct init
      [POWERPC] Sky Cpu and Nexus: use seq_file/single_open on proc interface

Dale Farnsworth (2):
      [POWERPC] Add Marvell mv64x60 udbg putc/getc functions
      [POWERPC] 85xx: Failure with odd memory sizes and CONFIG_HIGHMEM

David Gibson (7):
      [POWERPC] Fixes to allow use of Ebony's flash chips through physmap_of
      [POWERPC] Fix setting of irq trigger type in UIC driver
      [POWERPC] Fix irq flow handler for 4xx UIC
      [POWERPC] Improve robustness of the UIC cascade handler
      [POWERPC] Move bootwrapper's strchr() and strncmp() from .h to string.S
      [POWERPC] Document and implement an improved flash device binding for powerpc
      [POWERPC] Cleanups for physmap_of.c (v2)

David Woodhouse (1):
      [POWERPC] Optionally use new device number for pmac_zilog

Domen Puncer (2):
      [POWERPC] MPC5200 low power mode
      [POWERPC] clk.h interface for platforms

Ed Swarthout (1):
      [POWERPC] Add memory regions to the kcore list for 32-bit machines

Emil Medve (2):
      [POWERPC] Fix build errors when BLOCK=n
      [POWERPC] QE: Added missing CEURNR register

Gabriel C (1):
      [POWERPC] Typo fixes interrrupt -> interrupt

Geert Uytterhoeven (1):
      [POWERPC] PS3: Add new LV1 error codes

Geoff Levand (7):
      [POWERPC] PS3: Enhance storage probe debug output
      [POWERPC] PS3: Cleanup of os-area.c
      [POWERPC] PS3: Remove unused os-area params
      [POWERPC] PS3: os-area workqueue processing
      [POWERPC] PS3: Add os-area rtc_diff set/get routines
      [POWERPC] PS3: Save os-area params to device tree
      [POWERPC] PS3: Add os-area database routines

Grant Likely (25):
      [POWERPC] Only ignore arch/ppc/include, not arch/ppc/boot/include
      [POWERPC] mpc8349: Add linux,network-index to ethernet nodes in device tree
      [POWERPC] mpc5200: Add cuimage support for mpc5200 boards
      [POWERPC] Virtex: Add uartlite bootwrapper driver
      [POWERPC] Virtex: Add Kconfig macros for Xilinx Virtex board support
      [POWERPC] Virtex: add xilinx interrupt controller driver
      [POWERPC] Virtex: Add generic Xilinx Virtex board support
      [POWERPC] Add PowerPC Xilinx Virtex entry to maintainers
      [POWERPC] Uartlite: Fix reg io to access documented register size
      [POWERPC] Uartlite: change name of ports to ulite_ports
      [POWERPC] Uartlite: Add macro for uartlite device name
      [POWERPC] Uartlite: Separate the bus binding from the driver proper
      [POWERPC] Uartlite: Comment block tidy
      [POWERPC] Uartlite: Add of-platform-bus binding
      [POWERPC] Uartlite: Let the console be initialized earlier
      [POWERPC] Uartlite: Flush RX fifo in bootwrapper
      [POWERPC] XilinxFB: Move xilinxfb_platform_data definition to a shared header file
      [POWERPC] Setup default eth addr in embed_config for Xilinx Virtex platforms
      [POWERPC] Uartlite: Add macros for register names
      [POWERPC] Uartlite: Revert register io access changes
      [POWERPC] Lite5200: Use comma delimiter format for lists in device tree
      [POWERPC] Enable debug info on boot wrapper
      [POWERPC] Only call ppc_md.setup_arch() if it is provided
      [POWERPC] Remove empty ppc_md.setup_arch hooks
      [POWERPC] Platforms shouldn't mess with ROOT_DEV

Guennadi Liakhovetski (2):
      [POWERPC] Fix i2c device string format
      [POWERPC] linkstation updates

Hollis Blanchard (1):
      [POWERPC] 4xx: Implement udbg_getc() for 440

Hugh Dickins (1):
      [POWERPC] ppc64: support CONFIG_DEBUG_PREEMPT

Ishizaki Kou (9):
      [POWERPC] Fix celleb pci section warnings
      [POWERPC] Fix celleb sio section warning
      [POWERPC] Init markings for celleb
      [POWERPC] Init markings for hvc_beat
      [POWERPC] Celleb: Move pause, kexec_cpu_down to beat.c
      [POWERPC] Celleb: Support for Power/Reset buttons
      [POWERPC] Celleb: New HTAB Guest OS Interface on Beat
      [POWERPC] Celleb: Serial I/O update
      [POWERPC] Celleb: update for PCI

Jason Jin (1):
      [POWERPC] Treat 8610 PCIe host bridge as transparent

Jeremy Kerr (8):
      [POWERPC] PS3: Fix CONFIG_SMP=n, CONFIG_KEXEC=y build
      [POWERPC] spufs: Remove asmlinkage from do_spu_create
      [POWERPC] spufs: Remove spu_harvest
      [POWERPC] cell: Unify spufs syscall path
      [POWERPC] spufs: Remove asmlinkage from spufs_calls
      [POWERPC] spufs: Fix restore_decr_wrapped() to match CBE Handbook
      [POWERPC] cell: Remove DEBUG for SPU callbacks
      [POWERPC] cell: Don't cast the result of of_get_property()

Jesper Juhl (2):
      [POWERPC] Clean out a bunch of duplicate includes
      [POWERPC] Don't cast kmalloc return value in ibmebus.c

Joachim Fenkes (1):
      [POWERPC] ibmebus: More descriptive error return code in ibmebus_store_probe()

Jochen Friedrich (4):
      [POWERPC] Fix copy'n'paste typo in commproc.c
      [PPC] Fix cpm_dpram_addr returning phys mem instead of virt mem
      [PPC] Compile fix for 8xx CPM Ehernet driver
      [POWERPC] Fix cpm_uart driver

John Rigby (1):
      [POWERPC] 52xx: Fix mpc52xx_uart_of_assign to use correct index

John Traill (1):
      [POWERPC] 8xx: Set initial memory limit.

Jon Loeliger (5):
      [POWERPC] 52xx: Remove unnecessary loops_per_jiffy initialization code
      [POWERPC] 8xx: Remove unnecessary loops_per_jiffy initialization code
      [POWERPC] embedded6xx: Remove unnecessary loops_per_jiffy initialization code
      [POWERPC] 86xx: Remove unnecessary loops_per_jiffy initialization code.
      [POWERPC] 85xx: Remove unnecessary loops_per_jiffy initialization code.

Josh Boyer (23):
      [POWERPC] Rename 4xx paths to 40x
      [POWERPC] 4xx Kconfig cleanup
      [POWERPC] Rename 44x bootwrapper
      [POWERPC] 4xx bootwrapper reworks
      [POWERPC] 40x MMU
      [POWERPC] 40x decrementer fixes
      [POWERPC] Fix 40x build
      [POWERPC] Bamboo DTS
      [POWERPC] Bamboo board support
      [POWERPC] Bamboo zImage wrapper
      [POWERPC] Remove dtc build cruft from DTS files
      [POWERPC] Fix bus probe on Bamboo board
      [POWERPC] Walnut DTS
      [POWERPC] Walnut defconfig
      [POWERPC] Walnut board support
      [POWERPC] Walnut zImage wrapper
      [POWERPC] cuimage for Bamboo board
      [POWERPC] Make partitions optional in physmap_of
      [POWERPC] 4xx: Convert Walnut flash mappings to new binding
      [POWERPC] 4xx: Convert Seqouia flash mappings to new binding
      [POWERPC] Update PowerPC 4xx entry in MAINTAINERS
      [POWERPC] 4xx: Fix Walnut wrapper compile errors
      [POWERPC] Add treeImage to .gitignore

Kumar Gala (19):
      [POWERPC] Remove old includes from arch/ppc
      [POWERPC] Copy over headers from arch/ppc to arch/powerpc that we need
      [POWERPC] Stop include asm-ppc when building ARCH=powerpc for ppc32
      ucc_geth: kill unused include
      [POWERPC] 85xx: Renamed mpc8544_ds.c to mpc85xx_ds.c
      [POWERPC] 85xx: Clean up from 85xx_ds rename
      [POWERPC] Handle alignment faults on SPE load/store instructions
      [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
      [POWERPC] DTS cleanup
      [POWERPC] Move PCI nodes to be sibilings with SOC nodes
      [POWERPC] 83xx: Removed PCI exclude of PHB
      [POWERPC] Add cpu feature for SPE handling
      [POWERPC] Fix modpost warnings from head*.S on ppc32
      [POWERPC] Cleaned up whitespace in head_fsl_booke.S
      [POWERPC] Fixup MPC8568 dts
      [POWERPC] Update .gitignore for new vdso generated files
      [POWERPC] FSL: Access PCIe LTSSM register with correct size
      [POWERPC] Use for_each_ matching routinues for pci PHBs
      [POWERPC] 85xx/86xx: refactor RSTCR reset code

Linas Vepstas (16):
      [POWERPC] EEH: Tweak printk message
      [POWERPC] EEH: Fix PCI bridge handling bug
      [POWERPC] EEH: Dump PCI bridge status on event
      [POWERPC] pseries: Avoid excess rtas_token calls
      [POWERPC] pseries: Use rtas_token instead of hand-rolled code
      [POWERPC] pseries: Simplify rtasd initialization
      [POWERPC] Remove nvram forward declarations
      [POWERPC] pseries: Fix jumbled no_logging flag
      [POWERPC] pseries: Eliminate global error_log_cnt variable
      [POWERPC] pseries: Remove dead EEH video code
      [POWERPC] IOMMU virtual merge is no longer experimental
      [POWERPC] prom_init whitespace cleanup, typo fix
      [POWERPC] prom.c whitespace cleanup
      [POWERPC] setup_64.c and prom.c comment cleanup
      [POWERPC] pseries: device node status can be "ok" or "okay"
      [POWERPC] Use alloc_maybe_bootmem() in pcibios_alloc_controller

Mariusz Kozlowski (1):
      [POWERPC] drivers/macintosh/therm_adt746x.c: kmalloc + memset conversion to kzalloc

Mark A. Greer (1):
      [POWERPC] MAINTAINERS shouldn't reference linuxppc-embedded

Mathieu Desnoyers (1):
      [POWERPC] Include pagemap.h in asm/powerpc/tlb.h

Meelis Roos (1):
      [POWERPC] Fix ppc kernels after build-id addition

Michael Buesch (1):
      [POWERPC] via-pmu: Fix typo in printk

Michael Ellerman (28):
      [POWERPC] Add an optional device_node pointer to the irq_host
      [POWERPC] Invert null match behaviour for irq_hosts
      [POWERPC] Provide a default irq_host match, which matches on an exact of_node
      [POWERPC] Initialise hwirq for legacy irqs
      [POWERPC] Export virq mapping via debugfs
      [POWERPC] spufs: Extract the file descriptor search logic in SPU coredump code
      [POWERPC] spufs: Remove ctx_info and ctx_info_list
      [POWERPC] spufs: Call spu_acquire_saved() before calculating the SPU note sizes
      [POWERPC] spufs: Use computed sizes/#defines rather than literals in SPU coredump code
      [POWERPC] spufs: Write some SPU coredump values as ASCII
      [POWERPC] spufs: Correctly calculate the size of the local-store to dump
      [POWERPC] spufs: Don't return -ENOSYS as extra notes size if spufs is not loaded
      [POWERPC] spufs: Get rid of spufs_coredump_num_notes, it's not needed if we NULL terminate
      [POWERPC] spufs: Internal __spufs_get_foo() routines should take a spu_context *
      [POWERPC] spufs: Add contents of npc file to SPU coredumps
      [POWERPC] spufs: Combine spufs_coredump_calls with spufs_calls
      [POWERPC] spufs: Cleanup ELF coredump extra notes logic
      [POWERPC] spufs: Handle errors in SPU coredump code, and support coredump to a pipe
      [POWERPC] spufs: Respect RLIMIT_CORE in spu coredump code
      [POWERPC] spufs: Add DEFINE_SPUFS_ATTRIBUTE()
      [POWERPC] Make sure to of_node_get() the result of pci_device_to_OF_node()
      [POWERPC] Simplify error logic in u3msi_setup_msi_irqs()
      [POWERPC] Simplify error logic in rtas_setup_msi_irqs()
      [POWERPC] Simplify rtas_change_msi() error semantics
      [POWERPC] Inline u3msi_compose_msi_msg()
      [POWERPC] Store the base address in dcr_host_t
      [POWERPC] Update mpic to use dcr_host_t.base
      [POWERPC] Update axon_msi to use dcr_host_t.base

Michael Neuling (1):
      [POWERPC] Remove barriers from the SLB shadow buffer update

Mike Frysinger (1):
      [POWERPC] Use __attribute__ in asm-powerpc

Milton Miller (2):
      [POWERPC] boot: Record header bytes in gunzip_start
      [POWERPC] boot: Simplify gunzip_finish

Murali Iyer (1):
      [POWERPC] Export DCR symbols for modules

Nathan Lynch (14):
      [POWERPC] Remove gratuitous reads from maple PCI config space methods
      [POWERPC] rtas_pci_ops: Use named structure member initializers
      [POWERPC] celleb_fake_pci_ops: Use named structure member initializers
      [POWERPC] celleb_epci_ops: Use named structure member initializers
      [POWERPC] maple pci_ops: Use named structure member initializers
      [POWERPC] pa_pxp_ops: Use named structure member initializers
      [POWERPC] powermac pci_ops: Use named structure member initializers
      [POWERPC] null_pci_ops: Use named structure member initializers
      [POWERPC] efika rtas_pci_ops: Use named structure member initializers
      [POWERPC] chrp pci_ops: Use named structure member initializers
      [POWERPC] indirect_pci_ops: Use named structure member initializers
      [POWERPC] tsi108_direct_pci_ops: Use named structure member initializers
      [POWERPC] Remove gratuitous reads from pasemi pci config space methods
      [POWERPC] Remove gratuitous reads from powermac pci config space methods

Olaf Hering (2):
      [POWERPC] Advertise correct IDE mode on Pegasos2
      [POWERPC] Fix pmac_zilog debug arg

Olof Johansson (14):
      [POWERPC] Rework SMP timebase handoff for pasemi
      [POWERPC] Export new __io{re,un}map_at() symbols
      [POWERPC] pasemi: Add pasemi_pci_getcfgaddr()
      [POWERPC] pasemi: Add workaround for erratum 5945
      [POWERPC] pasemi: Export more SPRs to sysfs when CONFIG_DEBUG_KERNEL=y
      [POWERPC] pasemi: Print more information at machine check
      [POWERPC] pasemi: Move pasemi_idle_init() to late_initcall()
      [POWERPC] Remove unused platform_machine_check()
      [POWERPC] Move lowlevel runlatch calls under cpu feature control
      [POWERPC] Remove warning in arch/powerpc/kernel/sysfs.c
      [POWERPC] Add workaround for MPICs with broken register reads
      [POWERPC] Support setting affinity for U3/U4 MSI sources
      [POWERPC] Separate out legacy machine check exception parsers
      [POWERPC] Don't enable cpu hotplug on pSeries machines with MPIC

Paul Mackerras (8):
      [POWERPC] Handle alignment faults on new FP load/store instructions
      [POWERPC] Disable power management for arch/ppc
      [PPC] Use cpu setup routines from cpu_setup_44x.S for ARCH=ppc
      [POWERPC] Use cache-inhibited large page bit from firmware
      [POWERPC] Remove unused old code from powermac setup code
      [POWERPC] Fix performance monitor on machines with logical PVR
      [POWERPC] Prevent decrementer clockevents from firing early
      [POWERPC] Make clockevents work on PPC601 processors

Peter Korsgaard (5):
      [POWERPC] fsl_soc: Fix trivial printk typo.
      [POWERPC] fsl_soc: rtc-ds1307 support
      [POWERPC] spi: Use fsl_spi instead of mpc83xx_spi
      [POWERPC] spi: mode should be "cpu-qe" instead of "qe"
      [POWERPC] spi: Support non-QE processors

Robert P. J. Day (2):
      [POWERPC] Prevent direct inclusion of <asm/rwsem.h>.
      [POWERPC] Remove redundant reference to non-existent CONFIG_BOOTIMG

Roland McGrath (2):
      [POWERPC] Add CHECK_FULL_REGS in several places in ptrace code
      [POWERPC] powerpc vDSO: install unstripped copies on disk

Roy Zang (1):
      [POWERPC] bootwrapper: adds cuboot for MPC7448HPC2 platform

Satyam Sharma (1):
      [POWERPC] Avoid pointless WARN_ON(irqs_disabled()) from panic codepath

Scott Wood (52):
      [POWERPC] Whitespace cleanup in arch/powerpc
      [POWERPC] Add clrbits8 and setbits8
      [POWERPC] Use strcasecmp() rather than strncasecmp() when determining device node compatibility
      [POWERPC] bootwrapper: Update .gitignore
      [POWERPC] bootwrapper: Set timebase_period_ns from dt_fixup_cpu_clocks
      [POWERPC] bootwrapper: dt_xlate_range() bugfixes
      [POWERPC] bootwrapper: Add dt_is_compatible()
      [POWERPC] bootwrapper: Add 16-bit I/O, sync(), eieio(), and barrier()
      [POWERPC] bootwrapper: Add TARGET_HAS_ETHn tests to ppcboot.h
      [POWERPC] bootwrapper: serial_console_init() fixes
      [POWERPC] bootwrapper: Declare udelay() in ops.h
      [POWERPC] bootwrapper: Add CPM serial driver
      [POWERPC] bootwrapper: Move linker symbols into ops.h
      [POWERPC] bootwrapper: Add 8xx cuboot support
      [POWERPC] bootwrapper: Add PowerQUICC II (82xx with CPM) cuboot support
      [POWERPC] bootwrapper: flatdevtree fixes
      [POWERPC] bootwrapper: Add strtoull()
      [POWERPC] bootwrapper: Add get_path()
      [POWERPC] bootwrapper: Only print MAC addresses when the node is actually present
      [POWERPC] Check _PAGE_RW and _PAGE_PRESENT on kernel addresses
      [POWERPC] fsl_soc.c cleanup
      [PPC] Add clrbits8 and setbits8.
      [POWERPC] bootwrapper: Factor out dt_set_mac_address()
      [POWERPC] bootwrapper: Add PlanetCore firmware support
      [POWERPC] Make instruction dumping work in real mode
      [POWERPC] CPM: Change from fsl,brg-frequency to brg/clock-frequency
      [POWERPC] Introduce new CPM device bindings.
      [POWERPC] Add early debug console for CPM serial ports.
      [POWERPC] bootwrapper: Support all-in-one PCI nodes in cuboot-pq2.
      [POWERPC] bootwrapper: Add fsl_get_immr() and 8xx/pq2 clock functions.
      [POWERPC] bootwrapper: Use fsl_get_immr() in cuboot-pq2.c.
      [POWERPC] cpm_uart: Be an of_platform device when CONFIG_PPC_CPM_NEW_BINDING is set.
      [POWERPC] cpm_uart: sparse fixes
      [POWERPC] cpm_uart: Issue STOP_TX command before initializing console.
      [POWERPC] 8xx: Fix CONFIG_PIN_TLB.
      [POWERPC] 8xx: Infrastructure code cleanup.
      [POWERPC] 8xx: Add pin and clock setting functions.
      [POWERPC] 8xx: Work around CPU15 erratum.
      [POWERPC] cpm2: Infrastructure code cleanup.
      [POWERPC] cpm2: Add SCCs to cpm2_clk_setup(), and cpm2_smc_clk_setup().
      [POWERPC] cpm2: Add cpm2_set_pin().
      [POWERPC] mpc82xx: Define CPU_FTR_NEED_COHERENT
      [POWERPC] mpc82xx: Remove a bunch of cruft that duplicates generic functionality.
      [POWERPC] mpc82xx: Rename mpc82xx_ads to mpc8272_ads.
      [POWERPC] mpc8272ads: Change references from 82xx_ADS to 8272_ADS.
      [POWERPC] Document local bus nodes in the device tree, and update cuboot-pq2.
      [POWERPC] 8xx: mpc885ads cleanup
      [POWERPC] 8xx/wrapper: Embedded Planet EP88xC support
      [POWERPC] mpc82xx: Update mpc8272ads, and factor out PCI and reset.
      [POWERPC] mpc82xx: Add pq2fads board support.
      [POWERPC] 8xx: Move softemu8xx.c from arch/ppc
      [POWERPC] cpm: Describe multi-user ram in its own device node.

Sebastian Siewior (2):
      [POWERPC] spufs: Make file-internal functions & variables static
      [POWERPC] spufs: Make isolated loader properly aligned

Segher Boessenkool (2):
      [POWERPC] Replace a few #defines with empty inline functions
      [POWERPC] Implement atomic{, 64}_{read, write}() without volatile

Stephen Rothwell (37):
      [POWERPC] Fix non HUGETLB_PAGE build warning
      [POWERPC] Use of_get_property in ipmi code
      [POWERPC] Remove get_property and device_is_compatible
      [POWERPC] Tidy up CONFIG_PPC_MM_SLICES code
      [POWERPC] Comment out a currently unused function
      [POWERPC] Fix section mismatch in crash_dump.c
      [POWERPC] Fix section mismatch in dart_iommu.c
      [POWERPC] Fix section mismatches in udbg_adb.c
      [POWERPC] Fix section mismatch in pasemi/iommu.c
      [POWERPC] Remove some duplicate declarations from pmac.h
      [POWERPC] iSeries: Clean up lparmap mess
      [POWERPC] Move iSeries startup code out of head_64.S
      [POWERPC] Move the exception macros into a header file
      [POWERPC] Move the iSeries exception vectors
      [POWERPC] Split out iSeries specific exception macros
      [POWERPC] Exception numbers are not relevant to iSeries
      [POWERPC] Fix section mismatch in PCI code
      [POWERPC] Remove cmd_line from head*.S
      [POWERPC] Size swapper_pg_dir correctly
      [POWERPC] FWNMI is only used on pSeries
      [POWERPC] Create and use CONFIG_WORD_SIZE
      [POWERPC] Remove debug printk from vio_bus_init
      [POWERPC] Simplify vio_bus_init a little for legacy iSeries
      [POWERPC] Make vio_bus_type static
      [POWERPC] Limit range of __init_ref_ok somewhat
      [POWERPC] iSeries: Correct missing newline in printk
      [POWERPC] Prepare to remove of_platform_driver name
      [POWERPC] Remove some more section mismatch warnings
      [POWERPC] Align the sys_call_table
      [POWERPC] Clean up vio.h
      [POWERPC] iSeries: Simplify viocd initialisation
      [POWERPC] Remove iSeries_vio_dev
      [POWERPC] Remove more iSeries-specific stuff from vio.c
      [POWERPC] iSeries: Move detection of virtual cdroms
      [POWERPC] iSeries: Move detection of virtual tapes
      [POWERPC] iSeries: Move viodasd probing
      [POWERPC] Move of_platform_driver initialisations: arch/powerpc

Timur Tabi (4):
      [POWERPC] add clrsetbits macros
      [POWERPC] 86xx: Fix definition of global-utilites structure
      [POWERPC] qe: miscellaneous code improvements and fixes to the QE library
      [POWERPC] 86xx: update immap_86xx.h for the 8610

Tony Breeds (6):
      [POWERPC] Convert define_machine(mpc885_ads) to C99 initializer syntax
      [POWERPC] Implement {read,update}_persistent_clock
      [POWERPC] Implement generic time of day clocksource for powerpc
      [POWERPC] Fix panic in RTAS code
      [POWERPC] Implement clockevents driver for powerpc
      [POWERPC] Enable tickless idle and high res timers for powerpc

Valentine Barshak (10):
      [POWERPC] PowerPC 440EPx: Sequoia device tree
      [POWERPC] PowerPC 440EPx: Sequoia defconfig
      [POWERPC] PowerPC 440EPx: Sequoia board support
      [POWERPC] PowerPC 440EPx: Sequoia bootwrapper
      [POWERPC] Add 64-bit resources support to pci_iomap
      [POWERPC] 4xx: Fix Bamboo MAL0 dts entry.
      [POWERPC] 4xx: Fix Sequoia MAL0 and EMAC dts entries.
      [POWERPC] 4xx: Introduce cpu_setup functionality to 44x platform
      [POWERPC] 4xx: Move 440EP(x) FPU setup from head_44x to cpu_setup_4xx
      [POWERPC] 4xx: 440EPx/GRx incorrect write to DDR SDRAM errata workaround

Wolfgang Denk (1):
      [POWERPC] Disable vDSO support for ARCH=ppc where it's not implemented

Xianghua Xiao (2):
      [POWERPC] Add initial MPC8610 HPCD Device Tree Source file.
      [POWERPC] Add initial MPC8610 HPCD Platform files.

 Documentation/powerpc/booting-without-of.txt       |  335 ++++
 MAINTAINERS                                        |   27 
 arch/powerpc/Kconfig                               |   47 +
 arch/powerpc/Kconfig.debug                         |   31 
 arch/powerpc/Makefile                              |   56 -
 arch/powerpc/boot/.gitignore                       |    9 
 arch/powerpc/boot/44x.c                            |   85 -
 arch/powerpc/boot/44x.h                            |    5 
 arch/powerpc/boot/4xx.c                            |  300 ++++
 arch/powerpc/boot/4xx.h                            |   22 
 arch/powerpc/boot/Makefile                         |   25 
 arch/powerpc/boot/bamboo.c                         |   47 +
 arch/powerpc/boot/cpm-serial.c                     |  269 ++++
 arch/powerpc/boot/cuboot-52xx.c                    |   59 +
 arch/powerpc/boot/cuboot-83xx.c                    |    1 
 arch/powerpc/boot/cuboot-85xx.c                    |    1 
 arch/powerpc/boot/cuboot-8xx.c                     |   47 +
 arch/powerpc/boot/cuboot-bamboo.c                  |   30 
 arch/powerpc/boot/cuboot-hpc2.c                    |   48 +
 arch/powerpc/boot/cuboot-pq2.c                     |  261 +++
 arch/powerpc/boot/cuboot-sequoia.c                 |   56 +
 arch/powerpc/boot/cuboot.c                         |    3 
 arch/powerpc/boot/dcr.h                            |   18 
 arch/powerpc/boot/devtree.c                        |   99 +
 arch/powerpc/boot/dts/bamboo.dts                   |  244 +++
 arch/powerpc/boot/dts/ebony.dts                    |   35 
 arch/powerpc/boot/dts/ep88xc.dts                   |  214 +++
 arch/powerpc/boot/dts/holly.dts                    |    5 
 arch/powerpc/boot/dts/kuroboxHD.dts                |    9 
 arch/powerpc/boot/dts/kuroboxHG.dts                |    9 
 arch/powerpc/boot/dts/lite5200.dts                 |   59 -
 arch/powerpc/boot/dts/lite5200b.dts                |  119 +-
 arch/powerpc/boot/dts/mpc7448hpc2.dts              |    9 
 arch/powerpc/boot/dts/mpc8272ads.dts               |  431 +++---
 arch/powerpc/boot/dts/mpc8313erdb.dts              |   67 -
 arch/powerpc/boot/dts/mpc832x_mds.dts              |  122 +-
 arch/powerpc/boot/dts/mpc832x_rdb.dts              |   72 -
 arch/powerpc/boot/dts/mpc8349emitx.dts             |  104 +
 arch/powerpc/boot/dts/mpc8349emitxgp.dts           |   52 -
 arch/powerpc/boot/dts/mpc834x_mds.dts              |  249 ++-
 arch/powerpc/boot/dts/mpc836x_mds.dts              |  123 +-
 arch/powerpc/boot/dts/mpc8540ads.dts               |  175 +-
 arch/powerpc/boot/dts/mpc8541cds.dts               |  196 +--
 arch/powerpc/boot/dts/mpc8544ds.dts                |  377 +++--
 arch/powerpc/boot/dts/mpc8548cds.dts               |  404 +++--
 arch/powerpc/boot/dts/mpc8555cds.dts               |  196 +--
 arch/powerpc/boot/dts/mpc8560ads.dts               |  185 +-
 arch/powerpc/boot/dts/mpc8568mds.dts               |  160 +-
 arch/powerpc/boot/dts/mpc8572ds.dts                |  404 +++++
 arch/powerpc/boot/dts/mpc8610_hpcd.dts             |  191 +++
 arch/powerpc/boot/dts/mpc8641_hpcn.dts             |  289 ++--
 arch/powerpc/boot/dts/mpc866ads.dts                |    5 
 arch/powerpc/boot/dts/mpc885ads.dts                |  211 ++-
 arch/powerpc/boot/dts/pq2fads.dts                  |  240 +++
 arch/powerpc/boot/dts/prpmc2800.dts                |    5 
 arch/powerpc/boot/dts/sequoia.dts                  |  302 ++++
 arch/powerpc/boot/dts/walnut.dts                   |  190 +++
 arch/powerpc/boot/ebony.c                          |   45 +
 arch/powerpc/boot/ep88xc.c                         |   54 +
 arch/powerpc/boot/fixed-head.S                     |    4 
 arch/powerpc/boot/flatdevtree.c                    |  100 +
 arch/powerpc/boot/flatdevtree.h                    |    8 
 arch/powerpc/boot/flatdevtree_env.h                |   20 
 arch/powerpc/boot/flatdevtree_misc.c               |    8 
 arch/powerpc/boot/fsl-soc.c                        |   57 +
 arch/powerpc/boot/fsl-soc.h                        |    8 
 arch/powerpc/boot/gunzip_util.c                    |    8 
 arch/powerpc/boot/holly.c                          |    5 
 arch/powerpc/boot/io.h                             |   49 +
 arch/powerpc/boot/main.c                           |   10 
 arch/powerpc/boot/mpc52xx-psc.c                    |   69 +
 arch/powerpc/boot/mpc8xx.c                         |   82 +
 arch/powerpc/boot/mpc8xx.h                         |   11 
 arch/powerpc/boot/mpsc.c                           |    1 
 arch/powerpc/boot/mv64x60_i2c.c                    |    2 
 arch/powerpc/boot/of.c                             |    2 
 arch/powerpc/boot/ops.h                            |   36 
 arch/powerpc/boot/planetcore.c                     |  166 ++
 arch/powerpc/boot/planetcore.h                     |   49 +
 arch/powerpc/boot/ppcboot.h                        |    7 
 arch/powerpc/boot/pq2.c                            |  102 +
 arch/powerpc/boot/pq2.h                            |   11 
 arch/powerpc/boot/prpmc2800.c                      |    6 
 arch/powerpc/boot/ps3.c                            |    4 
 arch/powerpc/boot/serial.c                         |   23 
 arch/powerpc/boot/stdlib.c                         |   45 +
 arch/powerpc/boot/stdlib.h                         |    6 
 arch/powerpc/boot/string.S                         |   24 
 arch/powerpc/boot/string.h                         |    2 
 arch/powerpc/boot/treeboot-bamboo.c                |   43 +
 arch/powerpc/boot/treeboot-ebony.c                 |    2 
 arch/powerpc/boot/treeboot-walnut.c                |  131 ++
 arch/powerpc/boot/uartlite.c                       |   79 +
 arch/powerpc/boot/wrapper                          |   20 
 arch/powerpc/configs/bamboo_defconfig              |  775 ++++++++++
 arch/powerpc/configs/ebony_defconfig               |   85 +
 arch/powerpc/configs/ep88xc_defconfig              |  751 ++++++++++
 arch/powerpc/configs/mpc8272_ads_defconfig         |  248 ++-
 arch/powerpc/configs/mpc8544_ds_defconfig          |    2 
 arch/powerpc/configs/mpc8572_ds_defconfig          | 1496 ++++++++++++++++++++
 arch/powerpc/configs/mpc8610_hpcd_defconfig        | 1023 ++++++++++++++
 arch/powerpc/configs/mpc885_ads_defconfig          |  297 ++--
 arch/powerpc/configs/pq2fads_defconfig             | 1003 +++++++++++++
 arch/powerpc/configs/sequoia_defconfig             |  861 ++++++++++++
 arch/powerpc/configs/walnut_defconfig              |  773 ++++++++++
 arch/powerpc/kernel/Makefile                       |   43 -
 arch/powerpc/kernel/align.c                        |  307 ++++
 arch/powerpc/kernel/asm-offsets.c                  |   12 
 arch/powerpc/kernel/btext.c                        |    1 
 arch/powerpc/kernel/clock.c                        |   82 +
 arch/powerpc/kernel/cpu_setup_44x.S                |   56 +
 arch/powerpc/kernel/cputable.c                     |  108 +
 arch/powerpc/kernel/crash.c                        |    1 
 arch/powerpc/kernel/crash_dump.c                   |    4 
 arch/powerpc/kernel/entry_32.S                     |    4 
 arch/powerpc/kernel/entry_64.S                     |    8 
 arch/powerpc/kernel/head_32.S                      |   53 -
 arch/powerpc/kernel/head_40x.S                     |   22 
 arch/powerpc/kernel/head_44x.S                     |   24 
 arch/powerpc/kernel/head_64.S                      |  602 --------
 arch/powerpc/kernel/head_8xx.S                     |   27 
 arch/powerpc/kernel/head_fsl_booke.S               |   90 +
 arch/powerpc/kernel/ibmebus.c                      |    7 
 arch/powerpc/kernel/idle.c                         |    3 
 arch/powerpc/kernel/iomap.c                        |    4 
 arch/powerpc/kernel/iommu.c                        |    1 
 arch/powerpc/kernel/irq.c                          |   97 +
 arch/powerpc/kernel/lparcfg.c                      |    2 
 arch/powerpc/kernel/lparmap.c                      |   32 
 arch/powerpc/kernel/nvram_64.c                     |   23 
 arch/powerpc/kernel/of_platform.c                  |   17 
 arch/powerpc/kernel/pci-common.c                   |    7 
 arch/powerpc/kernel/pci_32.c                       |    4 
 arch/powerpc/kernel/pci_64.c                       |    2 
 arch/powerpc/kernel/pci_dn.c                       |    7 
 arch/powerpc/kernel/ppc_ksyms.c                    |    8 
 arch/powerpc/kernel/process.c                      |   23 
 arch/powerpc/kernel/prom.c                         |   24 
 arch/powerpc/kernel/prom_init.c                    |   23 
 arch/powerpc/kernel/ptrace.c                       |   10 
 arch/powerpc/kernel/ptrace32.c                     |    8 
 arch/powerpc/kernel/rtas_pci.c                     |    4 
 arch/powerpc/kernel/setup-common.c                 |    2 
 arch/powerpc/kernel/setup_32.c                     |   10 
 arch/powerpc/kernel/setup_64.c                     |    9 
 arch/powerpc/kernel/smp.c                          |   29 
 arch/powerpc/kernel/softemu8xx.c                   |  202 +++
 arch/powerpc/kernel/sysfs.c                        |   64 +
 arch/powerpc/kernel/systbl.S                       |    2 
 arch/powerpc/kernel/time.c                         |  503 +++----
 arch/powerpc/kernel/traps.c                        |   85 +
 arch/powerpc/kernel/udbg.c                         |    2 
 arch/powerpc/kernel/udbg_16550.c                   |   11 
 arch/powerpc/kernel/vdso.c                         |    2 
 arch/powerpc/kernel/vdso32/.gitignore              |    1 
 arch/powerpc/kernel/vdso32/Makefile                |   20 
 arch/powerpc/kernel/vdso64/.gitignore              |    1 
 arch/powerpc/kernel/vdso64/Makefile                |   19 
 arch/powerpc/kernel/vio.c                          |  104 -
 arch/powerpc/kernel/vmlinux.lds.S                  |    2 
 arch/powerpc/lib/Makefile                          |    7 
 arch/powerpc/lib/alloc.c                           |   29 
 arch/powerpc/mm/40x_mmu.c                          |    4 
 arch/powerpc/mm/Makefile                           |   15 
 arch/powerpc/mm/fsl_booke_mmu.c                    |    2 
 arch/powerpc/mm/hash_utils_64.c                    |    7 
 arch/powerpc/mm/hugetlbpage.c                      |    3 
 arch/powerpc/mm/init_32.c                          |   41 +
 arch/powerpc/mm/init_64.c                          |    2 
 arch/powerpc/mm/mem.c                              |    1 
 arch/powerpc/mm/mmu_context_64.c                   |   11 
 arch/powerpc/mm/pgtable_64.c                       |    2 
 arch/powerpc/mm/slb.c                              |    6 
 arch/powerpc/mm/slice.c                            |    1 
 arch/powerpc/oprofile/cell/pr_util.h               |    3 
 arch/powerpc/oprofile/op_model_cell.c              |    2 
 arch/powerpc/platforms/40x/Kconfig                 |  127 --
 arch/powerpc/platforms/40x/Makefile                |    2 
 arch/powerpc/platforms/40x/virtex.c                |   45 +
 arch/powerpc/platforms/40x/walnut.c                |   63 +
 arch/powerpc/platforms/44x/Kconfig                 |   32 
 arch/powerpc/platforms/44x/Makefile                |    2 
 arch/powerpc/platforms/44x/bamboo.c                |   61 +
 arch/powerpc/platforms/44x/ebony.c                 |    5 
 arch/powerpc/platforms/44x/sequoia.c               |   61 +
 arch/powerpc/platforms/4xx/Makefile                |    1 
 arch/powerpc/platforms/52xx/Kconfig                |    2 
 arch/powerpc/platforms/52xx/Makefile               |    3 
 arch/powerpc/platforms/52xx/efika.c                |   13 
 arch/powerpc/platforms/52xx/lite5200.c             |   28 
 arch/powerpc/platforms/52xx/lite5200_pm.c          |  213 +++
 arch/powerpc/platforms/52xx/lite5200_sleep.S       |  412 ++++++
 arch/powerpc/platforms/52xx/mpc52xx_pic.c          |   11 
 arch/powerpc/platforms/82xx/Kconfig                |   24 
 arch/powerpc/platforms/82xx/Makefile               |    6 
 arch/powerpc/platforms/82xx/m82xx_pci.h            |    2 
 arch/powerpc/platforms/82xx/mpc8272_ads.c          |  196 +++
 arch/powerpc/platforms/82xx/mpc82xx.c              |  110 -
 arch/powerpc/platforms/82xx/mpc82xx_ads.c          |  641 ---------
 arch/powerpc/platforms/82xx/pq2.c                  |   82 +
 arch/powerpc/platforms/82xx/pq2.h                  |   20 
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c       |  195 +++
 arch/powerpc/platforms/82xx/pq2ads.h               |    9 
 arch/powerpc/platforms/82xx/pq2fads.c              |  198 +++
 arch/powerpc/platforms/83xx/mpc8313_rdb.c          |    4 
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |    6 
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |   52 +
 arch/powerpc/platforms/83xx/mpc834x_itx.c          |    5 
 arch/powerpc/platforms/83xx/mpc834x_mds.c          |    5 
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |    6 
 arch/powerpc/platforms/83xx/mpc83xx.h              |    2 
 arch/powerpc/platforms/83xx/pci.c                  |    7 
 arch/powerpc/platforms/85xx/Kconfig                |   10 
 arch/powerpc/platforms/85xx/Makefile               |    3 
 arch/powerpc/platforms/85xx/misc.c                 |   55 -
 arch/powerpc/platforms/85xx/mpc85xx.h              |   17 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |   19 
 arch/powerpc/platforms/85xx/mpc85xx_cds.c          |   37 
 arch/powerpc/platforms/85xx/mpc85xx_ds.c           |   86 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   54 -
 arch/powerpc/platforms/86xx/Kconfig                |   13 
 arch/powerpc/platforms/86xx/Makefile               |    1 
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |  216 +++
 arch/powerpc/platforms/86xx/mpc8641_hpcn.h         |   21 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c         |   37 
 arch/powerpc/platforms/8xx/Kconfig                 |   28 
 arch/powerpc/platforms/8xx/Makefile                |    1 
 arch/powerpc/platforms/8xx/ep88xc.c                |  176 ++
 arch/powerpc/platforms/8xx/m8xx_setup.c            |  154 +-
 arch/powerpc/platforms/8xx/mpc86xads.h             |    4 
 arch/powerpc/platforms/8xx/mpc86xads_setup.c       |   25 
 arch/powerpc/platforms/8xx/mpc885ads.h             |   42 -
 arch/powerpc/platforms/8xx/mpc885ads_setup.c       |  472 ++----
 arch/powerpc/platforms/Kconfig                     |   32 
 arch/powerpc/platforms/Kconfig.cputype             |   14 
 arch/powerpc/platforms/Makefile                    |    2 
 arch/powerpc/platforms/cell/Makefile               |    4 
 arch/powerpc/platforms/cell/axon_msi.c             |   35 
 arch/powerpc/platforms/cell/cbe_cpufreq.c          |    2 
 .../powerpc/platforms/cell/cbe_cpufreq_pervasive.c |    2 
 arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c      |    2 
 arch/powerpc/platforms/cell/cbe_regs.c             |    3 
 arch/powerpc/platforms/cell/cbe_thermal.c          |    2 
 arch/powerpc/platforms/cell/interrupt.c            |    4 
 arch/powerpc/platforms/cell/iommu.c                |    2 
 arch/powerpc/platforms/cell/pervasive.c            |    2 
 arch/powerpc/platforms/cell/pmu.c                  |    2 
 arch/powerpc/platforms/cell/ras.c                  |    2 
 arch/powerpc/platforms/cell/setup.c                |   17 
 arch/powerpc/platforms/cell/spider-pic.c           |   22 
 arch/powerpc/platforms/cell/spu_base.c             |    2 
 arch/powerpc/platforms/cell/spu_callbacks.c        |    4 
 arch/powerpc/platforms/cell/spu_coredump.c         |   79 -
 arch/powerpc/platforms/cell/spu_manage.c           |    4 
 arch/powerpc/platforms/cell/spu_syscalls.c         |  142 +-
 arch/powerpc/platforms/cell/spufs/coredump.c       |  236 ++-
 arch/powerpc/platforms/cell/spufs/file.c           |  251 +--
 arch/powerpc/platforms/cell/spufs/inode.c          |   15 
 arch/powerpc/platforms/cell/spufs/run.c            |    4 
 arch/powerpc/platforms/cell/spufs/sched.c          |   49 -
 arch/powerpc/platforms/cell/spufs/spufs.h          |    7 
 arch/powerpc/platforms/cell/spufs/switch.c         |   29 
 arch/powerpc/platforms/cell/spufs/syscalls.c       |   48 -
 arch/powerpc/platforms/celleb/Kconfig              |    1 
 arch/powerpc/platforms/celleb/Makefile             |    5 
 arch/powerpc/platforms/celleb/beat.c               |  106 +
 arch/powerpc/platforms/celleb/beat.h               |    2 
 arch/powerpc/platforms/celleb/beat_syscall.h       |    4 
 arch/powerpc/platforms/celleb/beat_wrapper.h       |   68 +
 arch/powerpc/platforms/celleb/htab.c               |  130 ++
 arch/powerpc/platforms/celleb/interrupt.c          |    9 
 arch/powerpc/platforms/celleb/io-workarounds.c     |  279 ++++
 arch/powerpc/platforms/celleb/pci.c                |   98 +
 arch/powerpc/platforms/celleb/pci.h                |    9 
 arch/powerpc/platforms/celleb/scc.h                |    2 
 arch/powerpc/platforms/celleb/scc_epci.c           |   88 +
 arch/powerpc/platforms/celleb/scc_sio.c            |   56 -
 arch/powerpc/platforms/celleb/setup.c              |   27 
 arch/powerpc/platforms/chrp/gg2.h                  |   61 +
 arch/powerpc/platforms/chrp/pci.c                  |   39 -
 arch/powerpc/platforms/chrp/setup.c                |   13 
 arch/powerpc/platforms/chrp/smp.c                  |    2 
 arch/powerpc/platforms/embedded6xx/Kconfig         |   12 
 arch/powerpc/platforms/embedded6xx/holly.c         |   14 
 arch/powerpc/platforms/embedded6xx/linkstation.c   |    8 
 arch/powerpc/platforms/embedded6xx/ls_uart.c       |   18 
 arch/powerpc/platforms/embedded6xx/mpc10x.h        |  180 ++
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c  |    5 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h  |   21 
 arch/powerpc/platforms/embedded6xx/prpmc2800.c     |    8 
 arch/powerpc/platforms/iseries/Makefile            |    3 
 arch/powerpc/platforms/iseries/dt.c                |   17 
 arch/powerpc/platforms/iseries/exception.S         |  251 +++
 arch/powerpc/platforms/iseries/exception.h         |   58 +
 arch/powerpc/platforms/iseries/iommu.c             |   52 +
 arch/powerpc/platforms/iseries/irq.c               |   10 
 arch/powerpc/platforms/iseries/it_lp_naca.h        |    2 
 arch/powerpc/platforms/iseries/mf.c                |   23 
 arch/powerpc/platforms/iseries/setup.c             |    7 
 arch/powerpc/platforms/iseries/vio.c               |  553 +++++++
 arch/powerpc/platforms/iseries/viopath.c           |    8 
 arch/powerpc/platforms/maple/pci.c                 |   21 
 arch/powerpc/platforms/pasemi/Kconfig              |    1 
 arch/powerpc/platforms/pasemi/gpio_mdio.c          |    4 
 arch/powerpc/platforms/pasemi/idle.c               |    8 
 arch/powerpc/platforms/pasemi/iommu.c              |    4 
 arch/powerpc/platforms/pasemi/pasemi.h             |    4 
 arch/powerpc/platforms/pasemi/pci.c                |   74 +
 arch/powerpc/platforms/pasemi/setup.c              |  134 ++
 arch/powerpc/platforms/powermac/bootx_init.c       |    1 
 arch/powerpc/platforms/powermac/low_i2c.c          |    1 
 arch/powerpc/platforms/powermac/pci.c              |   25 
 arch/powerpc/platforms/powermac/pic.c              |    2 
 arch/powerpc/platforms/powermac/pmac.h             |    4 
 arch/powerpc/platforms/powermac/setup.c            |   77 -
 arch/powerpc/platforms/powermac/udbg_adb.c         |    5 
 arch/powerpc/platforms/ps3/device-init.c           |   24 
 arch/powerpc/platforms/ps3/interrupt.c             |    9 
 arch/powerpc/platforms/ps3/os-area.c               |  646 ++++++++-
 arch/powerpc/platforms/ps3/platform.h              |   10 
 arch/powerpc/platforms/ps3/setup.c                 |    3 
 arch/powerpc/platforms/ps3/time.c                  |   14 
 arch/powerpc/platforms/pseries/eeh.c               |   54 -
 arch/powerpc/platforms/pseries/eeh_cache.c         |    9 
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   14 
 arch/powerpc/platforms/pseries/lpar.c              |    1 
 arch/powerpc/platforms/pseries/msi.c               |   35 
 arch/powerpc/platforms/pseries/rtasd.c             |   99 +
 arch/powerpc/platforms/pseries/setup.c             |    5 
 arch/powerpc/platforms/pseries/xics.c              |    2 
 arch/powerpc/sysdev/Makefile                       |   10 
 arch/powerpc/sysdev/axonram.c                      |    8 
 arch/powerpc/sysdev/commproc.c                     |  299 +++-
 arch/powerpc/sysdev/commproc.h                     |   12 
 arch/powerpc/sysdev/cpm2_common.c                  |  178 ++
 arch/powerpc/sysdev/cpm2_pic.c                     |   13 
 arch/powerpc/sysdev/cpm_common.c                   |  205 +++
 arch/powerpc/sysdev/dart_iommu.c                   |    4 
 arch/powerpc/sysdev/dcr.c                          |    6 
 arch/powerpc/sysdev/fsl_pci.c                      |    7 
 arch/powerpc/sysdev/fsl_soc.c                      |  187 ++-
 arch/powerpc/sysdev/fsl_soc.h                      |    8 
 arch/powerpc/sysdev/i8259.c                        |    8 
 arch/powerpc/sysdev/indirect_pci.c                 |    4 
 arch/powerpc/sysdev/ipic.c                         |    7 
 arch/powerpc/sysdev/ipic.h                         |    3 
 arch/powerpc/sysdev/mpc8xx_pic.c                   |   30 
 arch/powerpc/sysdev/mpic.c                         |   53 -
 arch/powerpc/sysdev/mpic.h                         |    1 
 arch/powerpc/sysdev/mpic_msi.c                     |   13 
 arch/powerpc/sysdev/mpic_u3msi.c                   |   36 
 arch/powerpc/sysdev/mv64x60.h                      |    1 
 arch/powerpc/sysdev/mv64x60_pic.c                  |   12 
 arch/powerpc/sysdev/mv64x60_udbg.c                 |  152 ++
 arch/powerpc/sysdev/pmi.c                          |    6 
 arch/powerpc/sysdev/qe_lib/qe.c                    |   36 
 arch/powerpc/sysdev/qe_lib/qe_ic.c                 |   38 -
 arch/powerpc/sysdev/qe_lib/qe_ic.h                 |    3 
 arch/powerpc/sysdev/qe_lib/qe_io.c                 |   38 -
 arch/powerpc/sysdev/qe_lib/ucc.c                   |  270 ++--
 arch/powerpc/sysdev/qe_lib/ucc_fast.c              |  127 +-
 arch/powerpc/sysdev/qe_lib/ucc_slow.c              |   48 -
 arch/powerpc/sysdev/timer.c                        |   81 -
 arch/powerpc/sysdev/tsi108_pci.c                   |   16 
 arch/powerpc/sysdev/uic.c                          |   75 +
 arch/powerpc/sysdev/xilinx_intc.c                  |  151 ++
 arch/ppc/.gitignore                                |    2 
 arch/ppc/8xx_io/enet.c                             |    1 
 arch/ppc/Kconfig                                   |  154 --
 arch/ppc/Makefile                                  |    1 
 arch/ppc/amiga/Makefile                            |    8 
 arch/ppc/amiga/amiga_ksyms.c                       |    1 
 arch/ppc/amiga/amiints.c                           |  322 ----
 arch/ppc/amiga/amisound.c                          |    1 
 arch/ppc/amiga/bootinfo.c                          |   78 -
 arch/ppc/amiga/chipram.c                           |    1 
 arch/ppc/amiga/cia.c                               |  176 --
 arch/ppc/amiga/config.c                            |  953 -------------
 arch/ppc/amiga/ints.c                              |  158 --
 arch/ppc/amiga/pcmcia.c                            |    1 
 arch/ppc/amiga/time.c                              |   57 -
 arch/ppc/boot/simple/embed_config.c                |    8 
 arch/ppc/boot/simple/misc-embedded.c               |    4 
 arch/ppc/boot/simple/uartlite_tty.c                |    8 
 arch/ppc/configs/apus_defconfig                    |  920 ------------
 arch/ppc/kernel/head.S                             |  117 --
 arch/ppc/kernel/head_44x.S                         |   10 
 arch/ppc/kernel/ppc_ksyms.c                        |    3 
 arch/ppc/kernel/setup.c                            |    1 
 arch/ppc/kernel/vmlinux.lds.S                      |    2 
 arch/ppc/mm/pgtable.c                              |   38 -
 arch/ppc/platforms/Makefile                        |    4 
 arch/ppc/platforms/apus_pci.c                      |  207 ---
 arch/ppc/platforms/apus_pci.h                      |   34 
 arch/ppc/platforms/apus_setup.c                    |  798 -----------
 arch/ppc/platforms/ev64360.c                       |    3 
 arch/ppc/platforms/katana.c                        |    3 
 arch/ppc/syslib/ocp.c                              |    2 
 arch/ppc/syslib/virtex_devices.h                   |    8 
 drivers/block/viodasd.c                            |   77 -
 drivers/cdrom/viocd.c                              |  128 --
 drivers/char/hvc_beat.c                            |    4 
 drivers/char/ipmi/ipmi_si_intf.c                   |    6 
 drivers/char/viotape.c                             |  125 --
 drivers/macintosh/adb-iop.c                        |    1 
 drivers/macintosh/adbhid.c                         |   21 
 drivers/macintosh/ans-lcd.c                        |    3 
 drivers/macintosh/ans-lcd.h                        |    0 
 drivers/macintosh/therm_adt746x.c                  |    5 
 drivers/macintosh/via-pmu.c                        |    2 
 drivers/macintosh/windfarm_smu_sat.c               |    2 
 drivers/misc/hdpuftrs/hdpu_cpustate.c              |  107 +
 drivers/misc/hdpuftrs/hdpu_nexus.c                 |   88 +
 drivers/mtd/maps/Kconfig                           |    2 
 drivers/mtd/maps/physmap_of.c                      |  349 +++--
 drivers/net/ucc_geth.c                             |    2 
 drivers/net/ucc_geth.h                             |    1 
 drivers/net/ucc_geth_mii.c                         |    1 
 drivers/serial/Kconfig                             |   25 
 drivers/serial/cpm_uart/cpm_uart.h                 |   48 -
 drivers/serial/cpm_uart/cpm_uart_core.c            |  539 +++++--
 drivers/serial/cpm_uart/cpm_uart_cpm1.c            |   18 
 drivers/serial/cpm_uart/cpm_uart_cpm1.h            |   16 
 drivers/serial/cpm_uart/cpm_uart_cpm2.c            |   24 
 drivers/serial/cpm_uart/cpm_uart_cpm2.h            |   16 
 drivers/serial/mpc52xx_uart.c                      |    2 
 drivers/serial/pmac_zilog.c                        |   22 
 drivers/serial/uartlite.c                          |  286 +++-
 drivers/video/platinumfb.c                         |   48 -
 drivers/video/xilinxfb.c                           |    2 
 fs/binfmt_elf.c                                    |   14 
 include/asm-powerpc/8xx_immap.h                    |  564 ++++++++
 include/asm-powerpc/atomic.h                       |   34 
 include/asm-powerpc/cell-regs.h                    |   48 +
 include/asm-powerpc/clk_interface.h                |   20 
 include/asm-powerpc/commproc.h                     |  755 ++++++++++
 include/asm-powerpc/cpm.h                          |   14 
 include/asm-powerpc/cpm2.h                         | 1270 +++++++++++++++++
 include/asm-powerpc/cputable.h                     |   37 
 include/asm-powerpc/dcr-mmio.h                     |    6 
 include/asm-powerpc/dcr-native.h                   |    6 
 include/asm-powerpc/dma-mapping.h                  |   24 
 include/asm-powerpc/elf.h                          |    9 
 include/asm-powerpc/exception.h                    |  311 ++++
 include/asm-powerpc/fs_pd.h                        |   38 -
 include/asm-powerpc/highmem.h                      |  135 ++
 include/asm-powerpc/hydra.h                        |  102 +
 include/asm-powerpc/ide.h                          |    2 
 include/asm-powerpc/immap_86xx.h                   |  219 ++-
 include/asm-powerpc/immap_cpm2.h                   |  650 +++++++++
 include/asm-powerpc/immap_qe.h                     |   35 
 include/asm-powerpc/io.h                           |   28 
 include/asm-powerpc/irq.h                          |    8 
 include/asm-powerpc/iseries/hv_call_event.h        |   10 
 include/asm-powerpc/iseries/iommu.h                |    4 
 include/asm-powerpc/iseries/lpar_map.h             |    3 
 include/asm-powerpc/iseries/vio.h                  |  116 +-
 include/asm-powerpc/kgdb.h                         |   57 +
 include/asm-powerpc/lmb.h                          |    6 
 include/asm-powerpc/machdep.h                      |    2 
 include/asm-powerpc/mmu-40x.h                      |   65 +
 include/asm-powerpc/mmu-hash64.h                   |    1 
 include/asm-powerpc/mmu.h                          |    3 
 include/asm-powerpc/mpc52xx.h                      |   10 
 include/asm-powerpc/mpc52xx_psc.h                  |  191 +++
 include/asm-powerpc/mpic.h                         |   13 
 include/asm-powerpc/nvram.h                        |    6 
 include/asm-powerpc/paca.h                         |   11 
 include/asm-powerpc/page_64.h                      |    9 
 include/asm-powerpc/percpu.h                       |    2 
 include/asm-powerpc/pgtable-4k.h                   |    2 
 include/asm-powerpc/pgtable-64k.h                  |    2 
 include/asm-powerpc/ppc_asm.h                      |   18 
 include/asm-powerpc/processor.h                    |    4 
 include/asm-powerpc/prom.h                         |    3 
 include/asm-powerpc/ps3.h                          |    9 
 include/asm-powerpc/qe.h                           |  246 ++-
 include/asm-powerpc/qe_ic.h                        |   68 +
 include/asm-powerpc/reg.h                          |   52 -
 include/asm-powerpc/rwsem.h                        |    4 
 include/asm-powerpc/smp.h                          |    2 
 include/asm-powerpc/spu.h                          |   28 
 include/asm-powerpc/system.h                       |    3 
 include/asm-powerpc/time.h                         |    3 
 include/asm-powerpc/tlb.h                          |    2 
 include/asm-powerpc/types.h                        |    2 
 include/asm-powerpc/ucc.h                          |   40 -
 include/asm-powerpc/ucc_slow.h                     |    9 
 include/asm-powerpc/udbg.h                         |    1 
 include/asm-powerpc/vio.h                          |    6 
 include/asm-powerpc/xilinx_intc.h                  |   20 
 include/asm-ppc/amigahw.h                          |   16 
 include/asm-ppc/amigaints.h                        |  133 --
 include/asm-ppc/amigappc.h                         |   85 -
 include/asm-ppc/bootinfo.h                         |    5 
 include/asm-ppc/io.h                               |   51 -
 include/asm-ppc/machdep.h                          |    4 
 include/asm-ppc/ocp.h                              |    2 
 include/asm-ppc/page.h                             |   44 -
 include/asm-ppc/pgtable.h                          |    8 
 include/asm-ppc/prom.h                             |    1 
 include/linux/elf.h                                |   14 
 include/linux/of.h                                 |    1 
 include/linux/pci_ids.h                            |    3 
 include/linux/xilinxfb.h                           |   23 
 lib/Kconfig.debug                                  |    2 
 506 files changed, 28847 insertions(+), 12688 deletions(-)
 delete mode 100644 arch/powerpc/boot/44x.c
 create mode 100644 arch/powerpc/boot/4xx.c
 create mode 100644 arch/powerpc/boot/4xx.h
 create mode 100644 arch/powerpc/boot/bamboo.c
 create mode 100644 arch/powerpc/boot/cpm-serial.c
 create mode 100644 arch/powerpc/boot/cuboot-52xx.c
 create mode 100644 arch/powerpc/boot/cuboot-8xx.c
 create mode 100644 arch/powerpc/boot/cuboot-bamboo.c
 create mode 100644 arch/powerpc/boot/cuboot-hpc2.c
 create mode 100644 arch/powerpc/boot/cuboot-pq2.c
 create mode 100644 arch/powerpc/boot/cuboot-sequoia.c
 create mode 100644 arch/powerpc/boot/dts/bamboo.dts
 create mode 100644 arch/powerpc/boot/dts/ep88xc.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8572ds.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8610_hpcd.dts
 create mode 100644 arch/powerpc/boot/dts/pq2fads.dts
 create mode 100644 arch/powerpc/boot/dts/sequoia.dts
 create mode 100644 arch/powerpc/boot/dts/walnut.dts
 create mode 100644 arch/powerpc/boot/ep88xc.c
 create mode 100644 arch/powerpc/boot/fixed-head.S
 create mode 100644 arch/powerpc/boot/fsl-soc.c
 create mode 100644 arch/powerpc/boot/fsl-soc.h
 create mode 100644 arch/powerpc/boot/mpc52xx-psc.c
 create mode 100644 arch/powerpc/boot/mpc8xx.c
 create mode 100644 arch/powerpc/boot/mpc8xx.h
 create mode 100644 arch/powerpc/boot/planetcore.c
 create mode 100644 arch/powerpc/boot/planetcore.h
 create mode 100644 arch/powerpc/boot/pq2.c
 create mode 100644 arch/powerpc/boot/pq2.h
 create mode 100644 arch/powerpc/boot/stdlib.c
 create mode 100644 arch/powerpc/boot/stdlib.h
 create mode 100644 arch/powerpc/boot/treeboot-bamboo.c
 create mode 100644 arch/powerpc/boot/treeboot-walnut.c
 create mode 100644 arch/powerpc/boot/uartlite.c
 create mode 100644 arch/powerpc/configs/bamboo_defconfig
 create mode 100644 arch/powerpc/configs/ep88xc_defconfig
 create mode 100644 arch/powerpc/configs/mpc8572_ds_defconfig
 create mode 100644 arch/powerpc/configs/mpc8610_hpcd_defconfig
 create mode 100644 arch/powerpc/configs/pq2fads_defconfig
 create mode 100644 arch/powerpc/configs/sequoia_defconfig
 create mode 100644 arch/powerpc/configs/walnut_defconfig
 create mode 100644 arch/powerpc/kernel/clock.c
 create mode 100644 arch/powerpc/kernel/cpu_setup_44x.S
 rename arch/powerpc/kernel/{head_4xx.S => head_40x.S} (98%)
 delete mode 100644 arch/powerpc/kernel/lparmap.c
 create mode 100644 arch/powerpc/kernel/softemu8xx.c
 create mode 100644 arch/powerpc/lib/alloc.c
 rename arch/powerpc/mm/{4xx_mmu.c => 40x_mmu.c} (96%)
 rename arch/powerpc/platforms/{4xx/Kconfig => 40x/Kconfig} (58%)
 create mode 100644 arch/powerpc/platforms/40x/Makefile
 create mode 100644 arch/powerpc/platforms/40x/virtex.c
 create mode 100644 arch/powerpc/platforms/40x/walnut.c
 create mode 100644 arch/powerpc/platforms/44x/bamboo.c
 create mode 100644 arch/powerpc/platforms/44x/sequoia.c
 delete mode 100644 arch/powerpc/platforms/4xx/Makefile
 create mode 100644 arch/powerpc/platforms/52xx/lite5200_pm.c
 create mode 100644 arch/powerpc/platforms/52xx/lite5200_sleep.S
 create mode 100644 arch/powerpc/platforms/82xx/mpc8272_ads.c
 delete mode 100644 arch/powerpc/platforms/82xx/mpc82xx.c
 delete mode 100644 arch/powerpc/platforms/82xx/mpc82xx_ads.c
 create mode 100644 arch/powerpc/platforms/82xx/pq2.c
 create mode 100644 arch/powerpc/platforms/82xx/pq2.h
 create mode 100644 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
 create mode 100644 arch/powerpc/platforms/82xx/pq2fads.c
 delete mode 100644 arch/powerpc/platforms/85xx/misc.c
 delete mode 100644 arch/powerpc/platforms/85xx/mpc85xx.h
 rename arch/powerpc/platforms/85xx/{mpc8544_ds.c => mpc85xx_ds.c} (66%)
 create mode 100644 arch/powerpc/platforms/86xx/mpc8610_hpcd.c
 delete mode 100644 arch/powerpc/platforms/86xx/mpc8641_hpcn.h
 create mode 100644 arch/powerpc/platforms/8xx/ep88xc.c
 delete mode 100644 arch/powerpc/platforms/cell/spu_coredump.c
 create mode 100644 arch/powerpc/platforms/celleb/io-workarounds.c
 create mode 100644 arch/powerpc/platforms/chrp/gg2.h
 create mode 100644 arch/powerpc/platforms/embedded6xx/mpc10x.h
 delete mode 100644 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h
 create mode 100644 arch/powerpc/platforms/iseries/exception.S
 create mode 100644 arch/powerpc/platforms/iseries/exception.h
 create mode 100644 arch/powerpc/platforms/iseries/vio.c
 create mode 100644 arch/powerpc/sysdev/commproc.h
 create mode 100644 arch/powerpc/sysdev/cpm_common.c
 create mode 100644 arch/powerpc/sysdev/mv64x60_udbg.c
 delete mode 100644 arch/powerpc/sysdev/timer.c
 create mode 100644 arch/powerpc/sysdev/xilinx_intc.c
 delete mode 100644 arch/ppc/amiga/Makefile
 delete mode 100644 arch/ppc/amiga/amiga_ksyms.c
 delete mode 100644 arch/ppc/amiga/amiints.c
 delete mode 100644 arch/ppc/amiga/amisound.c
 delete mode 100644 arch/ppc/amiga/bootinfo.c
 delete mode 100644 arch/ppc/amiga/chipram.c
 delete mode 100644 arch/ppc/amiga/cia.c
 delete mode 100644 arch/ppc/amiga/config.c
 delete mode 100644 arch/ppc/amiga/ints.c
 delete mode 100644 arch/ppc/amiga/pcmcia.c
 delete mode 100644 arch/ppc/amiga/time.c
 delete mode 100644 arch/ppc/configs/apus_defconfig
 delete mode 100644 arch/ppc/platforms/apus_pci.c
 delete mode 100644 arch/ppc/platforms/apus_pci.h
 delete mode 100644 arch/ppc/platforms/apus_setup.c
 rename include/asm-ppc/ans-lcd.h => drivers/macintosh/ans-lcd.h (100%)
 create mode 100644 include/asm-powerpc/8xx_immap.h
 rename arch/powerpc/platforms/cell/cbe_regs.h => include/asm-powerpc/cell-regs.h (76%)
 create mode 100644 include/asm-powerpc/clk_interface.h
 create mode 100644 include/asm-powerpc/commproc.h
 create mode 100644 include/asm-powerpc/cpm.h
 create mode 100644 include/asm-powerpc/cpm2.h
 create mode 100644 include/asm-powerpc/exception.h
 create mode 100644 include/asm-powerpc/highmem.h
 create mode 100644 include/asm-powerpc/hydra.h
 create mode 100644 include/asm-powerpc/immap_cpm2.h
 create mode 100644 include/asm-powerpc/kgdb.h
 create mode 100644 include/asm-powerpc/mmu-40x.h
 create mode 100644 include/asm-powerpc/mpc52xx_psc.h
 create mode 100644 include/asm-powerpc/xilinx_intc.h
 delete mode 100644 include/asm-ppc/amigahw.h
 delete mode 100644 include/asm-ppc/amigaints.h
 delete mode 100644 include/asm-ppc/amigappc.h
 create mode 100644 include/linux/xilinxfb.h
