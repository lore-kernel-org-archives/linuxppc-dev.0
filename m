Date: Mon, 8 May 2000 11:49:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: Daniel Jacobowitz <drow@false.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: problem with Makefile
In-Reply-To: <Pine.LNX.3.96.1000507234646.3380B-100000@deepspace.mklinux.org>
Message-ID: <Pine.LNX.4.10.10005081148230.312-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 7 May 2000, David A. Gatwood wrote:
> On Mon, 8 May 2000, Daniel Jacobowitz wrote:
> > On Mon, May 08, 2000 at 01:26:05PM +0800, Rolf Liu wrote:
> > >
> > > current work
> > > is to translate the Makefile of linux-ppc into a standard one, such as one
> > > for windows-based
> > > Makefile,which is meaningful to other standard "make" utilities,including
> >
> > There is a standard make.  It's POSIX, I believe.  The linux makefile
> > is pretty close to it.  Why on earth would you want to use Microsoft or
> > Borland tools (which are nmake, not make, IIRC) to build a kernel?
>
> As a fun exercise?
>
> Seriously, though, what would be good would be to modify the makefile to
> eliminate all gnu extensions, i.e. converting it into a pure lowest-
> common-denominator makefile (yes, it's probably POSIX).  That would allow
> it to be built under other OSes, including Windoze, but also *BSD, Darwin,
> MacOS X, etc.  That having been said, it's a pain in the backside to do
> that sort of thing, so I wish you lots of luck.  ;-)

WHY?!?

I once read in a guide about writing makefiles (can dig up the reference if you
want):

    Don't try to write portable Makefiles, use a portable make (i.e. GNU make)

And I agree with this...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
