Date: Mon, 24 May 2004 08:24:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Rune Torgersen <runet@innovsys.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 CPM DP ram free function
Message-ID: <20040524152454.GO6763@smtp.west.cox.net>
References: <20040521192333.GI6763@smtp.west.cox.net> <20040524135041.AB280C109F@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040524135041.AB280C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 24, 2004 at 03:50:36PM +0200, Wolfgang Denk wrote:

> In message <20040521192333.GI6763@smtp.west.cox.net> you wrote:
> >
> > First, when this has come up in the past, the first question is why is
> > this useful, given that with the hardware and peripherals in question,
> > loadable drivers aren't really useful (and don't shoot the messenger
> > please).
>
> As has been discussed before, too, loadable drivers are  very  useful
> during  development;  they  can  even be useful in production systems
> when you need and easy way to update software updates  in  a  running
> system.

I suppose once Dan's comments are addressed, since I thought he's been
the biggest objector to all of the previous implementations (or, my
memory is faulty, and every one of them just fell on the ground), we can
push this out, at least for cpm2 stuff.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
