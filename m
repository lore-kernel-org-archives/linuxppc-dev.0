Subject: Re: Linux on Force Computers CPCI-3750 eth drivers
From: luca gambazzi <luca.gambazzi@epfl.ch>
To: Matt Porter <porter@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030409082223.C24217@home.com>
References: <1049880169.3724.16.camel@shampoo.epfl.ch>
	 <20030409082223.C24217@home.com>
Content-Type: text/plain
Message-Id: <1050057631.13294.1.camel@shampoo.epfl.ch>
Mime-Version: 1.0
Date: 11 Apr 2003 12:40:32 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi matt

as you said the problem was on the eth card irq,... the irq is 9.
i prepear a patch and i'll send you in next days.

happy weekend
luca

On Wed, 2003-04-09 at 17:22, Matt Porter wrote:
> On Wed, Apr 09, 2003 at 11:22:49AM +0200, luca gambazzi wrote:
> > Hi Matt
> >
> > I'm booting with the pcore kernel.
> >
> > the pcore_find_bridges function in pcore_pci.c recognize my card as a
> > 6750, but the 3750 uses a 21150 bridge and not a 21154.
> >
> > Do you know where can i find documentation to solve this problem?
> > and where I have to modify?
>
> Oh, I should have mentioned the shotgun alternative to waiting on docs
> from Force.  Assume that the 3750 uses cascade irqs 9-12 for all pci
> interrupts just like the 6750.  Try changing the 6750 tulip map_irq
> entry to be 9,11,12 and see if any work.
>
> BTW, saw your list of devices in the /proc/pci dump.  Looks like a
> fun project. :)
>
> Regards,


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
