Message-ID: <39AACCE2.791689A@embeddededge.com>
Date: Mon, 28 Aug 2000 16:34:42 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: Dan Malek <dan@netx4.com>, Ronald Wahl <rwa@peppercon.de>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
References: <Pine.GSO.4.10.10008282130010.10747-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:

> xxx_to_virt() is completly impossible (with a decent performance) and IMO
> shouldn't be needed.

Well......there are many devices that perform DMA and must know the
physical address that is often stored in some kind of device descriptor.
I have written drivers that convert back and forth to get this
information.  You would have to keep the address mappings in the
driver somehow.

> Usually one simply posts a patch and gets flamed to death,....

Yeah, and I am usually the one doing the flaming, because I won't
check anything into a kernel tree that doesn't work.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
