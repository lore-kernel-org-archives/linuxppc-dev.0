Message-ID: <3D1B3C0D.9B36EB42@mvista.com>
Date: Thu, 27 Jun 2002 09:23:41 -0700
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Trivial cleanup in ocp_uart.c
References: <20020620073440.GC20689@zax> <20020620155026.GE16052@opus.bloom.county> <20020621005216.GH20689@zax> <20020621143903.GO16052@opus.bloom.county> <20020624074019.GA9087@zax> <3D19F965.86668872@mvista.com> <20020627004144.GR9087@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
> Eek, wibble.  It still seems somewhat unlikely to me that you'd be
> changing the peripherals "on the fly" in a real life embedded
> application.  Especially considering that reboots are likely to be
> much less of an issue on an embedded system than on a big server.

My contrived example is a piece of test equipment that has an LCD
touchscreen and some high speed serial collection device.  The LCD is
only used when interacting with the UI and the serial is only used
during a run when the LCD can be blank.  By reprogramming part of the
FPGA on the fly you can squeeze more into a smaller FPGA.  It appears
that Xilinx already has this working:
  http://www.xilinx.com/xapp/xapp290.pdf

I guess I wouldn't be quite so quick to dismiss this as unlikely, but
I must admit, my crystal ball is in the shop this week.  It sure would
be nice to keep such things in mind as OCP is evolving, though.

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
