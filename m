Message-ID: <38F2771D.11CE9CE@denise.shiny.it>
Date: Mon, 10 Apr 2000 20:51:41 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: DeRobertis <derobert@erols.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: External clocking a serial port?
References: <l03130303b51671946984@[216.164.128.178]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


DeRobertis wrote:
>
> To run a Mac serial port at 1.8Mbps like the Epson Stylus Color 740's
> docs say it can, you need external clocking.
>
> I'm guessing the Stylus Color 740 is sending out the proper clock to do
> so -- and no doubt that would take out Linux using the crtscts option !

Hmm, It's possible...

> The clock input and remote side ready just happen to occupy the same
> pin. That would explain it flapping the ready so many times per second.
>
> How do I turn on external clocking under linux?

You have to hack the driver:

[macserial.h]

#define EXTSYNC         0x30    /* External Sync Mode */

and

/* Write Register 11 (Clock Mode control) */


Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
