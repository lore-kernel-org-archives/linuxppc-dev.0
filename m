Message-ID: <39C6262B.A54933C2@agelectronics.co.uk>
Date: Mon, 18 Sep 2000 15:26:52 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
References: <200009122018.WAA00786@piglet.grunz.lu>
		<200009131951.VAA00816@piglet.grunz.lu> <14784.22458.21233.588776@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> It would be cleaner to have the page mapped with a non-cacheable
> mapping while the idle task is clearing it but you still have to be
> careful about cache inconsistencies, particularly if the page is
> mapped twice and one mapping is cacheable and the other isn't.

It might be interesting to try using a DMA engine on MPC 106/107 systems
to clear pages in the background. I've seen some simulations which
suggest that this could be a big win, but I'd have to spend a while
digging through the IEEE archives to find them again.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
