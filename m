Message-ID: <007b01c3f648$14ce2bc0$4a34a8c0@av34>
From: "Marcus Overhagen" <marcus.overhagen@ims.fhg.de>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <A3240F62EF3C2749B1A25D3BC9548F410309FE@ExchWENZ02.wenz.global.vpn> <20040217221957.GH16881@smtp.west.cox.net>
Subject: Re: 2.6 kernel ppc tree
Date: Wed, 18 Feb 2004 18:53:13 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Tom Rini" <trini@kernel.crashing.org> wrote:

> The linuxppc-2.5 tree already has most of this done (as it did as of
> 2.6.1 or 2.6.2, I haven't re-checked the drivers).  However, head_8xx.S
> still needs some updates for VM/exception changes.

I tried compiling 2.6.3 for a MPC850 based board today, and got the same problem
with uart.c (as well as a few other minor errors). However, I have trouble getting
the 2.5 uart.c file by bitkeeper, can somebody please send it to me by (private) email?

I also noticed that the Kconfig file, as well as the uart.c file has very few options
to support custom pin assigments, for example I couldn't configure SCC2 as
Ethernet and at the same time SCC3 as serial. Is someone working on this, or
must I do this myself?
And what about hardware handshake signals, like RTS/CTS, does anyone
have that working?

regards
Marcus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
