Date: Wed, 13 Aug 2003 01:09:05 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Build issues with 2.6.0-test3
In-reply-to: <20030812215420.GN807@ip68-0-152-218.tc.ph.cox.net>
To: Tom Rini <trini@kernel.crashing.org>,
	Gary Thomas <gary@mlbassoc.com>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Reply-To: tglx@linutronix.de
Message-id: <200308130109.05741.tglx@linutronix.de>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <3F33BC10.8060407@imc-berlin.de>
 <1060715616.31273.759.camel@hermes>
 <20030812215420.GN807@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tuesday 12 August 2003 23:54, Tom Rini wrote:
> > > >
> > > > It seems to be [virtually] the same as in
> > > >   arch/ppc/8xx_io/uart.c
> > > >   drivers/char/amiserial.c
> > > >   drivers/char/serial_tx3912.c
> > > >   drivers/char/sh-sci.c
> > > >   drivers/macintosh/macserial.c
> > >
> > > Those are all of the obsolete, and probably broken drivers.
> > > drivers/serial is where all of the 'new' and working serial drivers
> > > are. If you've got some time, the 8260 serial driver really should be
> > > re-written as a driver inside of drivers/serial. :)
> >
> > I'll look into this.  Can you suggest a good driver to use as guidance?
>
> For the conversion? Not off-hand.  But there should be some docs on how
> to write these drivers on the ARM pages (RMK wrote this driver /
> abstraction set), or just skim a few of the non-'core' files under
> drivers/serial to see what's needed on the driver-specific part.

I have a nearly ready to use driver for MPC860, which uses driver/serial.c.
There is just an issue regarding startup, when the mmu is not up.

Maybe it can be helpful. It has support for configurable pins and flowcontrol.

If somebody is interrested, I can provide the code and some help to get it
running.

--
Thomas
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
