Message-ID: <3A6342EA.DEA7FA9B@vacuumgenesis.com>
Date: Mon, 15 Jan 2001 10:35:22 -0800
From: Timothy Ritchey <tritchey@vacuumgenesis.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kswapd Oops
References: <3A625423.E0F6C9AC@vacuumgenesis.com> <3A628C9B.489E401A@mvista.com> <3A633075.5952B4C0@vacuumgenesis.com> <3A6331BF.FB53A3FF@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> That kernel _works_.  If you can't boot that one, you better start
> looking elsewhere for problems.

That is what I figured, although I had to make some changes to get the
FEC driver to compile (net/core/dev.c refers to cpm_enet_init, but not
fec_enet_init, which seems to work if you want to use the scc ethernet I
suppose, but does not work for the fec driver).

> Are you including the software work arounds for the CPU6 silicon
> errata?

yes

> Yeah, you have some hardware problems. <SNIP> The problems
> you see are quite typical of a memory controller configuration
> or a processor/memory board layout problem.

ARRRGGGGHHH. You can't imagine how much this pains me. Well.... perhaps
you can :) I am going to disable everything I can WRT caches, etc. and
see if it clears up.

>         I like MMUs because I don't have a real life.

How appropriate in this situation...

Thanks,
tim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
