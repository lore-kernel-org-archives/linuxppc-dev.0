Date: Tue, 28 Jan 2003 07:26:27 -0700
From: Matt Porter <porter@cox.net>
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Denx ELDK vs. Tool-Chain from Hollobaugh's book "Embedded Linux"
Message-ID: <20030128072627.A20053@home.com>
References: <995FF289C9D69747A09E42992644595405B2362D@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <995FF289C9D69747A09E42992644595405B2362D@penguin.adic.com>; from brian.auld@adic.com on Tue, Jan 28, 2003 at 05:49:23AM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jan 28, 2003 at 05:49:23AM -0800, brian.auld@adic.com wrote:
>
> Hello again,
>
> I'm still slugging along here getting familiar with the GNU cross-compile
> tool-chain and all that good stuff for my group's upcoming embedded 440GP
> project.
>
> We already have an ebony board (used for previous VxWorks product) and I'm
> now waiting patiently for our bureaucrats to put through the order for a
> BDI2000 so I can get something (U-Boot and then Linux) onto the board.

Just in case you aren't aware, a BDI and/or U-Boot are not necessary
in order to boot Linux on the Ebony board.  You can boot a kernel
directly from the OpenBIOS firmware now.

You can even flash PPCBoot/U-Boot using Linux booted via OpenBIOS if
you build in Ebony MTD support in the kernel.

> As I've played with different tool-chain options, I think I've narrowed it
> down to the following.
>
> 1) Denx's ELDK
>
> 2) The tool-chain used in Craig Hollobaugh's book "Embedded Linux"

Having played with a few freely available toolkits, I've found that
the ELDK is the most comprehensive free offering.  I haven't really
noticed anything major missing from the cross tools or target apps.
It should be even more complete since when I last used it 4-6 months
ago. If I didn't have an mvista toolchain for my daily work, I'd fall
back to the ELDK.

> Also regarding (2), the book sets up the cross development environment on a
> minimal debian linux box. I can't think of why, but is there any reason I
> would have to stick with this distribution for my linux development server?

No reason.  Of course, I can't imagine why anybody would host off of
anything other than Debian. :)

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
