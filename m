Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 May 2007 11:40:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4/6] Device tree aware EMAC driver
Message-ID: <20070507014051.GF16165@localhost.localdomain>
References: <20070504055455.GA25922@localhost.localdomain>
	<20070507003019.GB16165@localhost.localdomain>
	<20070507005723.GA4453@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507005723.GA4453@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 06, 2007 at 07:57:23PM -0500, Olof Johansson wrote:
> On Mon, May 07, 2007 at 10:30:19AM +1000, David Gibson wrote:
> > This is BenH's rewritten, device tree aware driver for the IBM/AMCC
> > EMAC, ethernet MAC controller ASIC found on various 4xx CPUs and also
> > the Axon bridge.  Tweaked to build on current kernels.
> 
> Shouldn't benh have a signoff line on it as well in that case?

Well, his patch which I tweaked didn't have his signoff, so I didn't
think I ought to add it.

> Is it ibm_emac or ibm_newemac? All file headers say ibm_emac, and there's
> still Kconfig references to ibm_emac.

It's ibm_newemac, the file headers just haven't been updated.  The
Kconfig changes referring to ibm_emac are just because the patch moves
the suboptions for the old emac driver into their own subdirectory,
and it inhibits selecting the old emac driver in arch/powerpc.

> (Is this just posted FYI? If not, it should really go to netdev/jgarzik
> instead, right?)

This is just FYI at the moment, or rather, it's not really an Ebony
related patch but it's in this series because the Ebony support is
much more interesting if the ethernet works.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
