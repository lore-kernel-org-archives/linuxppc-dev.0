Date: Wed, 7 Nov 2001 05:09:50 -0700
From: Matt Porter <mporter@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: The Plan
Message-ID: <20011107050950.A18135@cx258813-a.chnd1.az.home.com>
References: <15337.7275.266062.777161@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15337.7275.266062.777161@cargo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Nov 07, 2001 at 10:35:07PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 07, 2001 at 10:35:07PM +1100, Paul Mackerras wrote:
>
> (to reduce the arch/ppc/kernel clutter, that is)

<snip>

> We can discuss variations on this theme, for example we could possibly
> move platforms/iSeries* to iSeries/, since it already has its own
> directory.  As the number of platforms grows, we can consider moving
> other groups of platforms into their own directories as well.

Sounds great to me.  I'd like to fold a number of embedded 7xx/74xx
system files into directories by their manufacturer names.

arch/ppc/kernel/platforms/Motorola/
					sandpoint_*
					mvme5100_*
					mcp765_*
					etc.
arch/ppc/kernel/platforms/Force/
					pcore_*
					powerpmc_*
					etc.

arch/ppc/kernel/platforms/xyz/
...

The next step (since we've all been working away at abstracting
our common interfaces) is to collapse the *_[setup|pci].c files
in a single file to further reduce clutter on those systems for
which it makes practical sense.  Again, that's most of our
embedded 7xx/74xx/8240 ports.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
