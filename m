Date: Tue, 17 Dec 2002 07:59:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Georg Klug <gklug@giga-stream.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Possible problem in asm/bitops.h
Message-ID: <20021217145901.GH2513@opus.bloom.county>
References: <20021212152851.GE19456@opus.bloom.county> <FFECLICFNBJAHONLGAKMAEFOCHAA.gklug@giga-stream.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FFECLICFNBJAHONLGAKMAEFOCHAA.gklug@giga-stream.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 17, 2002 at 10:10:09AM +0100, Georg Klug wrote:

> > I suspect the actual problem is that iproute2 only needs
> > a very small amount of what is in include/linux/inetdev.h
>
> That might be true. But would the solution be to copy the linux/inetdev.h
> to a local directory and change that file until it doesn't need the file
> asm/bitops.h anymore?

Correct.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
