Message-ID: <38E2B00D.E65880E7@embeddededge.com>
Date: Wed, 29 Mar 2000 20:38:21 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Tiny fix to fec.c for RPX boards using only fast ethernet
References: <20000330001115.4B3FF5067E@brixi.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> .... Unfortunately, it isn't desirable if the
> SCC port isn't being used, because it still renumbers the FEC MAC address from
> the one in the board info structure.

Why don't you want this?  Ethernet addresses are supposed to be assigned
to MACs.  It's not a good idea to have a MAC appear at different addresses.
This is why it always assigns the same address.

> ..... It also makes the decision non-board-specific, so other boards
> with dual FEC & SCC ports benefit too:

That's not good either.  I know how EP assigns Ethernet addresses, so
I can do this.  Manufacturers are supposed to supply Ethernet addresses
for every MAC they support.  The "right" way is to have multiple, known
unique addresses assigned to boards that have multiple MACs.  Other
boards may (should) require different assignment methods.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
