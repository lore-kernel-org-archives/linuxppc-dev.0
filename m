Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by ozlabs.org (Postfix) with ESMTP id 2ABB2DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 02:50:20 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1029640rvf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 09:50:20 -0700 (PDT)
Message-ID: <9e4733910708130950y38f60687ma7957cf42a758cdd@mail.gmail.com>
Date: Mon, 13 Aug 2007 12:50:17 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: MPC5200 and Bestcomm
In-Reply-To: <fa686aa40708130934v912eda2r691d2db30a9bc17c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910708130927l70163a80vf0362ee8649a6c29@mail.gmail.com>
	<fa686aa40708130934v912eda2r691d2db30a9bc17c@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/13/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 8/13/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > We're starting a new MPC5200 project and I'm trying to track down the
> > best kernel to start from. Is Sylvain's tree at
> > http://www.246tnt.com/mpc52xx/ a good place to start? The git URLs
> > from the web page don't work. Everything 5200 related in the trees at
> > Secret Labs already appears to be merged.
> >
> > Most of this work also appears to be in the Open Embedded tree's Ekifa
> > support. Is that a better place to start?
>
> It might be.  The major problem with MPC5200 is the Ethernet driver.
> I believe both Domen and Sylvain have been working on drivers suitable
> for arch/powerpc inclusion.

OpenEmbedded has this series against 2.6.20

0001-powerpc-serial-Dispose-irq-mapping-when-done-in-mpc52xx_serial.c.txt
0003-powerpc-Add-device-tree-fixups-for-the-EFIKA.txt
0004-powerpc-Use-common-52xx-of_platform-probe-code-for-EFIKA.txt
0005-powerpc-Restore-proper-link-order-in-platform.txt
0006-Rework-the-OHCI-quirk-mecanism-as-suggested-by-David.txt
0007-Implement-support-for-split-endian-OHCI.txt
0008-ohci-Rework-bus-glue-integration-to-allow-several-at-once.txt
0009-ohci-Add-support-for-OHCI-controller-on-the-of_platform-bus.txt
0010-libata-Add-support-for-the-MPC52xx-ATA-controller.txt
0011-ohci-Whitespace-and-typo-fix-in-ohci-ppc-of.c.txt
0012-ata-Fix-pata_mpc52xx.c-compatible-list.txt
0013-powerpc-serial-Fix-mpc52xx_uart.c-compatible-list.txt
0014-powerpc-Small-cleanup-of-EFIKA-platform.txt
0015-powerpc-Add-a-unified-uevent-handler-for-bus-based-on-of_device.txt
0016-macintosh-Use-the-new-of_device-common-uevent-handler.txt
0017-powerpc-Add-uevent-handler-for-of_platform_bus.txt
0018-powerpc-Add-uevent-handler-for-ibmebus.txt
0019-MPC5200-Bestcomm-platform-driver.txt
0020-Fec-MPC5200-eth-driver.txt
0021-POWERPC-Copy-bestcomm-support-files-into-arch-powerpc.txt
0022-MPC52xx-PCI-now-working-on-lite5200.-ugly-but-working.txt
0023-POWERPC-Make-FEC-work-on-the-lite5200.txt
0024-Add-missing-function-prototype.txt
0025-POWERPC-Misc-EFIKA-fixups-for-rtas-chrp.txt
0026-POWERPC-Cleanup-mpc52xx-PCI-support.txt
0027-POWERPC-Change-name-of-mpc52xx-pci-support-file-in-Makefile.txt
0028-POWERPC-Change-link-order-so-mpc52xx-fec-always-shows-up-as-eth0.txt
0029-POWERPC-Fixup-pr_print-format-for-mpc52xx-pci-support.txt
0030-POWERPC-Add-mpc52xx-lite5200-PCI-support.txt
0031-sound-Add-support-for-the-MPC52xx-PSC-AC97-Link.txt
0032-POWERPC-EFIKA-Adds-missing-interrupts-from-bestcomm-node.txt
0033-EFIKA-fullduplex-prpl_aln.txt
defconfig
v4l.diff



-- 
Jon Smirl
jonsmirl@gmail.com
