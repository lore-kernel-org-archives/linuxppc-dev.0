Date: Wed, 12 Jul 2000 07:16:04 -0700
From: Matt Porter <mmporter@home.com>
To: Adrian Cox <apc@agelectronics.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
Message-ID: <20000712071604.C28921@cx258813-a.chnd1.az.home.com>
References: <20000709222943.A19611@cx258813-a.chnd1.az.home.com> <Pine.HPX.4.10.10007101412580.9548-100000@gra-ux1.iram.es> <20000710225720.A23538@cx258813-a.chnd1.az.home.com> <396AEAC7.D8CACCB2@agelectronics.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <396AEAC7.D8CACCB2@agelectronics.co.uk>; from apc@agelectronics.co.uk on Tue, Jul 11, 2000 at 10:37:11AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 11, 2000 at 10:37:11AM +0100, Adrian Cox wrote:
>
> Matt Porter wrote:
> > Back to original point, I'm not against using a residual data or
> > device tree if it doesn't have to have dozens of fixups applied.
> > I just don't see that coming out of the proprietary hardware/software
> > houses to use their broken data...
>
> Residual data is useful for things like finding the memory size, and for
> chips designed inside Apple. For almost everything else Linux already
> contains a device tree, built by PCI probing when the kernel boots^*. I
> don't see much need for a parallel, architecture specific, device tree.

Whoa...you mentioned the key phrase here...it's really only useful or
required for chips design inside Apple where you can't get documentation.
"Residual data" and defined in the PReP spec is only found on PReP systems
where all the hardware is fully documented so it's easy to size the
memory by other means.  It's not that hard to read board registers or
the memory controller setup.

I can see why the Mac folks have to deal with the broken OF device tree.

A architecture specific (PPC) device tree (or residual data, if you will)
would be part of a "standard" OpenSource firmware project.  It's only
use would be to provide information for board bringup, etc.  It has it's
advantages and disadvantages...

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
