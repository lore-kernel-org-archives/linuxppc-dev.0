Subject: Re: ppc LE questions (seeking help hand info pointers)
To: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 20 Sep 2001 10:10:01 -0700 (PDT)
Cc: geert@linux-m68k.org (Geert Uytterhoeven),
	mbs@mc.com (Mark Salisbury),
	linuxppc-dev@lists.linuxppc.org (Linux/PPC Development)
In-Reply-To: <20010920091221.H13721@cpe-24-221-152-185.az.sprintbbd.net> from "Tom Rini" at Sep 20, 2001 09:12:21 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20010920171002.37DCA2B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
> On Thu, Sep 20, 2001 at 06:07:48PM +0200, Geert Uytterhoeven wrote:
> > On Thu, 20 Sep 2001, Tom Rini wrote:
> > > On Thu, Sep 20, 2001 at 11:42:39AM -0400, Mark Salisbury wrote:
> > > > question 4. assuming I was willing to deliver a clean, complete LE
> > > > enabling patch (including devices that are relevant to me), as a compile
> > > > time config option and maintain that patch, what would be the primary
> > > > obstacle to inclusion in the main line.
> > >
> > > The objection to being an arch that attempts to support both LE and BE.
> >
> > Note that we already have a precedent: mips and mipsel, both in arch/mips/.
>
> And SH too, iirc.  I know it can be done.  But do we want to do it is the
> question.

At least in the case of SH, there's a good reason. There's an external pin
that controls the native endianness of the processor, and most setups just
have it forcibly pulled high or low. I suspect the MIPS is the same reason,
since it's used in similar situations. We don't have that excuse with ppc.
Someone would have to come up with an excuse along the lines of "existing
hardware won't work unless we do this" like it would have been for SH.
(I had to work with the SH4e as used by Sega in the Dreamcast...)

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
