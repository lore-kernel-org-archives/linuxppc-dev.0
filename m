To: miguel.valero@axxessit.no
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: DS1340 RTC (i2c device) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Jul 2004 08:44:12 +0200."
             <OFBE3E7E82.C477AD44-ONC1256ED6.0024E631@axxessit.no>
Date: Mon, 19 Jul 2004 10:37:47 +0200
Message-Id: <20040719083752.58CA5C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <OFBE3E7E82.C477AD44-ONC1256ED6.0024E631@axxessit.no> you wrote:
>
> Does anyone have any good suggestions about how to handle an i2c RTC
> device, as f.e. the Maxim ds1340 ?

Sorry, can't help here.

> The question is whether the i2c driver is already in place by the time
> these functions are called, so that I can register a driver for the
> ds1340. Has anyone done something like that ?

I2C based RTCs have been in use for a long time.  Just  register  the
RTC functions when the I2C driver comes up.

And make sure to disable the 11 minute  mode  or  you  may  run  into
problems  (you'll  know what I mean when your system crashes after 11
minutes). See the list archive for details.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A verbal contract isn't worth the paper it's written on.
                                                    -- Samuel Goldwyn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
