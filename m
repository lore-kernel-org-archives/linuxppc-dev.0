Subject: Re: 2.5 and serial console
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030815214846.GA8236@suse.de>
References: <20030504165116.GA22339@suse.de>
	 <20030505172533.GA4762@ip68-0-152-218.tc.ph.cox.net>
	 <20030505174544.GA26356@suse.de>
	 <20030505192910.GA5447@ip68-0-152-218.tc.ph.cox.net>
	 <20030505194410.GA30123@suse.de>
	 <20030507202040.GB20482@ip68-0-152-218.tc.ph.cox.net>
	 <20030815214846.GA8236@suse.de>
Content-Type: text/plain
Message-Id: <1060991189.881.91.camel@gaston>
Mime-Version: 1.0
Date: 16 Aug 2003 01:46:29 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-08-15 at 23:48, Olaf Hering wrote:
>  On Wed, May 07, Tom Rini wrote:
>
> > > I had serial console set. Maybe I screwed my config while hunting for a
> > > workaround.
> > > [*] Support for PowerMac serial ports
> > > [*]   Support for console on serial port
> >
> > Well that explains it then.  The pmac code is bad and still uses
> > CONFIG_SERIAL_CONSOLE.  It needs to be changed, at a miniumum to
> > CONFIG_SERIAL_PMAC_CONSOLE, and the driver really should be ported to
> > the new serial backend.
>
> I'm not the one who can port the driver, but this patch makes it useable
> for me.

The driver has been ported in my tree, I'll send it to Linus rsn, that
is once Linus has merged some other pending patches and I've had time
to test it on a few more configurations.

Also, my current port enables the serial console a bit late, I want to
fix that as well.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
