Message-Id: <200006072026.WAA09445@denx.local.net>
To: Dan Malek <dan@netx4.com>
cc: Grant Carter <gcarter@eng.uct.ac.za>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SMC2 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 07 Jun 2000 13:05:27 EDT."
             <393E80D7.9918BBE1@embeddededge.com>
Date: Wed, 07 Jun 2000 22:26:25 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <393E80D7.9918BBE1@embeddededge.com> you wrote:
>
> Oh oh......are you using an 823 or 850?  Sorry about this, you will
> have to change the code.  Someday, I have to finish up a better UART
> driver.  You are the first person I know that is trying to use this
> as a UART.  SMC2 is the first thing to disappear when using the parts

I'm doing that, too.

In fact, it's the default configuration for the TQM8xxL modules (all of them).

The reason for that is that TQ uses the serial connector not only for
SMC1, but also for RESET (on the RTS pin) and autoboot enable (on the
DTR pin). While this is handy when you know  about  it  and  use  the
right cable, it has confused enough of my customers to avoid using it
as a default :-(

> for other data communication protocols or interfaces, so custom
> software tends to assign these for other purposes.  I seldom see anything
> but SMC1 used for a UART, so making the driver better hasn't been
> high on the list......

Well, Dan, There are more things in heaven and earth, ..., Than are
dreamt of in your philosophy. ... :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Delta: We never make the same mistake three times.  - David Letterman

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
