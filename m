Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Fri, 2 Nov 2001 18:55:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods
Message-ID: <20011102185547.B29932@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011012111320.B10280@cpe-24-221-152-185.az.sprintbbd.net> <15331.17574.209385.901060@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15331.17574.209385.901060@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Nov 03, 2001 at 12:13:10PM +1100, Paul Mackerras wrote:
> Tom Rini writes:
>
> > On Fri, Oct 12, 2001 at 05:32:34PM +1000, Paul Mackerras wrote:
> >
> > > I would like to make a complete list of the methods people use to boot
> > > the PPC/Linux kernel on different platforms.  As a start, here is what
> > > I can think of off the top of my head:
> >
> > All of the 7xx/74xx/8240 boards in _devel boot via zImage.<board> from
> > network/disk/flash, depending.
>
> Would you mind enumerating them for me?  I would like to have a list
> of the various embedded boards we support in _devel together with the
> value of <board> in the zImage filename, plus what software is used to
> load that into memory.

I this this is mostly correct.  Any of the following, I'm pretty sure,
can also have it thrown in via a BDI.

Vendor			Extension		How
IBM Spruce		.spruce			???
Force PowerCore		.pcore			PowerBoot (Force firmware)
Force PowerPMC 250	.pcore			PowerBoot
M.E.N. F1		.menf1			??? (Probably custom fw).
Motorola LoPEC		.pplus/.bugboot[1]	PPCBUG
Motorola MCPN765	same			same
Motorola MVME5100	same			same
Motorola PrPMC750	same			same
Motorola PrPMC750	same			same
Motorola Sandpoint	.sandpoint		DINK32
SBS Adirondack	- Uses runlnx, no in-kernel booting bits
SBS K2			.k2			pmon
Zynx 4500		.zx4500			??

Why is the how important?  With the exception of firmware-deficiencies,
the current wrapper doesn't really care what it came from.  And they
usually don't provide much in the way of information about the board
(along the lines of how OF does).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
