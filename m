Message-ID: <3C7E0298.5090502@pacbell.net>
Date: Thu, 28 Feb 2002 10:12:40 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: Gerard Basler <gbasler@ee.ethz.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bug in drivers/i2c/i2c-algo-ppc405.c ???
References: <Pine.GSO.4.43.0202281312050.17976-100000@tardis-a01.ee.ethz.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gerard Basler wrote:
> Dear list,
>
> Does anybody use the i2c driver for ppc405?
> These drivers are not part of the standard linux kernel, I found them at
> www.netroedge.com/~lm78 (lm_sensors project). (Why?)
> I think there's a bug in i2c-algo-ppc405.c
> The function iic_xfer (ppc405 implementation of i2c_transfer) returns
> always the number of bytes read / written
> of the last sub-transaction.
> I think it's supposed to return the number of successfully completed
> transfers instead.
> Just now I can't find something in the documentation on this topic but
> I'm sure I've read that somewhere...
> (Other drivers like i2c-alg-pcf.c are implemented in this manner)
>
> Perhaps I should better contact the authors... I don't know what the
> usual proceeding is concerning such things.
>
> Best Regards,
> Gérard
>

We have not pursued it enought to get the 405 i2c driver into
kernel.org.  I guess it is time...

I am in the process of updating it to the ocp format as are other 4xx
drivers. You can send me a patch.

--armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
