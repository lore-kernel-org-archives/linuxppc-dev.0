Date: Mon, 16 Dec 2002 07:43:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Arctic-2 MTD driver
Message-ID: <20021216144349.GG6095@opus.bloom.county>
References: <20021216020922.GH4981@zax.zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021216020922.GH4981@zax.zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 16, 2002 at 01:09:22PM +1100, David Gibson wrote:

> Having committed the core support code for the Arctic-2, here come
> some drivers for it.  Below is an MTD map for the Arctic-2, derived
> from beech-mtd.c.  Essentially all it does is provide suitable
> hardwired partitions.
>
> Again, any comments before I commit this?

Only that it reminded me that drivers/mtd/maps/Config.in needs some
cleanups for PPC32, I'll be commiting those momentarily.  But other than
that, it looks fine.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
