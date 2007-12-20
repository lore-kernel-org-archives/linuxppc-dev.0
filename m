Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2905FDDEDD
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 02:22:55 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBKFMq6S024734
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 10:22:52 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBKFMnxf1118422
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 10:22:49 -0500
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBKFMjHi024954
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 08:22:46 -0700
Date: Thu, 20 Dec 2007 09:17:10 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.25-candidates branch updated in 4xx tree
Message-ID: <20071220091710.7311f0dd@zod.rchland.ibm.com>
In-Reply-To: <20071206143202.331082b3@zod.rchland.ibm.com>
References: <20071204131139.3c6be92f@zod.rchland.ibm.com>
	<20071206143202.331082b3@zod.rchland.ibm.com>
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

On Thu, 6 Dec 2007 14:32:02 -0600
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Tue, 4 Dec 2007 13:11:39 -0600
> Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> 
> > For those following my tree, I've added a 2.6.25-candidates branch and
> > based it off of Paul's latest master.  (If you've already pulled
> > you'll have to reset, sorry.)
> 
> I've updated this again with BenH's latest PCI patch series.  There are
> a couple more commits from Stefan and Valentine for various platform
> fixes, and I've also fixed the 4xx DTS files to work with both the old
> and new DTC versions.

I've updated this branch again.  It's been rebased off of Paul's latest
tree.  I know Ben has another round of his 20 patch series coming,
which will hopefully be the last one since we need to start merging
some of this stuff soon. Once he sends that out, I'll begin a
for-2.6.25 branch and ask Paul to pull.

The candidates branch currently has the commits below. Let me know if
I've missed something.

josh

Benjamin Herrenschmidt (18):
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
      [POWERPC] 4xx: Add decoding of 440SPE memory size to boot wrapper library
      [POWERPC] 4xx: Add mfspr/mtspr inline macros to 4xx bootwrapper
      [POWERPC] 4xx: Add 44x CPR0 accessors to boot wrapper
      [POWERPC] 4xx: Rework 4xx clock probing in boot wrapper
      [POWERPC] 4xx: Base support for 440SPe "Katmai" eval board
      [POWERPC] 4xx: PCI-E Link setup improvements
      [POWERPC] pci32: 4xx embedded platforms want to reassign all PCI resources

Hugh Blemings (1):
      [POWERPC] 4xx: Base support for 440GX Taishan eval board

Josh Boyer (6):
      [POWERPC] 4xx: Fix 440grx setup function to call 440A fixup
      [POWERPC] 4xx: Select PCI for the evaluation boards
      [POWERPC] 4xx: Include missing header
      [POWERPC] 4xx: libfdt and pci fixes for Rainier
      [POWERPC] 4xx: Update Kilauea, Rainier, and Walnut defconfigs
      [POWERPC] 4xx: Rename CPU nodes to avoid dtc incompatibility

Matthias Fuchs (1):
      [POWERPC] 4xx: Add 405GPr and 405EP support in boot wrapper

Stefan Roese (8):
      [POWERPC] 4xx: Add 440SPe revA runtime detection to PCIe
      [POWERPC] 4xx: Fix TLB 0 problem with CONFIG_SERIAL_TEXT_DEBUG
      [POWERPC] 4xx: Add 405EX CPU type needed for EMAC support on Kilauea
      [POWERPC] 4xx: Change Kilauea dts to support new EMAC device tree properti
      [POWERPC] 4xx: Add Kilauea PCIe support to dts and Kconfig
      [POWERPC] 4xx: Set ibpre for 405EX in 4xx PCIe driver
      [POWERPC] 4xx: Add aliases node to 4xx dts files
      [POWERPC] 4xx: Change Kilauea PCIe bus ranges in dts file

Valentine Barshak (8):
      [POWERPC] 4xx: 440EPx Sequoia USB OHCI DTS entry
      [POWERPC] 4xx: 440GRx Rainier bootwrapper.
      [POWERPC] 4xx: 440GRx Rainier DTS.
      [POWERPC] 4xx: 440GRx Rainier board support.
      [POWERPC] 4xx: 440GRx Rainier default config
      [POWERPC] 4xx: make 4xx uic use generic level irq handler
      [POWERPC] 4xx: rework UIC cascade irq handling
      [POWERPC] 44x: Sequoia and Rainier updates for 2.6.25
