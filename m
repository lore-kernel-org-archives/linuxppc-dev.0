Date: Wed, 22 Aug 2001 03:32:43 -0700
From: Matt Porter <mporter@mvista.com>
To: David Updegraff <dave@cray.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Physically mapped FLASH
Message-ID: <20010822033243.B32016@cx258813-a.chnd1.az.home.com>
References: <EFEAIMDCOOOHIEPHDNFJAEHDDBAA.stefan.roese@esd-electronics.com> <20010822134155.4105@mailhost.mipsys.com> <3B83B46C.8030805@cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B83B46C.8030805@cray.com>; from dave@cray.com on Wed, Aug 22, 2001 at 08:32:28AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 22, 2001 at 08:32:28AM -0500, David Updegraff wrote:
>
> Hi.
>
> Is there a reason why the physical-mapping setup (drivers/mtd/maps/physmap.c)
> is coded to ONLY talk to CFI chips?  For example I have some 405gp things
> that have AMD Flash chips that are physically mapped to the top of memory
> and could be driven by the algorithms in drivers/mtd/chips/amd_flash.c.

It's the same reason why any obvious limitation exists in Linux.  The
original developer was only interested in implementing something that
suited his task at hand.  It's been sitting there waiting for you to
come along fix it for all of us. :)

> I've patched it and it appears to work ok; is it a bad idea?  is it good idea?
> Any interest in incorporating in?

Post your patch here and on the MTD list. Send it to the MTD maintainers
directly.  I have cPCI boards that can make use of it, it's just been
low on my priority list.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
