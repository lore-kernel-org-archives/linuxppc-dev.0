Message-ID: <3CB43E6F.4020804@embeddededge.com>
Date: Wed, 10 Apr 2002 09:30:23 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Bootloader (Re: CONFIG_GENERIC_PPC32)
References: <0204091952.AA24042@ivan.Harhan.ORG> <20020410102842.21408@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


benh@kernel.crashing.org wrote:

> Just for your information, I noticed the OpenBIOS folks ....

A few embedded boards have done this in the past, in particular
all of the Cogent Computer boards.

The only advantage was for the few (one :-) PCI I/O boards that
may have OF initialization roms.  In all other cases I found
it a PITA, because no one cares to write any documentation
about how it runs on their boards.  The response was "It's
standard OF".....yeah, right.

IMHO, if we would just standardize on ASCII bi_recs we would
actually make some progress :-).  If you want an OS in a boot
rom, just flash Linux and get it over with.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
