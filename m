Message-ID: <3E07715D.4030002@embeddededge.com>
Date: Mon, 23 Dec 2002 15:26:05 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: New invalidate/clean/flush_dcache functions
References: <IGEFJKJNHJDCBKALBJLLCEABFJAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:
> [Resending again as it did not reach the list, is it me or problems with the list?]
>
> How about adding new xxx_dcache_range() functions functions to PPC.
> Below is my suggestion which is more logical and more efficient:

These aren't any different from what we have, other than you give it
a length instead of an ending address.  Someone has to do that
arithmetic anyway, and you chose to do it inside of your new functions
when a caller may already have it available.  We also try to keep these
functions common across multiple architectures, which is especially
important to embedded systems that may share common devices connected
to the processor bus.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
