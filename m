Date: Thu, 23 Aug 2001 12:53:02 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Linix PPC Emmbedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: using the little endian bit 4xx mmu
Message-ID: <20010823125302.V23501@altus.drgw.net>
References: <3B853FC3.ECE38D2@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B853FC3.ECE38D2@raleigh.ibm.com>; from rcblach@raleigh.ibm.com on Thu, Aug 23, 2001 at 01:39:15PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Aug 23, 2001 at 01:39:15PM -0400, Ralph Blach wrote:
>
> Is there any hope of getting an ioremap little endian in the 4xx code
> so the tlb would use little endian bit in the tlb?

Do you have an implementation or a patch that does this?

I think we'd be happy to look at it if someone comes up with a nice, clean
implementation.

Most of the developers seem too busy with other problems to work on
something that might take a lot of work, but only works on a small subset
of PPC chips.

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Shulz

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
