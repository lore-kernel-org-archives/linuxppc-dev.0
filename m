Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 21 Nov 2007 17:16:17 +1100
Subject: [RFC/PATCH 0/14] powerpc: 4xx PCI and PCI-X support
Message-Id: <1195625777.579001.269266058699.qpush@grosgo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a set of patches that bring PCI and PCI-X support for
4xx (PCIe still missing) in arch/powerpc.

This is for review before I ask paulus to pull that into his
for 2.6.25 tree. Some of the patches still need a bit more
testing vs. regressions on other platforms such as the
64 bits resource fixup one.

It also adds some support for the ep405 boards while at it
(I had one around :-)

PCI is hooked up on ebony, walnut and ep405 at this stage.

There are some issues with the SCSI stack vs. non-coherent
DMA that I'm working on fixing separately, and there's a
problem I noticed with the e1000 driver vs. 64 bits resources
on 32 bits architectures for which I also have a patch that
I posted separately. Appart from that, I got it working fine
with a USB2 card in an ebony and 2 USB storage devices.
