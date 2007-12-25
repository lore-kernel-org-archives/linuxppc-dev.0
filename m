Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id B2E51DDDE9
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Dec 2007 12:53:46 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so3728777pyi.0
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 17:53:45 -0800 (PST)
Date: Mon, 24 Dec 2007 19:53:40 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: 4xx: for-2.6.25 branch created
Message-ID: <20071224195340.49911088@vader.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just in time for the holidays, I created my for-2.6.25 branch.  It
contains the commits below.  I'll let it sit for a couple days given
the timing of things, and ask Paul to pull a bit later.

If I've missed something, let me know.

josh

Benjamin Herrenschmidt (19):
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

Hugh Blemings (1):
      [POWERPC] 4xx: Base support for 440GX Taishan eval board

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

Stefan Roese (11):
      [POWERPC] 4xx: Add 440SPe revA runtime detection to PCIe
      [POWERPC] 4xx: Fix TLB 0 problem with CONFIG_SERIAL_TEXT_DEBUG
      [POWERPC] 4xx: Add 405EX CPU type needed for EMAC support on Kilauea
      [POWERPC] 4xx: Change Kilauea dts to support new EMAC device tree properti
      [POWERPC] 4xx: Add Kilauea PCIe support to dts and Kconfig
      [POWERPC] 4xx: Set ibpre for 405EX in 4xx PCIe driver
      [POWERPC] 4xx: Add aliases node to 4xx dts files
      [POWERPC] 4xx: Change Kilauea PCIe bus ranges in dts file
      [POWERPC] 4xx: Add AMCC Makalu board support to platforms/40x
      [POWERPC] 4xx: Makalu dts
      [POWERPC] 4xx: Makalu defconfig

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
