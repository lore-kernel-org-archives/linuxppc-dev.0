Date: Mon, 8 Apr 2002 19:37:13 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Matt Porter <mporter@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
In-Reply-To: <20020408102348.A1048@home.com>
Message-ID: <Pine.LNX.4.33.0204081924240.12075-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Apr 2002, Matt Porter wrote:

> Most of the MCG's residual data are so incorrect that you spend more time
> fixing stuff up than using this "wonderful" source of board info. I had
> an opportunity to examine all of them in detail at my previous employer
> to realize that it's mostly useless to use it.

I did not find so many bugs myself on MVME2400 and 2600. Actually I found
them mostly correct in my case...

>
> Couple that with the constant breakage of a numer of the boards by all
> the tweaks to real legacy PReP workstations.
>
> The CONFIG_PPLUS port made the code clean, neat, and maintainable.

Never enabled it for my boards until now, but I'm not interested at all in
having a ROMBoot image either. Almost all my boards used dhcp/bootp, the
other ones have a disk...

> Because the CONFIG_PPLUS port doesn't rely on residual data, the
> ability to create a "ROMboot" image is simplified to the point that
> it is generated in the kernel instead of an 18 step process involving
> dumping a copy of residual data that was only being used to get
> the memory size.  Retrieving memory size from the memory controller
> configuration already had been done for other MCG boards with
> inaccurate residual data info.

Do the kernel tables have the right interrupt routing for MVME3600 with
secondary Ethernet/SCSI for example ?

>
> The firmware group at MCG will _never_ fix the residual data since
> their AIX doesn't use it.  Even when they had some decent staff
> on hand they weren't willing to fix anything related to residual
> data.  Now, they've laid off just about everybody so it's guaranteed
> to never happen.
>
> CONFIG_PPLUS also made it easy to add pci_auto support since putting
> it in PReP would have been a complete mess...
>
> > > > (Who should have properly submitted his PrePboot code 3 years ago)
>
> Yeah, you even had a sorting autoconfiguration algorithm in prepboot,
> IIRC.

Indeed, can you think of any other solution when you reprogram the whole
PCI<->PPCbus maps of the chipset ?

The only problem is that it probably does not work with PCI<->PCI bridges
since I never had the hardware to test (I believe I even never implemented
that part, or scrapped after a brief attempt).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
