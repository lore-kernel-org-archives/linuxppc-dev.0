Message-ID: <3AF710DC.37209810@mvista.com>
Date: Mon, 07 May 2001 17:17:16 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Eli Chen <eli@routefree.com>
Cc: brian.kuschak@skystream.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <027b01c0d728$9a702b80$4b00000a@foolio1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Heh....the best free help wasn't available when I wrote that last
message, so I guess I'll take a stab at an answer :-).

Eli Chen wrote:

> ..........  They all seem to be
> related to a inconsistency with reference counters, which led me to suspect
> a problem with atomic instructions in our kernel.

That's an interesting piece of information......

There have been problems with the directory entry counters in
older 2.3.99/2.4 kernels.  The 4xx development has kind of been on
a planet all by it's lonesome for a long time, and I am now trying
to bring it back into the mainstream.  It could very well be there
were some generic kernel bug fixes that were missed in the 4xx
kernel.

> ..... I have replaced the
> lwarx/stcrx pairs in include/asm-ppc/atomic.h with code that just turns off
> and on interrupts,

What version of silicon do you have, and what platform are you using?

> ...  This is really just a work around for us until we find out what
> is the real problem.

Is there some simple test I can use to trigger this problem?  It
would be nice if you could try a "newer" kernel from FSM Labs.  This
was originally in the linuxppc_2_5 tree, and we are merging/changing
trees at the moment.  I don't remember the URL......TOM, can you
provide some insight?


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
