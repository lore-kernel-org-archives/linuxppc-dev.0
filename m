Message-ID: <3AA57307.E6AA26FF@mandrakesoft.com>
Date: Tue, 06 Mar 2001 18:30:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: Brad Parker <brad@parker.boston.ma.us>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm/io.h; why does writel() write an le32 on ppc?
References: <200103062315.SAA01659@p2.parker.boston.ma.us>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Parker wrote:
> Sorry to be daft, but why does writel() write an le32 on the ppc?
> (is PCI defined as little endian?)

Yes.  But there is always __raw_{read,write}[bwl].  That is part of the
API too.

Caveat programmer, though: IIRC there are other differences besides
endian when using __raw_xxx.  I think there might be a lack of flushing,
etc., too.

--
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
