Message-ID: <397C7D9C.77735326@embeddededge.com>
Date: Mon, 24 Jul 2000 13:32:12 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405gp pci mapping registers
References: <397C7361.3E97D93D@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:

> This is interesting because since the 405gp has three sets of these
> register leading to split mappings.

It isn't conceptually any different than the enormous flexibility of
the MPC8xx memory controller, and is very similar to PCI bridges
on the MPC8xx boards.

> My question is this.  How should we manage this kind of address
> flexability?

You stamp a "Linux" memory map and leave it alone.  Just because
you have the flexibility doesn't imply it should be exposed as
configuration options.  When I did the MPC8xx port, I chose to utilize
all of the flexibility so I could make the memory map look as much
like Prep as possible.  All of the assumptions or knowledge about the
PowerPC workstation memory maps are mostly valid for the 8xx as well.
I used the flexibility to emulate something that already existed.

I learned a valuable lesson, and hope others will do the same.  Use
that flexibility so make all of the systems look similar.  Otherwise,
you will end up on a technology island, frustrated that the rest of
the world is moving forward with new features and you are unable to
keep up with your own little custom hacks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
