Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Dec 2007 18:59:59 +1100
Subject: [PATCH 0/25] powerpc: 4xx PCI,
	PCI-X and PCI-Express support among others
Message-Id: <1196927999.714593.205329520306.qpush@grosgo>
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
