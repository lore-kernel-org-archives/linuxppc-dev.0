Message-Id: <200111292142.QAA30752@missioncriticallinux.com>
To: linuxppc-dev@lists.linuxppc.org
From: mod+linuxppc-dev@MissionCriticalLinux.com
Subject: Re: ide_init_hwif_ports 
In-Reply-To: Your message of "Thu, 29 Nov 1901 11:00:09 PST."
Date: Thu, 29 Nov 2001 16:42:10 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 29 Nov 1901 11:00:09 PST msokolov@ivan.Harhan.ORG wrote:
> and the result is that no matter what you do in the
> PCI domain, the primary IDE interrupt will always
> come in as IRQ 14 and the secondary IDE interrupt
> will always come in as IRQ 15.
>
> How does this trouble Linux?  Linux sees a PCI
> device with a PCI IDE class code in PCI native mode.
> It assumes that it will signal a PCI interrupt, one
> for both channels.  It asks the PPC PCI interrupt
> routing code what that interrupt is.  But whatever
> number I return there, it will be wrong.  If I
> return 14, the primary channel will work, but not
> the secondary channel.  Bummer.


Not to quibble with your painfully accurate
description of the VT82C686B, but might it be
possible (using the IDE Interrupt Routing register
at offset 0x4a in function 1) to arrange for both
channels to use the same interrupt routing?
Like force both to IRQ14?  Just a thought...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
