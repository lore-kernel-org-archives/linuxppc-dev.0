Date: Wed, 9 Apr 2003 08:22:23 -0700
From: Matt Porter <porter@cox.net>
To: luca gambazzi <luca.gambazzi@epfl.ch>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Force Computers CPCI-3750 eth drivers
Message-ID: <20030409082223.C24217@home.com>
References: <1049880169.3724.16.camel@shampoo.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1049880169.3724.16.camel@shampoo.epfl.ch>; from luca.gambazzi@epfl.ch on Wed, Apr 09, 2003 at 11:22:49AM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 09, 2003 at 11:22:49AM +0200, luca gambazzi wrote:
> Hi Matt
>
> I'm booting with the pcore kernel.
>
> the pcore_find_bridges function in pcore_pci.c recognize my card as a
> 6750, but the 3750 uses a 21150 bridge and not a 21154.
>
> Do you know where can i find documentation to solve this problem?
> and where I have to modify?

Oh, I should have mentioned the shotgun alternative to waiting on docs
from Force.  Assume that the 3750 uses cascade irqs 9-12 for all pci
interrupts just like the 6750.  Try changing the 6750 tulip map_irq
entry to be 9,11,12 and see if any work.

BTW, saw your list of devices in the /proc/pci dump.  Looks like a
fun project. :)

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
