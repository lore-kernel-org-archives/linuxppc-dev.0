Date: Fri, 28 Jun 2002 07:57:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Scott Anderson <scott_anderson@mvista.com>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Trivial cleanup in ocp_uart.c
Message-ID: <20020628145710.GJ26734@opus.bloom.county>
References: <20020620073440.GC20689@zax> <20020620155026.GE16052@opus.bloom.county> <20020621005216.GH20689@zax> <20020621143903.GO16052@opus.bloom.county> <20020624074019.GA9087@zax> <3D19F965.86668872@mvista.com> <20020627004144.GR9087@zax> <3D1B3C0D.9B36EB42@mvista.com> <20020628005908.GC11095@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020628005908.GC11095@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 28, 2002 at 10:59:08AM +1000, David Gibson wrote:
> On Thu, Jun 27, 2002 at 09:23:41AM -0700, Scott Anderson wrote:
> >
> > David Gibson wrote:
> > > Eek, wibble.  It still seems somewhat unlikely to me that you'd be
> > > changing the peripherals "on the fly" in a real life embedded
> > > application.  Especially considering that reboots are likely to be
> > > much less of an issue on an embedded system than on a big server.
> >
> > My contrived example is a piece of test equipment that has an LCD
> > touchscreen and some high speed serial collection device.  The LCD is
> > only used when interacting with the UI and the serial is only used
> > during a run when the LCD can be blank.  By reprogramming part of the
> > FPGA on the fly you can squeeze more into a smaller FPGA.  It appears
> > that Xilinx already has this working:
> >   http://www.xilinx.com/xapp/xapp290.pdf
> >
> > I guess I wouldn't be quite so quick to dismiss this as unlikely, but
> > I must admit, my crystal ball is in the shop this week.  It sure would
> > be nice to keep such things in mind as OCP is evolving, though.
>
> Heh, well, maybe.  In any case this sounds more like a 2.5 and later
> timerframe thing to me, in which case integration into the unified
> device model should give us what's needed.

I think alot of what we're talking about for OCP is 2.5 fodder really.
Keep in mind that the current stuff has been well tested on ~13
different 4xx boards.  Perhaps we should allow OCP to become semi solid
in 2_4_devel now so that we can move 4xx out to Marcelo and allow armin
to do some drastic changes in 2.5...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
