Date: Mon, 17 Sep 2001 19:08:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Board names for 4xx
Message-ID: <20010917190822.K14279@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010914144403.G3851@zax> <20010914072847.R21906@cpe-24-221-152-185.az.sprintbbd.net> <20010917122828.J3851@zax> <20010916211605.D14279@cpe-24-221-152-185.az.sprintbbd.net> <3BA61D1A.3A79E5B9@mvista.com> <3BA620CC.3ACD0547@inn.ericsson.se> <20010917113345.A23163@cpe-24-221-152-185.az.sprintbbd.net> <20010918103530.B1183@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010918103530.B1183@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 18, 2001 at 10:35:30AM +1000, David Gibson wrote:
>
> On Mon, Sep 17, 2001 at 11:33:45AM -0700, Tom Rini wrote:
> >
> > On Mon, Sep 17, 2001 at 06:11:56PM +0200, Kenneth Johansson wrote:
> > > Dan Malek wrote:
> > > >
> > > > Tom Rini wrote:
> > > >
> > > > > I do wish someone else would speak up tho.  Does anyone out there have an
> > > > > opinion?
> > > >
> > > > If the information from /proc is just used for pretty print out of
> > > > information, I really don't care.  If there are applications that read
> > > > this for some internal configuration and flexibility, we better have a
> > > > standard format.
> > > Debian uses /proc/cpuinfo to find out what utility to use for the RTC
> > > (clock,hwclock). This could be fixed if the code from clock was integrated in
> > > hwclock. hwclock tries every method it knows until one works.
> >
> > This is no longer true.  Woody anyways assumes that /dev/rtc will work in
> > the 'standard' way.  But,, debian does parse for machien type for doing
> > board/platform specific modules.
>
> Yes, but last I checked the util-linux install script would still die
> if the machine: field wasn't present at all.  IIRC it was checking for
> PReP machines for some reason.

util-linux is broken then.  All PPC (save APUS) can have a working
/dev/rtc, via CONFIG_PPC_RTC.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
