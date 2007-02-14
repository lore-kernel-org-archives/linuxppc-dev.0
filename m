Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Feb 2007 11:11:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc: Add support for AMCC Taishan 440GX eval board
Message-ID: <20070214001106.GA11491@localhost.localdomain>
References: <200702121129.05004.sr@denx.de>
	<1171281988.20192.1.camel@localhost.localdomain>
	<ada7iun8bz3.fsf@cisco.com>
	<1171310108.20192.7.camel@localhost.localdomain>
	<E1HGhb3-0001fb-9M@jdl.com>
	<1171311802.20192.15.camel@localhost.localdomain>
	<D612EBB5-3ABB-45C5-943B-C32E5B9F4319@kernel.crashing.org>
	<20070213004608.GB4894@localhost.localdomain>
	<8DEFFE52-2326-43A9-9719-15E04EF17D3A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8DEFFE52-2326-43A9-9719-15E04EF17D3A@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	Stefan Roese <sr@denx.de>, Roland Dreier <rdreier@cisco.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 12, 2007 at 11:28:17PM -0600, Kumar Gala wrote:
> 
> On Feb 12, 2007, at 6:46 PM, David Gibson wrote:
> 
> > On Mon, Feb 12, 2007 at 02:41:36PM -0600, Kumar Gala wrote:
> >>
> >> On Feb 12, 2007, at 2:23 PM, Benjamin Herrenschmidt wrote:
> >>
> >>> On Mon, 2007-02-12 at 14:16 -0600, Jon Loeliger wrote:
> >>>> So, like, the other day Benjamin Herrenschmidt mumbled:
> >>>>>
> >>>>> Note that there are still things that we might want to change. For
> >>>>> example, I think we really should look into adding a macro  
> >>>>> mecanism
> >>>>> and/or an include mecanism to dtc so that we can do things like
> >>>>> #include
> >>>>> <ibm440gp.dtc> to get the base processor/SoC definition and then
> >>>>> "overlay" some properties on top of it (like emac phy mode etc...)
> >>>>
> >>>> What do people prefer here?  Straight CPP pre-run?
> >>>
> >>> CPP pre-run has issue, notably due to the usage of "#" in property
> >>> names.
> >>
> >> You can get around that by invoking cpp with the right flags,  I
> >> looked at doing this a while back and had it working.
> >
> > Umm.. which flags?
> 
> cpp -undef -P -x assembler-with-cpp

What exactly does the -x assembler-with-cpp do?  I can't seem to find
a useful description in the man page or info.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
