Subject: Re: Trivial cleanup in ocp_uart.c
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Scott Anderson <scott_anderson@mvista.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <3D1B3C0D.9B36EB42@mvista.com>
References: <20020620073440.GC20689@zax>
	<20020620155026.GE16052@opus.bloom.county> <20020621005216.GH20689@zax>
	<20020621143903.GO16052@opus.bloom.county> <20020624074019.GA9087@zax>
	<3D19F965.86668872@mvista.com> <20020627004144.GR9087@zax>
	<3D1B3C0D.9B36EB42@mvista.com>
Content-Type: text/plain
Date: 27 Jun 2002 18:52:37 +0200
Message-Id: <1025196757.27926.98.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2002-06-27 at 18:23, Scott Anderson wrote:
>
> David Gibson wrote:
> > Eek, wibble.  It still seems somewhat unlikely to me that you'd be
> > changing the peripherals "on the fly" in a real life embedded
> > application.  Especially considering that reboots are likely to be
> > much less of an issue on an embedded system than on a big server.

> I guess I wouldn't be quite so quick to dismiss this as unlikely, but
> I must admit, my crystal ball is in the shop this week.  It sure would
> be nice to keep such things in mind as OCP is evolving, though.

As someone who actually work with FPGA chips I can assure everyone that
those are always to small even when you pick one that seems insanely
large when you start. I have many times been in a situation when is
could work quite well to have mutually exclusive subsystem but what has
stopped that before is that the chips/software usually do not support
partial reconfiguration and you usually can't reconfigure the whole part
without disturbing normal functions.

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
