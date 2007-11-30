Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2007 17:10:38 +1100
Subject: [PATCH 0/24] powerpc: 4xx PCI,
	PCI-X and PCI-Express support among others
Message-Id: <1196403038.569525.367459803520.qpush@grosgo>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a set of patches that bring PCI, PCI-X and PCI-Express
support to 4xx on arch/powerpc. It also changes/fixed various
bits and pieces, such as a bit of rework of arch/powerpc/boot
4xx code, adding a couple of new platforms along the way. 

There are some issues with the SCSI stack vs. non-coherent
DMA that I'm working on fixing separately, and there's a
problem I noticed with the e1000 driver vs. 64 bits resources
on 32 bits architectures for which I also have a patch that
I posted separately. Appart from that, I got it working fine
with a USB2 card in an ebony and 2 USB storage devices.

Some of these patches are _NOT_ yet candidate for merging
(mostly the board support ones), but you can review them and
Josh can put them in an experimental tree.

There will be further cleanups and fixes before 2.6.25 opens
