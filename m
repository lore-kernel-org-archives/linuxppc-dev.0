Message-ID: <38926E6B.706491A1@netx4.com>
Date: Fri, 28 Jan 2000 23:36:59 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: raphael.bossek@solutions4linux.de
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cachable / Non-cachable memory
References: <E12E7dQ-0004I1-00@mx00.kundenserver.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


raphael.bossek@solutions4linux.de wrote:


> how does Linux specify memory regions as cachable and non-
> cachable?


Any memory mapping request outside of the range of real
memory is mapped uncached/guarded.  Look at drivers/char/mem.c

Driver requests to ioremap() are mapped uncached/guarded.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
