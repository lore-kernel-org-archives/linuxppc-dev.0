Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18330.53318.857148.409675@cargo.ozlabs.ibm.com>
Date: Sat, 26 Jan 2008 17:16:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to for-2.6.25/master branches of powerpc.git
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This includes commits pulled from Josh Boyer, Kumar Gala, Grant
Likely, and Olof Johansson.  I reverted the "Fake NUMA emulation for
PowerPC" commit because it changed behaviour even when the fake numa
command-line option wasn't given.

I'll be asking Linus to pull within the next few days, so please
remind me about anything else that should go in 2.6.25.

Paul.

Anton Vorontsov (4):
      libata: pata_platform: make probe and remove functions device type neutral
      libata: pata_of_platform: OF-Platform PATA device driver
      [POWERPC] booting-without-of: localbus should not include board name
      [POWERPC] MPC8349E-mITX: introduce localbus and pata nodes

Becky Bruce (1):
      [POWERPC] Fixup use of phys_addr_t in mpic code

Benjamin Herrenschmidt (20):
      [POWERPC] Reworking machine check handling and Fix 440/440A
      [POWERPC] 4xx: Improve support for 4xx indirect DCRs
      [POWERPC] 4xx: PLB to PCI-X support
      [POWERPC] 4xx: PLB to PCI 2.x support
      [POWERPC] 4xx: PLB to PCI Express support
      [POWERPC] 4xx: PCI support for Ebony board
      [POWERPC] 4xx: Add early udbg support for 40x processors
      [POWERPC] 4xx: EP405 boards support for arch/powerpc
      [POWERPC] 4xx: Add PCI to Walnut platform
      [POWERPC] 4xx: Wire up PCI on Bamboo board
      [POWERPC] 4xx: Wire up 440EP USB controller support to Bamboo board
      [POWERPC] 4xx: Adds decoding of 440SPE memory size to boot wrapper library
      [POWERPC] 4xx: Add mfspr/mtspr inline macros to 4xx bootwrapper
      [POWERPC] 4xx: Add CPR0 accessors to boot wrapper
      [POWERPC] 4xx: Rework clock probing in boot wrapper
      [POWERPC] 4xx: Base support for 440SPe "Katmai" eval board
      [POWERPC] 4xx: remove bogus "ranges" property in Bamboo EBC node
      [POWERPC] 4xx: PCI-E Link setup improvements
      [POWERPC] pci32: 4xx embedded platforms want to reassign all PCI resources
      [POWERPC] Always hookup PHB IO resource even when empty

Cyrill Gorcunov (3):
      [POWERPC] Use for_each macros in arch/powerpc/sysdev
      [POWERPC] Use for_each macros in arch/powerpc/kernel
      [POWERPC] Use for_each macros in arch/powerpc/platforms/powermac

Dale Farnsworth (1):
      [POWERPC] 85xx: Respect KERNELBASE, PAGE_OFFSET, and PHYSICAL_START on e500

David Gibson (1):
      [POWERPC] Enable RTC for Ebony and Walnut (v2)

Geert Uytterhoeven (10):
      [POWERPC] Kill sparse warning in HPTE_V_COMPARE()
      [POWERPC] PS3: Make bus_id and dev_id u64
      [POWERPC] PS3: Add ps3_repository_find_device_by_id()
      [POWERPC] PS3: Use the HVs storage device notification mechanism properly
      [POWERPC] PS3: Add repository polling loop to work around timing bug
      [POWERPC] PS3: Kill unused ps3_repository_bump_device()
      [POWERPC] PS3: Refactor ps3_repository_find_device()
      [POWERPC] PS3: Checkpatch cleanups for drivers/ps3/ps3-sys-manager.c
      [POWERPC] PS3: Checkpatch cleanups for drivers/ps3/ps3-vuart.c
      [POWERPC] PS3: Checkpatch cleanups for arch/powerpc/platforms/ps3/repository.c

Geoff Levand (5):
      [POWERPC] Add definition of Cell bookmark SPR
      [POWERPC] PS3: Add logical performance monitor device support
      [POWERPC] PS3: Vuart: change semaphore to mutex
      [POWERPC] PS3: Remove lpar address workaround
      [POWERPC] PS3: Update ps3_defconfig

Grant Likely (8):
      [POWERPC] 4xx: typo in calling machine_device_initcall() for Sequoia board
      [POWERPC] pasemi: Use machine_*_initcall() hooks in platform code
      [POWERPC] Add of_find_matching_node() helper function
      [POWERPC] powermac: Use machine_*_initcall() hooks in platform code
      [POWERPC] cell: Use machine_*_initcall() hooks in platform code
      [POWERPC] mpc5200: eliminate mpc52xx_*_map_*() functions.
      [POWERPC] mpc5200: merge defconfigs for all mpc5200 boards
      [POWERPC] 8xx: Use machine_*_initcall() hooks in platform code

Hollis Blanchard (1):
      [POWERPC] 4xx: enable built-in networking for Sequoia defconfig

Hugh Blemings (1):
      [POWERPC] 4xx: Base support for 440GX Taishan eval board

Jochen Friedrich (2):
      [POWERPC] Update .gitignore files
      fs_enet: Add fixed-phy support for fs_enet

John Rigby (4):
      [POWERPC] Separate MPC52xx PSC FIFO registers from rest of PSC
      [POWERPC] mpc5200: Cleanup checkpatch.pl problems in mpc52xx_uart.c
      [POWERPC] Add support for mpc512x interrupts to ipic
      [POWERPC] Add IPIC Kconfig option

Jon Loeliger (5):
      [POWERPC] Use <linux/of_{platform, device}.h> and not <asm/...> variants.
      [POWERPC] Add _nmask_and_or_msr() declartion to asm-powerpc/system.h
      [POWERPC] Add StorCenter DTS first draft.
      [POWERPC] Add initial iomega StorCenter board port.
      [POWERPC] Add initial storcenter config file.

Jon Tollefson (1):
      [POWERPC] Add hugepagesz boot-time parameter

Joseph Fannin (1):
      [POWERPC] Export copy_page() on 32bit

Josh Boyer (11):
      [POWERPC] 4xx: Fix 440grx setup function to call 440A fixup
      [POWERPC] 4xx: Include missing header
      [POWERPC] 4xx: libfdt and pci fixes for Rainier
      [POWERPC] 4xx: Rename CPU nodes to avoid dtc incompatibility
      [POWERPC] 4xx: Update Kilauea, Rainier, and Walnut defconfigs
      [POWERPC] 4xx: Mark of_bus structures as __initdata
      [POWERPC] Conditionally compile e200 and e500 platforms in cputable
      [POWERPC] Remove unneeded variable declarations from mpc837x_mds
      [POWERPC] 4xx: Use machine_device_initcall for bus probe
      [POWERPC] 4xx: Minor coding style cleanups for 4xx bootwrapper
      [POWERPC] 4xx: Update defconfigs

Kumar Gala (13):
      [POWERPC] Fix handling of memreserve if the range lands in highmem
      [POWERPC] Ensure we only handle PowerMac PCI bus fixup for memory resources
      [POWERPC] Fixup transparent P2P resources
      [POWERPC] FSL: Rework PCI/PCIe support for 85xx/86xx
      [POWERPC] Remove update_bridge_resource
      [POWERPC] 85xx: convert boards to use machine_device_initcall
      [POWERPC] 83xx: convert boards to use machine_device_initcall
      [POWERPC] bootwrapper: Add find_node_by_alias and dt_fixup_mac_address_by_alias
      [POWERPC] bootwrapper: convert cuboot-8{3,5}xx to dt_fixup_mac_address_by_alias
      [POWERPC] Fix incorrect interrupt map on FSL reference boards
      [RAPIDIO] Fix compile error and warning
      [POWERPC] Move RapidIO support code from arch/ppc
      [POWERPC] Fix compile error if CONFIG_STX_GP3 is defined

Li Yang (3):
      [POWERPC] 83xx: add device trees for MPC837x MDS board
      [POWERPC] 83xx: Add MPC837x USB platform support
      [POWERPC] 83xx: USB device tree cleanups

Liu Yu (1):
      [POWERPC] Fix carry bug in 128-bit unsigned integer adding

Marian Balakowicz (6):
      [POWERPC] mpc5200: Add 'fsl,lpb' bus type for localplus bus
      [POWERPC] mpc5200: Add common mpc52xx_setup_pci() routine
      [POWERPC] mpc5200: Add TQM5200 DTS
      [POWERPC] mpc5200: add CM5200 DTS
      [POWERPC] mpc5200: Add Promess Motion-PRO DTS
      [POWERPC] mpc5200: Add generic support for simple MPC5200 based boards

Mark A. Greer (1):
      [POWERPC] #address-cells & #size-cells properties are not inherited

Matthias Fuchs (1):
      [POWERPC] 4xx: Add 405GPr and 405EP support in boot wrapper

Michael Ellerman (8):
      [POWERPC] Set archdata.dma_data for direct DMA in cell_dma_dev_setup()
      [POWERPC] Add celleb_dma_dev_setup()
      [POWERPC] Use archdata.dma_data in dma_direct_ops and add the offset
      [POWERPC] Have cell use its own dma_direct_offset variable
      [POWERPC] Have celleb use its own dma_direct_offset variable
      [POWERPC] Remove the global dma_direct_offset
      [POWERPC] Remove bogus comment in dma_direct_alloc_coherent()
      [POWERPC] Make IOMMU code safe for > 132 GB of memory

Michael Neuling (2):
      [POWERPC] Make setjmp/longjmp code usable outside of xmon
      [POWERPC] kdump shutdown hook support

Olaf Hering (2):
      [POWERPC] Revert chrp_pci_fixup_vt8231_ata devinit to fix libata on pegasos
      [POWERPC] Autodetect serial console on pegasos2

Olof Johansson (7):
      [POWERPC] pasemi: Implement NMI support
      [POWERPC] pasemi: Distribute interrupts evenly across cpus
      [POWERPC] Enable CONFIG_PCI_MSI and CONFIG_MD in pasemi_defconfig
      [POWERPC] pasemi: Fix NMI handling check
      [POWERPC] pasemi: Move electra-ide to pata_of_platform
      [POWERPC] Make smp_call_function_map static
      [POWERPC] Make smp_send_stop() handle panic and xmon reboot

Paul Gortmaker (1):
      [POWERPC] 85xx: mpc85xx_ads: add in missing of_node_put()

Paul Mackerras (3):
      Revert "[POWERPC] Disable PCI IO/Mem on a device when resources can't be allocated"
      [POWERPC] Provide a way to protect 4k subpages when using 64k pages
      Revert "[POWERPC] Fake NUMA emulation for PowerPC"

Roel Kluin (1):
      [POWERPC] 4xx: logical/bitand typo in powerpc/boot/4xx.c

Scott Wood (7):
      [POWERPC] fsl_soc: Fix get_immrbase() to use ranges, rather than reg.
      [POWERPC] 8xx: Analogue & Micro Adder875 board support.
      [POWERPC] 82xx: Embedded Planet EP8248E support
      [POWERPC] 83xx: MPC8313e RBD add NAND to device tree
      [POWERPC] 83xx: MPC8313e RDB - Add NOR flash to the device tree.
      [POWERPC] 83xx: Update MPC8313e RDB defconfig for MTD, NAND, JFFS2.
      [POWERPC] 8xx: adder875 - Fix flash bus-width and remove duplicate __initdata

Sean MacLennan (5):
      [POWERPC] 4xx: Add PowerPC 440EP Rev C
      [POWERPC] 4xx: PIKA Warp base platform
      [POWERPC] 4xx: PIKA Warp DTS
      [POWERPC] 4xx: PIKA Warp bootwrapper
      [POWERPC] 4xx: PIKA Warp defconfig

Stefan Roese (15):
      [POWERPC] 4xx: Add 440SPe revA runtime detection to PCIe
      [POWERPC] 4xx: Fix TLB 0 problem with CONFIG_SERIAL_TEXT_DEBUG
      [POWERPC] 4xx: Add 405EX CPU type needed for EMAC support on Kilauea
      [POWERPC] 4xx: Change Kilauea dts to support new EMAC device tree properties
      [POWERPC] 4xx: Add Kilauea PCIe support to dts and Kconfig
      [POWERPC] 4xx: Set ibpre for 405EX in 4xx PCIe driver
      [POWERPC] 4xx: Add aliases node to 4xx dts files
      [POWERPC] 4xx: Change Kilauea PCIe bus ranges in dts file
      [POWERPC] 4xx: Add AMCC Makalu board support to platforms/40x
      [POWERPC] 4xx: Makalu dts
      [POWERPC] 4xx: Makalu defconfig
      [POWERPC] 4xx: Add EMAC support to Kilauea defconfig
      [POWERPC] 4xx: PCIe: Increase max busses per port to 64
      [POWERPC] 4xx: Add 405EXr to cputable
      [POWERPC] 4xx: Add AMCC Haleakala (405EXr) dts

Stephen Neuendorffer (5):
      [POWERPC] Xilinx: update compatible list for interrupt controller
      [POWERPC] Xilinx: Add correct compatible list for device tree bus bindings.
      [POWERPC] Xilinx: Update booting-without-of.
      [POWERPC] Xilinx: updated device tree compatibility to match uboot bsp generator.
      [POWERPC] Xilinx uartlite: Section type fixups

Stephen Rothwell (12):
      [POWERPC] The pci_dn class_code is only used by EEH
      [POWERPC] The pci_dn pcidev is only used by EEH
      [POWERPC] iSeries: eliminate pci_dn bussubno
      [POWERPC] eeh.c: Use for_each_child_of_node
      [POWERPC] pci_32.c: Use for_each_child_of_node
      [POWERPC] therm_pm72: Suppress some compile warnings
      [POWERPC] arch/powerpc/kernel: Use for_each_child_of_node
      [POWERPC] therm_windtunnel: Eliminate some build warnings
      [POWERPC] therm_adt746x: Eliminate some build warnings
      [POWERPC] Check that the syscall table matches the syscall numbers
      [POWERPC] Make ibmebus use of_(un)register_driver
      [POWERPC] Fix a couple of copyright symbols

Takashi Yamamoto (2):
      [POWERPC] PS3: Add logical performance monitor repository routines
      [POWERPC] PS3: Add logical performance monitor driver support

Timur Tabi (4):
      [POWERPC] QE: Add ability to upload QE firmware
      [POWERPC] QE: Add support for Freescale QUICCEngine UART
      [POWERPC] qe-uart: add support for Freescale QUICCEngine UART
      [POWERPC] Update MPC8610 HPCD to support audio drivers

Valentine Barshak (12):
      [POWERPC] 4xx: 440EPx Sequoia USB OHCI DTS entry
      [POWERPC] 4xx: 440GRx Rainier bootwrapper.
      [POWERPC] 4xx: 440GRx Rainier DTS.
      [POWERPC] 4xx: 440GRx Rainier board support.
      [POWERPC] 4xx: 440GRx Rainier default config
      [POWERPC] 4xx: make UIC use generic level irq handler
      [POWERPC] 4xx: rework UIC cascade irq handling
      [POWERPC] 4xx: Correct 440GRx machine_check callback
      [POWERPC] 4xx: Add PCI entry to 440EPx Sequoia DTS.
      [POWERPC] 44x: Sequoia and Rainier updates for 2.6.25
      [POWERPC] 4xx: update 440EP(x)/440GR(x) identical PVR issue workaround
      [POWERPC] 4xx: Add PCI entry to 440GRx Rainier DTS.

Vitaly Bordug (3):
      phy/fixed.c: rework to not duplicate PHY layer functionality
      [POWERPC] MPC8349E-mITX: Vitesse 7385 PHY is not connected to the MDIO bus
      [POWERPC] fsl_soc: add support to gianfar for fixed-link property

Wade Farnsworth (2):
      [POWERPC] 86xx: Add localbus and flash nodes to mpc8641_hpcn.dts
      [POWERPC] 86xx: MPC8641 HPCN - call of_platform_bus_probe()
