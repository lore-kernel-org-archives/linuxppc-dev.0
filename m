Date: Thu, 3 Aug 2000 13:30:45 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
cc: Tom Gall <gall@rochcivictheatre.org>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
In-Reply-To: <Pine.LNX.4.10.10008031130470.12417-100000@zirkon.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10008031326100.425-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000, Michael Schmitz wrote:
> > > While I also enjoyed the flexibility on m68k, some of it was paid for in
> > > terms of increased complexity in head.S and entry.S (and especially head.S
> > > wasn't a bit pretty). I'm not sure how your trouble with the embedded
> > > systems can be solved, we kept separate head.S versions for Macs and other
> > > machines for a while as well because things just got too confusing. Maybe
> > > we need to keep separate versions for embedded and other systems here?
> >
> >   I think we don't want to get too carried away with pulling things
> > apart here. Afterall I think we'd all like to be able to continue to
> > pick up a distro with a bootable kernel that works over a wide variety
> > of machines instead of 10 different kernels to choose from depending on
> > which box you've got.

Note that I never said the various CONFIG_* options have to be mutual
exclusive. Enable them all for a generic kernel for a distro, enable what you
need only for a machine-specific kernel.

> That's exactly what won't work now. A kernel built for PowerMac won't work
> on embedded systems or APUS, and maybe not even on PReP or CHRP.

PowerMac kernels should work on PReP and CHRP as well.

> >   Now obvoiusly I'm going a little overboard here but hopefully you
> > might see what I'm saying. Granted embedded boxes aren't going to care
> > about booting from the install cd but I think the rest of us sure do!
>
> I don't see where we would conflict, all I said was maybe keep embedded
> separate. By all means unify the rest if at all possible.

The rest is unified. But it's so unified that I can't get rid of e.g. all
PowerMac-only code when I want to compile a kernel for a CHRP box. Much
PowerMac specific stuff is indeed freed up later when the pmac section is
released, but that's all.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
