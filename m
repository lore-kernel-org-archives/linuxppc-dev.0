Message-ID: <39A6B196.CDF1228@mvista.com>
Date: Fri, 25 Aug 2000 10:49:10 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Dan Winkler <dantwinkler@yahoo.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPX Lite programming
References: <20000825025003.23151.qmail@web512.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Winkler wrote:
>
> Newbie alert!!!  I've just started developing on the
> RPX lite board from embedded-planet.  I am currently
> trying to write some i2c code that just reads the
> temperature registers from the temperature sensor and
> thermal monitor (TCN75).  I was wondering where
> someone like myself could find some example code to
> get me started.  I found the i2c driver from the

there is already a i2c driver for the 8xx in the kernel.  It only has
read capabilities, but it works fine (at least for reading the eeprom).
There are several drivers for the 8xx in the kernel that you can use for
examples.  Also EP wrote a different i2c driver with write.  the EP i2c
driver has not made it to our ftp site yet, so ask EP tech support for
it.

Matthew Locke
Montavista Software
http://www.mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
