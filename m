Date: Tue, 12 Sep 2000 09:57:51 +0300
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Sandpoint & random crashes?
Message-ID: <20000912095751.A20541@hectic.net>
References: <39BD66B9.9A1A362F@mvista.com> <000301c01c4b$6a7ac6d0$4d012ac7@warp-speed>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000301c01c4b$6a7ac6d0$4d012ac7@warp-speed>; from ronb@junction.net on Mon, Sep 11, 2000 at 04:53:00PM -0700
From: Alex Shnitman <alexsh@hectic.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Ron!

On Mon, Sep 11, 2000 at 04:53:00PM -0700, you wrote the following:

> Another possible hardware related problem might be that the Dink
> monitor is not programming the SDRAM controller with the right
> parameters for that DIMM module ( I assume the sandpoint uses DIMMs
> ).  I'm not sure if the monitor reads the param data from the
> module's eeprom or is manually configured and stored in CMOS ram.

It's a SIMM module. Does that make any difference?
(You can see it at:
http://www.mot.com/SPS/PowerPC/teksupport/refdesigns/sandpoint.html#7400 )

> Anyway, have you run any memory tests?

No, how do I do that? What memory test applications are there for this
platform?


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

/real/ kernel hackers
    dd if=/dev/urandom of=/vmlinuz
and influence the Universal Randomosity Field.
	-- Gaal Yahas

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
