Message-ID: <20030619140528.19785.qmail@web41805.mail.yahoo.com>
Date: Thu, 19 Jun 2003 07:05:28 -0700 (PDT)
From: Cedric Aubert <cedric_aubert@yahoo.fr>
Reply-To: cedric_aubert@yahoo.fr
Subject: RE: RTC for MPC8xx with Linux ?
To: David Jander <david.jander@protonic.nl>,
	linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Personnaly I use a DS1306 on SPI to do RTC on a
MPC860.
I don't use it under linux still now. But succesfully
run it under RTOS.

It's port under U-Boot so it's should not be difficult
to
use it under linux. If someone have some more
information
about DS1306 under linux (or throught U-Boot may be).

If you want to look at the DS1306 U-Boot driver, look
at
		boot/u-boot/rtc/ds1306.c

Expects that help

Cedric

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
>
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On
Behalf Of David
> Jander
> Sent: Thursday, June 19, 2003 3:37 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: RTC for MPC8xx with Linux ?
>
>
>
> Hi everybody,
>
> Thanks for all the answers I got over experience
with the MPC852T.
> One other thing I was investigating is the RTC.
> What RTC solutionts are known for easy interfacing
with MPC8xx processors,
> that work under linux ? What's the standard ?
> There are a number of PC-compatible RTC chips out
there, but I
> don't seem to
> like them much, because they're generally quite
expensive, have a lot of
> functionality which might be nice, but is not really
needed in my case.
> Any experience with smaller 1-bit (or SPI) RTC's
under linux ? I'm looking
> basically for a Battery-backuped time-keeping
counter.
>
> Greetings,
>
> --
> David Jander
> Protonic Holland.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
