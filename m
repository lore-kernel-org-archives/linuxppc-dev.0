Date: Mon, 8 Jan 2001 17:54:00 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
cc: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: status of ppc support in official 2.4.0 or Alan's 2.4.0-ac1
In-Reply-To: <20010108093204.I19404@opus.bloom.county>
Message-ID: <Pine.LNX.4.05.10101081753120.30839-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Jan 2001, Tom Rini wrote:
> On Mon, Jan 08, 2001 at 04:16:24PM +0000, Iain Sandoe wrote:
> > (for those of us who still haven't had time to tangle with bk ;-)
> >
> > and can I expect it to build?
> > what state does it represent?
> > (i.e. is it a continuation of the same tree - or a rebuild from the 2.4.0
> > final)
>
> The 2_4 tree is building.  If it's not building, report it here.
> It represents what will someday get to Linus.  Hopefully sooner rather than
> later.  It's a new tree which is the old tree.  Cort made a new one, called
> 2_4 and I put all of our changes from 2_3 back in.  It's based off of 2.4.0
> final.
>
> > is there any point trying kernel.org 2.4.0 final? (or ac3 - which I pulled
> > last night)

It may help to create nightly diffs between Linus' 2.4.0 and linuxppc_2_4 and
put them on some FTP site. People still more like patches than bk :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
