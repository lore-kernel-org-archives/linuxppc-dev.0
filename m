To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: I2C RTC causes boot delay... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Apr 2003 14:20:40 +0200."
             <3E92BE98.4090907@imc-berlin.de>
Date: Tue, 08 Apr 2003 14:57:21 +0200
Message-Id: <20030408125726.80D52C5877@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E92BE98.4090907@imc-berlin.de> you wrote:
>
> Yeah. I know. I should put into PPCBoot/U-Boot.

It's arelady there.

> But in the docs it says it's only for SOFT_I2C aka bitbang!

Right, because you cannot toogle the pins at  your  liking  with  the
CPM's I2C controller.

> a) can I toggle the pins using GPIO and still use HARD_I2C? or

Yes, you can. But this has not been implemented yet. And if  you  do,
you  will  find you have copied 90% of the soft_i2c driver so why not
use this from the beginning? Using HARD_I2C has _zero_ advantage  for
U-Boot.

> b) can I use SOFT_I2C in PPCBoot and CPM I2C (8xx-algo) under linux?

Yes, you can.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
THIS IS A 100% MATTER  PRODUCT:  In  the  Unlikely  Event  That  This
Merchandise  Should  Contact  Antimatter  in Any Form, a Catastrophic
Explosion Will Result.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
