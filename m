Date: Sat, 30 Jun 2001 23:45:08 -0700 (PDT)
From: Paul White <pwhite@networkrobots.com>
To: Dan Malek <dan@mvista.com>
Cc: jtm@smoothsmoothie.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
In-Reply-To: <3B3EB070.B8AA5EDE@mvista.com>
Message-ID: <Pine.LNX.4.21.0106302344140.13760-100000@stimpy.networkrobots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

hehe..  I went the harder way, and worked around the dcbz instructions
to allow me to disable data cache all together.

Btw, we also fixed our Cache Coherency problem on Friday.  It happened
to be a bug in our system controller chip.  They found it and gave us
a work-around.

Thanks,

Paul W.

On Sun, 1 Jul 2001, Dan Malek wrote:

> Paul White wrote:
>
> > Is there something I'm missing here?
>
> Yeah...you can run 'nobats' as a start option and get the memory
> mapped as pages (or fix your system so cache coherency works :-).
>
>
> 	-- Dan
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
