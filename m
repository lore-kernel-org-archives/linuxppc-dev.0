Message-ID: <3D5E77A8.4050009@embeddededge.com>
Date: Sat, 17 Aug 2002 12:19:52 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC860 reorder and invalidate dcache
References: <IGEFJKJNHJDCBKALBJLLEELOFFAA.joakim.tjernlund@lumentis.se> <3D5D88C5.9030402@embeddededge.com> <002f01c245e2$de2223e0$0200a8c0@telia.com> <3D5E508E.90504@embeddededge.com> <000f01c245f9$5429e440$0200a8c0@telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:


> ... The other mapping is used for flash commands and to write data to flash.
> Each time I read I do a invalidate_dcache_range() to pick up updates made from
> the uncached mapping.

Why don't you do a single invalidate after the write to cover the region
you just updated?

> I was just hoping that the 'sync' instruction was an "accident", but now I know
> better.

Those of us that have programmed PowerPC all of these years seldom include
a 'sync' instruction by accident.  We are more likely to not use them and
then discover later they are necessary :-)



	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
