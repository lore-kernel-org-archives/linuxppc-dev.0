To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: I2C RTC with MPC8xx? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 29 Jan 2003 14:05:17 +0100."
             <3E37D18D.7080900@imc-berlin.de>
Date: Thu, 30 Jan 2003 09:38:10 +0100
Message-Id: <20030130083815.4E4AEC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E37D18D.7080900@imc-berlin.de> you wrote:
>
> > Use drivers/i2c/i2c-algo-8xx.c and add your own version of
> > drivers/i2c/i2c-ds1337.c ?
> Hmm. But there must be at least one excample!?

Of course there are examples. Just look in drivers/i2c/

> How else should all the people using PPCBoot/U-Boot and I2C RTCs on MPC8xx
> platforms access them from Linux...
>
> But where could I find one? Isn't LWMON using an I2C RTC? But I just can't find
> the driver...

LWMON uses a Philips PCF8563 RTC, but the LWMON board uses a  special
(lean,  non-standard)  I2C  driver  (drivers/i2c/i2c-simple.c) so the
driver as used on LWMON ("drivers/char/pcf8563_rtc.c") will not  help
you  much.  But there is also a standard drivers fopr other RTC chips
in our source tree.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Let's say the docs present a simplified view of reality...    :-)
                      - Larry Wall in  <6940@jpl-devvax.JPL.NASA.GOV>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
