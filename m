Message-ID: <3A8C11E7.D0CA22F9@mvista.com>
Date: Thu, 15 Feb 2001 12:29:11 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mmu_context_overflow
References: <Pine.LNX.4.05.10102151820520.23079-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> I found this in my kernel message log:
>
> | mmu_context_overflow
>
> running 2.4.1 from January 31 on a CHRP LongTrail with 604e.

I'm assuming this occurred just once.  It's really no big deal
(except it is a one-time overhead to invalidate all contexts).
If it continues to happen, let me know and I'll ask for more
system information.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
