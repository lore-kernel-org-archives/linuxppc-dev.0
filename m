Message-ID: <380E0241.AB5C1317@netx4.com>
Date: Wed, 20 Oct 1999 13:56:17 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Raphael Massin <massin@col.bsf.alcatel.fr>
CC: jeff@wa1hco.mv.com, linuxppc-embedded@lists.linuxppc.org, dmalek@jlc.net,
        massin@cu5s33
Subject: Re: /dev/watchdog for onchip MPC860 watchdog?
References: <199910200733.JAA28746@cu5s33.clb>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Raphael Massin wrote:

> ... i prorammed it
> to generate a Non Maskable Interrupt instead of system reset. Those NMIs
> are handled by a special function in the Linux kernel. This function
> can reset the board, using a specific I/O, when too many NMIs occurred
> without any watchdog timer (SWSR) servicing.


That's not exactly the same thing.  You still rely upon some,
although smaller, piece of software and proper operation of your
counter (a memory location that could be corrupted by errant
software) to perform the watchdog service.


> ..... configurations,
> Dan's idea seems perfect.

A far from perfect alternative.......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
