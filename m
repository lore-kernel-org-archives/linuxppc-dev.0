Message-ID: <39A96FFA.EF350293@embeddededge.com>
Date: Sun, 27 Aug 2000 15:46:02 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: Ronald Wahl <rwa@peppercon.de>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
References: <Pine.GSO.4.10.10008261825550.25785-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:

> IMO the only portable solution would be a memremap (similiar to ioremap).

Coming up with a function name and actually implementing it are two
very different things......ioremap() should do the right thing.
There are also many other issues associated with the macros
bus_to_virt() and virt_to_bus() that are challenging.

> Sure?

Yes I am sure.  Bursting data over the bus is hell of a lot faster,
especially in this case where the PCI bridge can combine these into
a PCI burst transfer as well.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
