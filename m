Date: Tue, 12 Aug 2003 15:23:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Gary Thomas <gary@mlbassoc.com>,
	Dan Malek <dan@embeddededge.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Build issues with 2.6.0-test3
Message-ID: <20030812222329.GO807@ip68-0-152-218.tc.ph.cox.net>
References: <3F33BC10.8060407@imc-berlin.de> <1060715616.31273.759.camel@hermes> <20030812215420.GN807@ip68-0-152-218.tc.ph.cox.net> <200308130109.05741.tglx@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308130109.05741.tglx@linutronix.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 13, 2003 at 01:09:05AM +0200, Thomas Gleixner wrote:
> On Tuesday 12 August 2003 23:54, Tom Rini wrote:
> > > > >
> > > > > It seems to be [virtually] the same as in
> > > > >   arch/ppc/8xx_io/uart.c
> > > > >   drivers/char/amiserial.c
> > > > >   drivers/char/serial_tx3912.c
> > > > >   drivers/char/sh-sci.c
> > > > >   drivers/macintosh/macserial.c
> > > >
> > > > Those are all of the obsolete, and probably broken drivers.
> > > > drivers/serial is where all of the 'new' and working serial drivers
> > > > are. If you've got some time, the 8260 serial driver really should be
> > > > re-written as a driver inside of drivers/serial. :)
> > >
> > > I'll look into this.  Can you suggest a good driver to use as guidance?
> >
> > For the conversion? Not off-hand.  But there should be some docs on how
> > to write these drivers on the ARM pages (RMK wrote this driver /
> > abstraction set), or just skim a few of the non-'core' files under
> > drivers/serial to see what's needed on the driver-specific part.
>
> I have a nearly ready to use driver for MPC860, which uses driver/serial.c.
> There is just an issue regarding startup, when the mmu is not up.
>
> Maybe it can be helpful. It has support for configurable pins and flowcontrol.
>
> If somebody is interrested, I can provide the code and some help to get it
> running.

I'd be interested in looking at it.  Do you have other patches to bring
MPC860 support for 2.6 up to date?  Or is this using the 2.4 version of
drivers/serial?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
