Date: Tue, 29 Aug 2000 09:29:56 +0200 (CEST)
From: Ronald Wahl <rwa@peppercon.de>
To: Dan Malek <dan@netx4.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
In-Reply-To: <39AA8476.70572FD9@embeddededge.com>
Message-ID: <Pine.LNX.4.21.0008290928240.634-100000@goliath.issistance.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 28 Aug 2000, Dan Malek wrote:

> Ronald Wahl wrote:
>
> > ... But I had to write an
> > invalidate_dcache_range() first.
>
> What kernel are you using?  This should have been there, the
> Ethernet driver does this......

Hmm, it's an 2.2.13. I've seen flush_dcache_range() there but not
invalidate_dcache_range().

ron


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
