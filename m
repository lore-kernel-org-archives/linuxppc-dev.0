From: Benjamin Herrenschmidt <bh40@calva.net>
To: Adrian Cox <apc@agelectronics.co.uk>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: zeroing pages in the idle task?
Date: Mon, 18 Sep 2000 16:41:49 +0200
Message-Id: <20000918144149.27565@mailhost.mipsys.com>
In-Reply-To: <39C6262B.A54933C2@agelectronics.co.uk>
References: <39C6262B.A54933C2@agelectronics.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> It would be cleaner to have the page mapped with a non-cacheable
>> mapping while the idle task is clearing it but you still have to be
>> careful about cache inconsistencies, particularly if the page is
>> mapped twice and one mapping is cacheable and the other isn't.
>
>It might be interesting to try using a DMA engine on MPC 106/107 systems
>to clear pages in the background. I've seen some simulations which
>suggest that this could be a big win, but I'd have to spend a while
>digging through the IEEE archives to find them again.

I didn't find any mention of a DMA engine in the MPC106... Or did I miss
something ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
