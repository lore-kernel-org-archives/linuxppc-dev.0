Message-ID: <3DF0FE5F.1050409@embeddededge.com>
Date: Fri, 06 Dec 2002 14:45:35 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
References: <3DF0A4D9.4030603@intracom.gr> <IGEFJKJNHJDCBKALBJLLCEJFFIAA.joakim.tjernlund@lumentis.se> <20021206085909.B17918@home.com> <3DF0D6B6.2050307@embeddededge.com> <20021206112901.A18257@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:

> That's what I said...but you clipped it out.  Once again,
> consistent_alloc provides the caller everything they need.
> An uncached mapping, a phys address, and from that you can use
> __va() to get the cached mapping.

Well, in my defense.......I think you said you can use __va()
to get a kernel virtual address :-)  To further confuse thing,
yes it will give you a virtual address, but it isn't one that
you want to use.


> Seemed clear enough to me the first time.  My definition of a
> "kernel virtual address" is the lowmem cached mapping.

It wasn't clear to me, and "kernel virtual address" really can't
carry any other attributes since they are used to map a variety
of address spaces, including non-cached and highmem :-)  You
need to update your glossary :-)

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
