To: Dan Malek <dan@embeddededge.com>
Cc: "barry.fisher" <barry.fisher@seranoa.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Need SPI support 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 11 Mar 2002 13:56:13 EST."
             <3C8CFDCD.6080600@embeddededge.com>
Date: Mon, 11 Mar 2002 22:03:14 +0100
Message-Id: <20020311210319.B28C310BF2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C8CFDCD.6080600@embeddededge.com> you wrote:
>
> > Does anyone know where I might get some code to support Motorola 8260
> > Serial Peripheral Interface (SPI) for Linux.
...
> The controller set up is trivial, just copy the guts of managing BDs
> from something else, like I2C.  The SPI implementations typically have
> board specific methods for device selection and devices that may be
> sensitive to whether the clock keeps running.  A generic driver is

... and devices that need frame sync signals, etc.

SPI looks fine as long as you just look at the specification, but you
soon discover the ugly side when you have to use it.

> challenging due to these board variations, but a skeleton driver
> would be useful.
>
> Wolfgang, do you have something that isn't checked into BK sources :-)?

Nothing for the 8260.

In PPCBoot there is a polled  mode  driver  (cpu/mpc8xx/spi.c)  which
could easily be adapted.

The Linux stuff we have on 8xx is (1) not really ready  yet  and  (2)
extremely  special  (building  a multiprocessor system from a 823 and
two DSP's).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There are two ways to write error-free programs. Only the  third  one
works.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
