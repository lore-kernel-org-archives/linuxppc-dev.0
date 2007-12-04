Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 003BADDF27
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 06:14:08 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB4JE4rL003116
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 14:14:04 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB4JE4Rr140504
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 14:14:04 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB4JE4qD002952
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 14:14:04 -0500
Received: from zod.rchland.ibm.com (wecm-9-67-205-26.wecm.ibm.com
	[9.67.205.26])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	lB4JE3ZV002912
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 14:14:03 -0500
Date: Tue, 4 Dec 2007 13:11:39 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: 2.6.25-candidates branch updated in 4xx tree
Message-ID: <20071204131139.3c6be92f@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For those following my tree, I've added a 2.6.25-candidates branch and
based it off of Paul's latest master.  (If you've already pulled
you'll have to reset, sorry.)

I call it candidates because several patches (most notably Ben's) will
probably get reworked a little before I ask Paul to pull them into his
tree.  There are also EMAC patches in there that will go through Jeff
Garzik rather than me.

The branch contains the commits below. I'm sure I've missed one or two,
so feel free to reply and let me know if you think a patch is needed
for 4xx in 2.6.25.

josh

Benjamin Herrenschmidt (32):
      [POWERPC] ibm_newemac: Fix possible lockup on close
      [POWERPC] usb: Remove OHCI useless masking/unmasking of WDH interrupt
      [POWERPC] usb: Remove broken optimisation in OHCI IRQ handler
      [POWERPC] drm: Fix for non-coherent DMA PowerPC
      [POWERPC] ibm_newemac: Fix ZMII refcounting bug
      [POWERPC] ibm_newemac: Workaround reset timeout when no link
      [POWERPC] ibm_newemac: Cleanup/Fix RGMII MDIO support detection
      [POWERPC] ibm_newemac: Cleanup/fix support for STACR register variants
      [POWERPC] emac: Update file headers copyright notices
      [POWERPC] Make isa_mem_base common to 32 and 64 bits
      [POWERPC] Merge pci_process_bridge_OF_ranges()
      [POWERPC] Fix powerpc 32 bits resource fixup for 64 bits resources
      [POWERPC] 4xx: Fix 440/440A machine check handling
      [POWERPC] 4xx: Fix 440SPE machine check
      [POWERPC] 4xx: Add xmon function to dump 44x TLB
      [POWERPC] Change 32 bits PCI message about resource allocation
      [POWERPC] Add of_translate_dma_address
      [POWERPC] 4xx: Improve support for 4xx indirect DCRs
      [POWERPC] 4xx: PLB to PCI-X support
      [POWERPC] 4xx: PLB to PCI 2.x support
      [POWERPC] 4xx: PLB to PCI Express support
      [POWERPC] 4xx: PCI support for 4xx Ebony board
      [POWERPC] 4xx: Add early udbg support for 40x processors
      [POWERPC] early debug forces console log level to max
      [POWERPC] 4xx: EP405 boards support for arch/powerpc
      [POWERPC] 4xx: Add PCI to Walnut platform
      [POWERPC] 4xx: Wire up PCI on Bamboo board
      [POWERPC] 4xx: Wire up 440EP USB controller support to Bamboo board
      [POWERPC] 4xx: Adds decoding of 440SPE memory size to boot wrapper library
      [POWERPC] 4xx: Add mfspr/mtspr inline macros to 4xx bootwrapper
      [POWERPC] 4xx: Rework 4xx clock probing in boot wrapper
      [POWERPC] 4xx: Base support for 440SPe "Katmai" eval board

Hugh Blemings (2):
      [POWERPC] ibm_newemac: Skip EMACs that are marked unused by the firmware
      [POWERPC] 4xx: Base support for 440GX Taishan eval board

Josh Boyer (1):
      [POWERPC] 4xx: Fix 440grx setup function to call 440A fixup

Stefan Roese (6):
      [POWERPC] 4xx: Fix TLB 0 problem with CONFIG_SERIAL_TEXT_DEBUG
      [POWERPC] ibm_newemac: Add BCM5248 and Marvell 88E1111 PHY support
      [POWERPC] ibm_newemac: Add ET1011c PHY support
      [POWERPC] 4xx: Add 405EX CPU type needed for EMAC support on Kilauea
      [POWERPC] 4xx: Change Kilauea dts to support new EMAC device tree properti
      [POWERPC] 4xx: Add EMAC support to Kilauea defconfig

Valentine Barshak (7):
      [POWERPC] ibm_newemac: Correct opb_bus_freq value
      [POWERPC] ibm_newemac: Fix typo reading TAH channel info
      [POWERPC] ibm_newemac: Call dev_set_drvdata() before tah_reset()
      [POWERPC] 4xx: 440GRx Rainier bootwrapper.
      [POWERPC] 4xx: 440GRx Rainier DTS.
      [POWERPC] 4xx: 440GRx Rainier board support.
      [POWERPC] 4xx: 440GRx Rainier default config
