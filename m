Date: Mon, 16 Dec 2002 08:01:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marius Groeger <mag@sysgo.de>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Arctic-2 MTD driver
Message-ID: <20021216150123.GH6095@opus.bloom.county>
References: <20021216020922.GH4981@zax.zax> <Pine.LNX.4.40.0212160945060.1222-100000@mag.devdep.sysgo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.40.0212160945060.1222-100000@mag.devdep.sysgo.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 16, 2002 at 09:46:50AM +0100, Marius Groeger wrote:
>
> Hello David,
>
> On Mon, 16 Dec 2002, David Gibson wrote:
>
> > Having committed the core support code for the Arctic-2, here come
> > some drivers for it.  Below is an MTD map for the Arctic-2, derived
> > from beech-mtd.c.  Essentially all it does is provide suitable
> > hardwired partitions.
>
> Can you also post this to the linux-mtd folks?

No point in doing that yet, as the underlying support code for the
Arctic-2 won't be making Marcelo's tree for a while yet.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
