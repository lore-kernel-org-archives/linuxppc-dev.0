Date: Fri, 28 Jun 2002 10:59:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Anderson <scott_anderson@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Trivial cleanup in ocp_uart.c
Message-ID: <20020628005908.GC11095@zax>
References: <20020620073440.GC20689@zax> <20020620155026.GE16052@opus.bloom.county> <20020621005216.GH20689@zax> <20020621143903.GO16052@opus.bloom.county> <20020624074019.GA9087@zax> <3D19F965.86668872@mvista.com> <20020627004144.GR9087@zax> <3D1B3C0D.9B36EB42@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D1B3C0D.9B36EB42@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 27, 2002 at 09:23:41AM -0700, Scott Anderson wrote:
>
> David Gibson wrote:
> > Eek, wibble.  It still seems somewhat unlikely to me that you'd be
> > changing the peripherals "on the fly" in a real life embedded
> > application.  Especially considering that reboots are likely to be
> > much less of an issue on an embedded system than on a big server.
>
> My contrived example is a piece of test equipment that has an LCD
> touchscreen and some high speed serial collection device.  The LCD is
> only used when interacting with the UI and the serial is only used
> during a run when the LCD can be blank.  By reprogramming part of the
> FPGA on the fly you can squeeze more into a smaller FPGA.  It appears
> that Xilinx already has this working:
>   http://www.xilinx.com/xapp/xapp290.pdf
>
> I guess I wouldn't be quite so quick to dismiss this as unlikely, but
> I must admit, my crystal ball is in the shop this week.  It sure would
> be nice to keep such things in mind as OCP is evolving, though.

Heh, well, maybe.  In any case this sounds more like a 2.5 and later
timerframe thing to me, in which case integration into the unified
device model should give us what's needed.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
