Date: Thu, 8 Feb 2001 20:43:01 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: DMA mapping and loadable modules
In-Reply-To: <3A82EED9.59E1519D@mvista.com>
Message-ID: <Pine.GSO.4.10.10102082040390.19423-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Thu, 8 Feb 2001, Dan Malek wrote:

> There is a problem when loadable drivers with "static" data stuctures
> try to determine the physical address for DMA.  The "virt_to_bus"
> macro doesn't work for these (or for any dynamically allocated memory).

Sure, they can use get_free_page/kmalloc and it will work.

> These drivers will work fine when compiled in, and break when loaded
> as modules.

The same problem exists on any architecture.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
