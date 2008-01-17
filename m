Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18318.56299.476711.644917@cargo.ozlabs.ibm.com>
Date: Thu, 17 Jan 2008 15:39:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to master/for-2.6.25 branch of powerpc.git
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Includes commits pulled from Josh Boyer's tree.

Anton Vorontsov (1):
      [POWERPC] booting-without-of: localbus should not include board name

Cyrill Gorcunov (3):
      [POWERPC] Use for_each macros in arch/powerpc/sysdev
      [POWERPC] Use for_each macros in arch/powerpc/kernel
      [POWERPC] Use for_each macros in arch/powerpc/platforms/powermac

Geert Uytterhoeven (1):
      [POWERPC] Kill sparse warning in HPTE_V_COMPARE()

Grant Likely (4):
      [POWERPC] 4xx: typo in calling machine_device_initcall() for Sequoia board
      [POWERPC] Add of_find_matching_node() helper function
      [POWERPC] powermac: Use machine_*_initcall() hooks in platform code
      [POWERPC] cell: Use machine_*_initcall() hooks in platform code

Hollis Blanchard (1):
      [POWERPC] 4xx: enable built-in networking for Sequoia defconfig

Jochen Friedrich (1):
      [POWERPC] Update .gitignore files

Jon Loeliger (1):
      [POWERPC] Use <linux/of_{platform, device}.h> and not <asm/...> variants.

Jon Tollefson (1):
      [POWERPC] Add hugepagesz boot-time parameter

Mark A. Greer (1):
      [POWERPC] #address-cells & #size-cells properties are not inherited

Matthias Fuchs (1):
      [POWERPC] 4xx: Add 405GPr and 405EP support in boot wrapper

Stefan Roese (2):
      [POWERPC] 4xx: Add EMAC support to Kilauea defconfig
      [POWERPC] 4xx: PCIe: Increase max busses per port to 64

Stephen Neuendorffer (5):
      [POWERPC] Xilinx: update compatible list for interrupt controller
      [POWERPC] Xilinx: Add correct compatible list for device tree bus bindings.
      [POWERPC] Xilinx: Update booting-without-of.
      [POWERPC] Xilinx: updated device tree compatibility to match uboot bsp generator.
      [POWERPC] Xilinx uartlite: Section type fixups

Stephen Rothwell (10):
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
