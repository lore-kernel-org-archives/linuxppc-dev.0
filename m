Date: Tue, 8 Jun 2004 08:27:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Status of 2.6 8560 support.
Message-ID: <20040608152713.GC14242@smtp.west.cox.net>
References: <1086707023.15845.67.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1086707023.15845.67.camel@hades.cambridge.redhat.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 08, 2004 at 04:03:43PM +0100, David Woodhouse wrote:

>
> I need to support the WindRiver PowerQUICC III MPC8560 board in 2.6. I
> see a handful of #ifdef CONFIG_BOOKE in 2.6 but it's not actually
> possible to set it, and parts which are in 2.4 (like motobooke_mmu.c)
> are still missing.
>
> Where's the rest of the 8560 support for 2.6? What needs to be done to
> it to get it merged? You can consider me to have been volunteered ;)

So, I've been hoping to get this done quicker, but it seems the driver
review and subsequent cleanups have taken longer than I had hoped.  So I
guess we'll have to do it in 3 passes:
1) Core bits (arch/ppc/8260_io/commproc.c ->
arch/ppc/syslib/commproc_cpm.c, head_e500.S, etc, etc)
2) Serial driver
3) enet driver(s).

And if the enet drivers get cleaned up quicker, we can of course swap 2
and 3 around.

So, Kumar, can you please post a patch of the core bits?  Or if it's too
big, shoot it to me off-list.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
