Date: Mon, 30 Dec 2002 11:12:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel patch: 8xx FEC extensions
Message-ID: <20021230181258.GE5564@opus.bloom.county>
References: <20021230152945.GD5564@opus.bloom.county> <20021230162621.1741CC6139@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021230162621.1741CC6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 30, 2002 at 05:26:16PM +0100, Wolfgang Denk wrote:
> In message <20021230152945.GD5564@opus.bloom.county> you wrote:
> >
> > scripts/Lindent is 'happy', then that's good enough.  Also, is there any
> > reason to go from 'volatile uint *s = &(...->...);' to 'uint s =
> > ...->...;' ?  Maybe it's too early in the morning for me, but why
> > couldn't it be just 'uint *s', if that volatile isn't needed?
[snip a good explanation]

Sounds reasonable.

> > This is on hold for now, and for future patches please keep cleanup
> > seperate from functionality as much as possible.
>
> This _is_ functionality.

It is not part of the multicast functionality, it's either an unrelated
but none the less important bug fix, or like other parts of the patch
just 'cleanup'.  So please in the future submit them as a seperate
logical chunk, since that's how I have to submit them.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
