Date: Fri, 27 Aug 2004 14:31:34 +0200 (MEST)
From: "Patrick Huesmann" <tricknology@gmx.de>
To: "Mark Chambers" <markc@mail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
References: <002c01c48c30$f663f000$0301a8c0@chuck2>
Subject: Re: Kernel oops when initializing ethernet driver
Message-ID: <30642.1093609894@www18.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> Machine check means you generated an address that the hardware was
> unable to complete - you wrote (or read) a non-existent address.  It's
> mapped in the MMU ok but doesn't exist on the board.

Do you mean something like a "bus error"?

> Memory mapped I/O tends to exist in tight little clusters, and if you get
> your address off by 1 or something you get a machine check.  So you
> gotta find exactly what address it's writing to and why it's off -
> probably
> .h configuration kind of thing somewhere...

Interestingly, the kernel only crashes when accessing that one particular
register (at offset 0x0040). Every other register in that range can be
written to and read from w/o problems.

> Hope that's some kind of help :-)

Thanks a lot,
Patrick


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
