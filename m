From: Benjamin Herrenschmidt <bh40@calva.net>
To: Topi Kanerva <tkanerva@ees2.oulu.fi>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Backlight control on Lombard PB
Date: Thu, 10 Aug 2000 10:19:54 +0200
Message-Id: <20000810081954.22687@mailhost.mipsys.com>
In-Reply-To: <Pine.GSO.4.21.0008100940040.28327-100000@stekt6>
References: <Pine.GSO.4.21.0008100940040.28327-100000@stekt6>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Well, the backlight control surely doesn't work on Pismos... I just hate
>it when I have to boot over to MacOS to switch up the backlight level
>(I usually keep it low because it eats so much battery...)
>Now, I realize that the PMU on Pismos is somewhat different, but supposedly
>there is a way (in MacOS) to try to poke what kind of values are being
>written to the registers when you change the backlight in MacOS (fn-F1/F2)
>
>actually, to be able to turn off the backlight is perharps the most
>important single power-saving feature. unfortunately, I myself don't have
>any reverse-engineering experience on MacOS (this is my first mac ever...)

Backlight control should work on Pismo with my latest kernels. It's not
driven by te PMU on those machines, it's directly controlled by the ATI
chip. I finally found some time to push the Lombard fix yesterday.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
