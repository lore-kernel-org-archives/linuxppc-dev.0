Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18270.8249.393061.840667@cargo.ozlabs.ibm.com>
Date: Tue, 11 Dec 2007 16:29:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to for-2.6.25 and master branches of powerpc.git
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt (7):
      [POWERPC] Make isa_mem_base common to 32 and 64 bits
      [POWERPC] Merge pci_process_bridge_OF_ranges()
      [POWERPC] Fix powerpc 32-bit resource fixup for 64-bit resources
      [POWERPC] Change 32-bit PCI message about resource allocation
      [POWERPC] Remove useless volatiles in udbg_16550.c
      [POWERPC] Add of_translate_dma_address
      [POWERPC] Early debug forces console log level to max

Cyrill Gorcunov (1):
      [POWERPC] CELLEB: Fix possible NULL pointer dereference

David Gibson (3):
      [POWERPC] Merge libfdt upstream source
      [POWERPC] Use embedded libfdt in the bootwrapper
      [POWERPC] Kill flatdevtree.c

David Woodhouse (4):
      [POWERPC] Create otheros.bld next to specified output file, not in $object directory
      [POWERPC] Find device-tree source file in default directory
      [POWERPC] Allow for bootwrapper utilities being in different directory to objects
      [POWERPC] Implement 'make bootwrapper_install'

Ishizaki Kou (3):
      [POWERPC] cell: Fix undefined reference to mmio_nvram_init
      [POWERPC] celleb: Add support for native CBE
      [POWERPC] Update celleb_defconfig to add support for native CBE

Jon Loeliger (2):
      [POWERPC] Clean out asm/of_{platform, device}.h
      [POWERPC] Clean out asm/of_{platform, device}.h from sysdev/

Michael Ellerman (1):
      [POWERPC] Add for_each_child_of_node() helper for iterating over child nodes

Michael Hanselmann (1):
      [POWERPC] Update smu command definitions

Michael Neuling (1):
      [POWERPC] Use SLB size from the device tree

Nathan Lynch (1):
      [POWERPC] lparcfg: Remove useless buffer allocation

Olof Johansson (5):
      [POWERPC] pasemi: clean up mdio_gpio a bit
      [POWERPC] pasemi: Broaden specific references to 1682M
      [POWERPC] pasemi: Don't enter powersaving states from elevated astates
      [POWERPC] pasemi: Move cpus to hold loop before restart
      [POWERPC] pasemi: Fix module information for gpio-mdio

Stephen Neuendorffer (1):
      [POWERPC] Improved documentation of device tree 'ranges'

Stephen Rothwell (27):
      [POWERPC] Use of_register_driver to implement of_register_platform_driver
      [POWERPC] kernel_execve is identical in 32 and 64 bit
      [POWERPC] iommu_free_table doesn't need the device_node
      [POWERPC] pSeries: Remove dependency on pci_dn bussubno
      [POWERPC] Clean up pci-bridge.h
      [POWERPC] Consolidate pci_controller
      [POWERPC] iSeries: Move find_Device_Node to avoid a forward declaration
      [POWERPC] iSeries: Cleanup PCI retry code a little
      [POWERPC] iSeries: DeCamelCase pci.c
      [POWERPC] iSeries: Remove some dead code from pci.c
      [POWERPC] iSeries: Unindent and clean iSeries_pci_final_fixup
      [POWERPC] iSeries: Consoldiate PCI IO error check
      [POWERPC] iSeries: Remove one layer of IO routines
      [POWERPC] iSeries: Remove pci_dn dependency from iSeries_Device_Information
      [POWERPC] iSeries: iseries_ds_addr is only used in pci.c
      [POWERPC] iSeries: Reduce dependence on pci_dn bussubno
      [POWERPC] iSeries: Make pcibios_final_fixup not depend on pci_dn
      [POWERPC] Inline pci_setup_pci_controller as it has become trivial
      [POWERPC] iSeries: Call iSeries_pcibios_init from setup_arch
      [POWERPC] iSeries: hose->buid is always zero for iSeries
      [POWERPC] Remove some iSeries platform checks from the PCI code
      [POWERPC] Don't special case pci_domain_nr() for iSeries
      [POWERPC] pci_controller->arch_data really is a struct device_node *
      [POWERPC] iSeries: DeCamelCase vpdinfo.c
      [POWERPC] iSeries: Clean up and simplify vdpinfo.c
      [POWERPC] iSeries: Merge vpdinfo.c into pci.c
      [POWERPC] EEH: Avoid a possible NULL pointer dereference

will schmidt (1):
      [POWERPC] Update xmon slb code
