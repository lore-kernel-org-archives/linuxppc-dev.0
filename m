Date: Thu, 1 Apr 2004 10:35:55 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: Wolfgang Denk <wd@denx.de>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Proposed Kconfig update patch for help text 
In-Reply-To: <812363C6-8371-11D8-9FF0-000A95A07384@sands-edge.com>
Message-ID: <Pine.GSO.4.58.0404011035190.12755@waterleaf.sonytel.be>
References: <20040331230620.ACC3BC10A4@atlas.denx.de>
 <812363C6-8371-11D8-9FF0-000A95A07384@sands-edge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 31 Mar 2004, John Whitney wrote:
> We can put in "8xx", but I didn't think that the listed processors was
> supposed to be an exhaustive list (just some examples).   Shall we just
> prune them down to "8xx", "4xx", etc.?

While you're at it, perhaps s/7400/74xx/ for consistency, too?

> On Mar 31, 2004, at 6:06 PM, Wolfgang Denk wrote:
> > In message <B755A2F6-8364-11D8-9FF0-000A95A07384@sands-edge.com> you wrote:
> >>
> >> A couple of trivial changes for the processor choice help text to
> >> make it a bit clearer.
> > ...
> >>        types (601, 603, 604, 740, 750, 7400), the Motorola embedded
> >> -     versions (821, 823, 850, 855, 860, 8260), the IBM embedded
> >> versions
> >> +     versions (821, 823, 850, 855, 860, 82xx), the IBM embedded
> >
> > How about types like 857, 862, the 866 family, the 885 family, ... ?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
