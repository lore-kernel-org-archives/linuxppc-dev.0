Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18425.46732.651483.504040@cargo.ozlabs.ibm.com>
Date: Mon, 7 Apr 2008 15:52:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to powerpc.git powerpc-next and master branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patches have been added to the master and powerpc-next
branches of the powerpc.git repository.  There is a bunch that I
pulled from Josh Boyer's tree plus others that I have committed.

Paul.

Grant Likely (2):
      [POWERPC] add target for building .dtb files
      [POWERPC] bootwrapper: Add a firmware-independent simpleboot target.

Ionut Nicu (1):
      [POWERPC] Fix kernel panic in arch_arm_kprobe

Josh Boyer (2):
      [POWERPC] 4xx: Add Canyonlands and Yosemite to multi-board defconfig
      [POWERPC] Add of_device_is_available function

Nathan Lynch (1):
      [POWERPC] Convert pci and eeh code to of_device_is_available

Robert P. J. Day (1):
      [POWERPC] Use __SPIN_LOCK_UNLOCKED macro in mpc52xx_set_psc_clkdiv

Roel Kluin (1):
      [POWERPC] Replace logical-AND by bit-AND in pci_process_ISA_OF_ranges()

Stefan Roese (5):
      [POWERPC] 4xx: Only reset PCIe PHY on 405EX systems when no link is detected
      [POWERPC] 4xx: Fix PESDRn_UTLSET1 register setup on 460EX/GT
      [POWERPC] 4xx: Create common ppc4xx_reset_system() in ppc4xx_soc.c
      [POWERPC] 4xx: Some EMAC related changes in Canyonlands & Glacier dts files
      [POWERPC] 4xx: Change dts files to support jumbo frames

Stephen Neuendorffer (1):
      [POWERPC] of_serial: Fix possible null dereference.

Stephen Rothwell (2):
      [POWERPC] htab_remove_mapping is only used by MEMORY_HOTPLUG
      [POWERPC] Remove CONFIG_PCI_LEGACY from some configs

Steven Rostedt (1):
      [POWERPC] Add hand-coded assembly strcmp

Timur Tabi (1):
      [POWERPC] Enable CONFIG_FORCE_MAX_ZONEORDER for all PowerPC, and make selectable

Valentine Barshak (1):
      [POWERPC] 4xx: Use machine_device_initcall() for warp_nand
