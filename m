Message-ID: <3A22BFAE.997F20C6@mvista.com>
Date: Mon, 27 Nov 2000 15:10:22 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Kyle Harris <kharris@nexus-tech.net>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: fb on mpc823
References: <3A22BB86.92419741@nexus-tech.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kyle Harris wrote:

> ... I'm a little confused (not unusual :). Which device should
> /dev/fb0 be? fbmem.c opens a device using major 29. But lcd823.c....

The confusion is probably not your fault this time :-).  Don't use
the old lcd driver that has my name in it.  That was just something
I hacked together one day for testing.  I posted it so someone that
knew something about frame buffers would really write one.

Fortunately, someone did.  I believe it was Joe Green from MontaVista
that did a real framebuffer driver.  Go to the MontaVista web site
and find the CDK 1.2 with the 2.2.14 kernel.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
