Message-ID: <3CD7ED38.448C21D1@etx.ericsson.se>
Date: Tue, 07 May 2002 17:05:28 +0200
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IBM ocp I2C circular dependency
References: <NCBBIINEHIPFGJPLBEIFMEJMDGAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Would that kind of problem not hang the process?? I don't see that.

Allen Curtis wrote:
>
> I can not speak toward the modularization issue but if the i2c is anything
> like the old 8260 version, change the interruptible_sleep_on() to
> interruptible_sleep_on_timeout(). IMHO this is the easiest fix.
>
> -----Original Message-----
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Kenneth
> Johansson
> Also I found a problem with the code when I access a i2c memory from
> userspace and no chip is present at that address. After that it's not
> possible to access anything else on the I2C bus. Works OK as long as I use
> addresses that have a device that answers (I think).
>

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
