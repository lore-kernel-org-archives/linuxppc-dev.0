Message-ID: <50575.193.133.92.239.1011967168.squirrel@lbbrown.homeip.net>
Date: Fri, 25 Jan 2002 13:59:28 -0000 (GMT)
Subject: Re: RFC: vesafb
From: "Leigh Brown" <leigh@solinno.co.uk>
To: <hollis@austin.ibm.com>
In-Reply-To: <20020123192010.GP510@austin.ibm.com>
References: <20020123192010.GP510@austin.ibm.com>
Cc: <linuxppc-dev@lists.linuxppc.org>, <sdi@remote.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Hollis,

> The attached patch allows vesafb to work on PPC. vesafb does
> surprisingly little with the BIOS (which I thought was the whole point
> of VESA). With some ifdef's I'm able to use it as sort of a VGA offb --
> the firmware initializes the card, and the driver just uses it and
> never mucks with it.
>
> This patch allows me to get an 800x600x8 console on the Thinkpad 850,
> and 640x480x8 on the Carolina machines. More interestingly it allows X
> to work on the Thinkpad, which currently doesn't work and has never
> worked in >16 colors. It should also work on the 7020 (Sven?), which
> uses the Weitek 9100 card and currently is driverless.
>
> This patch is only for PReP, which is probably the only place it's
> really useful (since CHRP and PMac have offb), but would be easy enough
> to add to.
>
> Comments?

Well, I thought I'd give it a go on my 7043-140.  I think that it
would help those people with the proprietary IBM graphics cards
(GXT550P, GXT800P that sort of thing, IIRC), as well as being at least
as good as the S3Triofb frame buffer driver (which can't switch video
modes any way).

Unsurprisingly it didn't work.  That is, unsurprisingly because nothing
ever goes to plan on these boxes :-)

It seems there is no residual data entry for the graphics card.  I
enabled the code to dump the residual data and it was conspicuous by
its absence.  In fact, everything else seemed to be there (6 PCI devices
and 17 ISA devices).

Any ideas?

Cheers,

Leigh.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
