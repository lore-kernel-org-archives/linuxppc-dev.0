Date: Wed, 10 Apr 2002 08:09:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Message-ID: <20020410150936.GB26754@opus.bloom.county>
References: <20020409194721.GI1331@opus.bloom.county> <0204092005.AA24074@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204092005.AA24074@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 09, 2002 at 01:05:42PM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > And the other point is that this makes it less clean to add in a new
> > board port.
>
> No, it's perfectly clean, you just throw one more machine into the
> CONFIG_GENERIC_PPC32 framework.

You're touching c files.  See Pauls comments about that.

> > But what if they aren't really configurable?
>
> They may not be configurable on a given board, but they are configurable given
> an infinite number of boards.

So why not ask it for boards where it's reasonable?  IE asking about
8xx enet on 6xx is harmless, but why do it?

> > You could turn off
> > CONFIG_PCI, but I don't think you'd get too far on most[1] systems.
>
[snip]

Yes, and I said most, not all, most. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
