To: Yonghao Wang <Y.Wang@ftel.co.uk>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel message missing characters! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 22 Mar 2002 14:01:34 GMT."
             <3C9B393E.4958C98E@ftel.co.uk>
Date: Fri, 22 Mar 2002 16:20:58 +0100
Message-Id: <20020322152103.044F8109F3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C9B393E.4958C98E@ftel.co.uk> you wrote:
>
> ppcboot as boot loader and kernel 2.4.7. The console is set up on serial
>
> SMC2. I've changed little bit code on arch/ppc/boot/mbx/m8260_tty.c to
> enable it supports SMC2. But when I boot kernel,  the console output

Seems you didn't do this right, then.

> seems missing characters like below:
...
> Ttlmmr  2M;uig0Bfrhs al a 0000
> Lnxvrin247 wn@ihmr.tlc.k gcvrin30 1FiMr1 53:7GT20
> oe0:378pgs:378
> oe2:0pgs.
> Kre omn ie ot/e/f wnsot121..4:epr/p-f-oti=7.61.1:7.6213121..1:5.5..:iuAM

Well known problem, every second character is missing.

> Does anybody can give me some clue how to fix it?

Make sure to enable SMC1 as serial port, too. If the  console  is  on
SMC2,  _both_ SMC1 and SMC2 must be enabled as a serial ports, or you
have to adjust the uart driver a bit.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Nobody trips over mountains. It is the small pebble that  causes  you
to  stumble.  Pass all the pebbles in your path and you will find you
have crossed the mountain.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
