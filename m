Date: Mon, 17 Sep 2001 11:33:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Board names for 4xx
Message-ID: <20010917113345.A23163@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010914144403.G3851@zax> <20010914072847.R21906@cpe-24-221-152-185.az.sprintbbd.net> <20010917122828.J3851@zax> <20010916211605.D14279@cpe-24-221-152-185.az.sprintbbd.net> <3BA61D1A.3A79E5B9@mvista.com> <3BA620CC.3ACD0547@inn.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BA620CC.3ACD0547@inn.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 17, 2001 at 06:11:56PM +0200, Kenneth Johansson wrote:
> Dan Malek wrote:
> >
> > Tom Rini wrote:
> >
> > > I do wish someone else would speak up tho.  Does anyone out there have an
> > > opinion?
> >
> > If the information from /proc is just used for pretty print out of
> > information, I really don't care.  If there are applications that read
> > this for some internal configuration and flexibility, we better have a
> > standard format.
> Debian uses /proc/cpuinfo to find out what utility to use for the RTC
> (clock,hwclock). This could be fixed if the code from clock was integrated in
> hwclock. hwclock tries every method it knows until one works.

This is no longer true.  Woody anyways assumes that /dev/rtc will work in
the 'standard' way.  But,, debian does parse for machien type for doing
board/platform specific modules.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
