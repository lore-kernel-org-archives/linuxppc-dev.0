Date: Mon, 28 Aug 2000 23:33:45 +0200 (MET DST)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@netx4.com>
cc: Ronald Wahl <rwa@peppercon.de>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
In-Reply-To: <39AACCE2.791689A@embeddededge.com>
Message-ID: <Pine.GSO.4.10.10008282325310.16966-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> Well......there are many devices that perform DMA and must know the
> physical address that is often stored in some kind of device descriptor.
> I have written drivers that convert back and forth to get this
> information.  You would have to keep the address mappings in the
> driver somehow.

Hmm, I only know one driver, where such stuff is needed, but due to lack
of such hardware I never had to deal with this myself.
Anyway, actually in the new page structure there are two fields that are
AFAIK only used by the page cache - mapping and index. With that you can
do a very fast physical to virtual (uncached) translation. (Ok, I take
back that it's impossible :) )

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
