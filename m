Date: Tue, 13 Jan 2004 16:12:30 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Debian PowerPC List <debian-powerpc@lists.debian.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.21-ben2 issues: RTC, Thermal and RTAS
Message-ID: <20040113151230.GA12089@iliana>
References: <20030823171845.GA1963@dat.etsit.upm.es> <20031217011849.GA26643@iliana> <Pine.GSO.4.58.0312171042530.24864@waterleaf.sonytel.be> <20031217095241.GD2283@iliana> <Pine.GSO.4.58.0312171056030.24864@waterleaf.sonytel.be> <20031217100358.GA2655@iliana> <Pine.GSO.4.58.0312171112040.24864@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.GSO.4.58.0312171112040.24864@waterleaf.sonytel.be>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 17, 2003 at 11:13:58AM +0100, Geert Uytterhoeven wrote:
> On Wed, 17 Dec 2003, Sven Luther wrote:
> > On Wed, Dec 17, 2003 at 10:57:07AM +0100, Geert Uytterhoeven wrote:
> > > On Wed, 17 Dec 2003, Sven Luther wrote:
> > > > On Wed, Dec 17, 2003 at 10:43:24AM +0100, Geert Uytterhoeven wrote:
> > > > > On Wed, 17 Dec 2003, Sven Luther wrote:
> > > > > > On Sun, Aug 24, 2003 at 03:18:46AM +1000, J. Javier Maestro wrote:
> > > > > > > I just recompiled the 2.4.21-ben2 kernel several times, trying to get it
> > > > > > > running. I finally fixed the FB problem I was having at compilation, and
> > > > > > > when booting, the kernel froze in the middle of the boot, when trying to
> > > > > > > set the System time. I can track this to the RTC support, since the
> > > > > > > kernel booted nicely when I unset CONFIG_RTC.
> > > > > >
> > > > > > Strange, i am experiencing exactly the opposite behavior, but then i
> > > > > > have a Pegasos, which is of CHRP lineage, and uses a via southbridge.
> > > > >
> > > > > And the VIA SouthBridge has a builtin PC-style RTC, right?
> > > >
> > > > Yep, it does. What about your longtrail, what does it use for RTC ?
> > >
> > > | callisto$ grep rtc .config
> > > | CONFIG_GEN_RTC=m
> > > | CONFIG_RTC=y
> > > | callisto$
> > >
> > > It uses the PC-style RTC driver (genrtc.o is not loaded).
> >
> > Mmm, what was your box again ? a chrp no ?
>
> Yep, CHRP LongTrail. It has a Winbond/Symphony Labs W83C553 SouthBridge.

Could you tell me the content of your rtc OF node ? In particular i am
interested in the reg value (probably 70/71 in isa space or so), and of
the compatible stuff (i have ds1385-rtc).

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
