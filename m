Date: Thu, 1 Apr 2004 10:03:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Wolfgang Denk <wd@denx.de>, Kumar Gala <kumar.gala@motorola.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Proposed Kconfig update patch for help text)
Message-ID: <20040401170324.GC26876@smtp.west.cox.net>
References: <67423B18-83E3-11D8-B6FB-000393DBC2E8@motorola.com> <20040401150211.90D85C10A4@atlas.denx.de> <20040401161622.GA26876@smtp.west.cox.net> <406C4A26.3040107@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <406C4A26.3040107@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 11:58:14AM -0500, Dan Malek wrote:
> Tom Rini wrote:
>
> >In all seriousness, when the 52xx code for 2.4 was brought up, there
> >were a number of objections to the Motorola provided code,
>
> Does anyone actually use this code?  From the work I've done it appears
> the FEC implements it's own DMA, other peripherals are used in programmed
> I/O
> mode, and stuff I have done I've found it easier to just write my own
> code manage the DMA.  IMHO we should just punt this stuff for Linux,
> now that there is more public interest start collaborating on a better
> solution, and maybe just use what Mot provided as documentation filler.
> The Motorola solution seems like an attempt to be everything for everyone.

FWIW, I think I lean towards this (which to be clear if I wasn't before,
is the second option I described) approach as well.  Not that I have hw
handy. :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
