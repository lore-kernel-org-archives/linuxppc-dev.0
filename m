Date: Fri, 2 Nov 2001 16:57:25 -0700
From: Matt Porter <mmporter@home.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods
Message-ID: <20011102165725.A6391@cx258813-a.chnd1.az.home.com>
References: <20011012111320.B10280@cpe-24-221-152-185.az.sprintbbd.net> <15331.17574.209385.901060@cargo.ozlabs.ibm.com> <20011102185547.B29932@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011102185547.B29932@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Fri, Nov 02, 2001 at 06:55:47PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 02, 2001 at 06:55:47PM -0700, Tom Rini wrote:
>
> On Sat, Nov 03, 2001 at 12:13:10PM +1100, Paul Mackerras wrote:
> > Tom Rini writes:
> >
> > > On Fri, Oct 12, 2001 at 05:32:34PM +1000, Paul Mackerras wrote:
> > >
> > > > I would like to make a complete list of the methods people use to boot
> > > > the PPC/Linux kernel on different platforms.  As a start, here is what
> > > > I can think of off the top of my head:
> > >
> > > All of the 7xx/74xx/8240 boards in _devel boot via zImage.<board> from
> > > network/disk/flash, depending.
> >
> > Would you mind enumerating them for me?  I would like to have a list
> > of the various embedded boards we support in _devel together with the
> > value of <board> in the zImage filename, plus what software is used to
> > load that into memory.
>
> I this this is mostly correct.  Any of the following, I'm pretty sure,
> can also have it thrown in via a BDI.

That's true.  Used often on DINK32 that provides no netboot facility.

> Vendor			Extension		How
> IBM Spruce		.spruce			???

						IBM ROM Monitor

> M.E.N. F1		.menf1			??? (Probably custom fw).
						MENMON
--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
