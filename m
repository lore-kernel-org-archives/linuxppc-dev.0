Message-ID: <3F5CFCC4.9050309@embeddededge.com>
Date: Mon, 08 Sep 2003 18:03:48 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: virt_to_phys() on 440
References: <20030908213638.4000.qmail@web40910.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Kuschak wrote:

> I think the virt_to_phys() function is incorrect for
> PPC440.  It should call iopa for all 4xx, not only the
> 405.

You won't get any argument for me, but everyone else
will argue with us.  A long, long time ago I got spoiled
using, designing, and implementing orthogonal VM functions.
When I bring up this discussion I'm continually reminded
that Linux isn't this way, it's supposed to be lightweight
and fast.....meaning you have to use different functions
to manage different memory regions with subtle side effects.

> ....  By chance, it happens to work currently if the
> address is in SDRAM, but is always incorrect for
> ioremapped addresses.  virt_to_bus() does the right
> thing.

It will likely always be this way.  You have to keep track
of your own mappings and compute what you need from that,
especially when mapping things for DMA.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
