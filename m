Date: Tue, 17 Dec 2002 15:16:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Arctic-2 MTD driver
Message-ID: <20021217041642.GT4981@zax.zax>
References: <20021216020922.GH4981@zax.zax> <20021216144349.GG6095@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021216144349.GG6095@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 16, 2002 at 07:43:49AM -0700, Tom Rini wrote:
>
> On Mon, Dec 16, 2002 at 01:09:22PM +1100, David Gibson wrote:
>
> > Having committed the core support code for the Arctic-2, here come
> > some drivers for it.  Below is an MTD map for the Arctic-2, derived
> > from beech-mtd.c.  Essentially all it does is provide suitable
> > hardwired partitions.
> >
> > Again, any comments before I commit this?
>
> Only that it reminded me that drivers/mtd/maps/Config.in needs some
> cleanups for PPC32, I'll be commiting those momentarily.  But other than
> that, it looks fine.

Ok, updated for your changes, and committed.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
