Message-ID: <3A779137.9598691A@vacuumgenesis.com>
Date: Tue, 30 Jan 2001 20:14:47 -0800
From: Timothy Ritchey <tritchey@vacuumgenesis.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860T FEC
References: <200101300049.f0U0n3G05511@denx.local.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
>
> BTW: I've sent all these patches to Dan and Cort and Ben, so  I  hope
> at least part of it will make it in the official sources.

Thanks! I finally got it up and running, and have ethernet!!!. I had to
make some changes WRT some of the MII commands, which I don't think
would impact anyone else, but I also had to change the order of setting
the fecp->imask, and clearing the interrupts. The patch had it clearing
the interrupts, then setting the mask. It needed to be the otherway
around, at least for me.

Cheers,
tim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
