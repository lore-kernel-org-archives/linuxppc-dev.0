To: "barry.fisher" <barry.fisher@seranoa.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Device Driver for lm75 on 8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 04 Feb 2002 10:17:47 EST."
             <000901c1ad8f$1a7fdb80$7d0110ac@Seranoa.com>
Date: Mon, 04 Feb 2002 17:51:45 +0100
Message-Id: <20020204165150.62486116B4@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000901c1ad8f$1a7fdb80$7d0110ac@Seranoa.com> you wrote:
>
>  Does anyone know where I can get some code(or sample code) for a Linux
>  device driver on an 8260 which gets temperature data from an lm75 via
>  i2c. Any help is appreciated! Thanks in advance.

We have generic I2C support for the 8260 (drivers/i2c/i2c-algo-8260.c)
in our version of the Linux kernel, and drivers for instance for  the
MicroSys PM826 ("Miriac") module, too (drivers/i2c/i2c-pm826.c).

See ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2002-01-19.tar.bz2

Reading the LM sensor is then just a minor excercise..

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"If a computer can't directly address all the RAM you can  use,  it's
just a toy."         - anonymous comp.sys.amiga posting, non-sequitir

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
