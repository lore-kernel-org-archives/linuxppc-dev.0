To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: I2C RTC with MPC8xx? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 29 Jan 2003 13:37:41 +0100."
             <3E37CB15.50307@imc-berlin.de>
Date: Wed, 29 Jan 2003 13:49:33 +0100
Message-Id: <20030129124938.4338CC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E37CB15.50307@imc-berlin.de> you wrote:
>
> what do I have to do to use an I2C RTC (like Dallas DS1337) within LinuxPPC?

Use drivers/i2c/i2c-algo-8xx.c and add your own version of
drivers/i2c/i2c-ds1337.c ?

> I know there're drivers for PPCBoot / U-Boot.

There are also drivers for Linux.

> But how could I access them from Linux?

You cannot access or use any U-Boot code from LInux.


Viele Grüße,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The only thing necessary for the triumph of evil is for good  men  to
do nothing.                                            - Edmund Burke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
