Date: Mon, 5 May 2003 21:44:10 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.5 and serial console
Message-ID: <20030505194410.GA30123@suse.de>
References: <20030504165116.GA22339@suse.de> <20030505172533.GA4762@ip68-0-152-218.tc.ph.cox.net> <20030505174544.GA26356@suse.de> <20030505192910.GA5447@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20030505192910.GA5447@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Mon, May 05, Tom Rini wrote:

> On Mon, May 05, 2003 at 07:45:44PM +0200, Olaf Hering wrote:
> >  On Mon, May 05, Tom Rini wrote:
> >
> > > On Sun, May 04, 2003 at 06:51:16PM +0200, Olaf Hering wrote:
> > >
> > > > Morning,
> > > >
> > > > is there a fix for this? It seems to involve Makefile tweaking, at least.
> > >
> > > What .config file?
> >
> > It seems CONFIG_SERIAL_8250_CONSOLE is gone. I can not activate it
> > anywhere.
>
> You don't ahve CONFIG_SERIAL_8250 selected either.  But you do have
> CONFIG_SERIAL_CONSOLE enabled.  So the question is then, (a) why do you
> have that set (pmac serial console?) and (b) why don't you have
> CONFIG_SERIAL_8250 set?

I had serial console set. Maybe I screwed my config while hunting for a
workaround.
[*] Support for PowerMac serial ports
[*]   Support for console on serial port

Well, I bet such a zImage links in 2.4.
I just enabled the PC part and now I have CONFIG_SERIAL_8250.
grepping for CONFIG_FOO doesnt work anymore, you must grep for FOO now.
fun...



Gruss Olaf

--
USB is for mice, FireWire is for men!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
