Message-ID: <3C45B92A.8030701@embeddededge.com>
Date: Wed, 16 Jan 2002 12:32:26 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Sarnath Kannan <sparc64@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC850 EmbPlat / Intro Please
References: <20020116064237.14891.qmail@mailweb17.rediffmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sarnath Kannan wrote:

>  If any1 of you could give me a short concise
> description of the MPC850/823/Embedded planet board,

It's a production board with processor, memory and I/O
connectors.  Their intention is to make it cost effective
for people to design these into systems rather than have
you spend time designing your own processor/memory complex.
Basically, design an I/O card and you are done.  There are
many success stories doing this.  The boards have a proprietary,
but consistent form factor so you can switch among a number of
their different configurations as you may need over the life
of a product.  They will also custom build and sell designs.
These boards have copyright and proprietary technology, so
people that buy a few for development boards and then copy it
into their own design could technically be held liable for
infringement on this design.

> .... Can any1 of you
> throw light upon issues involving enabling linux
> on EmbPlanet ?

Linux has run on these boards for years without trouble, and
is deployed in many products using these boards.  You can pick
up the sources from the usual PowerPC repositories, and ready to
run kits from MontaVista.


Have fun!


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
