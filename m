Date: Thu, 1 Apr 2004 09:16:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Kumar Gala <kumar.gala@motorola.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: mpc5xxx support (Was: Re: Proposed Kconfig update patch for help text)
Message-ID: <20040401161622.GA26876@smtp.west.cox.net>
References: <67423B18-83E3-11D8-B6FB-000393DBC2E8@motorola.com> <20040401150211.90D85C10A4@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040401150211.90D85C10A4@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 05:02:06PM +0200, Wolfgang Denk wrote:

>
> In message <67423B18-83E3-11D8-B6FB-000393DBC2E8@motorola.com> you wrote:
> >
> > Also, what about 52xx?
>
> Excellent question. OTOH - what do we need a Kconfig option for, when
> the whole 52xx code is still missing in the official trees?   Tom?

I'll take the high road and avoid an easy april fools joke here.

In all seriousness, when the 52xx code for 2.4 was brought up, there
were a number of objections to the Motorola provided code, from it's
buggy to it being unacceptable crap.  Finally, 2.4 is about to enter a
"deep freeze", or so Marcelo intends at least, so I think it's out of
the question for the mainline.  I don't mind keeping the
linux-2.4-mpc5xxx tree up to date so others can pull for what they need,
but it's a dead end.

For 2.6, I think one of the following options needs to be done.
- Motorola code, cleaned up with input from the community (and the bits
  Linux just doesn't need, left out).
- Ignore the Motorola code, or since it's GPL (must be to be in the
  kernel, so I'm just making the assumption here...) use it as a guide
  for how things work to implement a clean Linux implementation of the
  code.   I know there's someone working on this (who pops up on
  #mklinux on freenode from time to time) but I don't know how far
  they've gotten.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
