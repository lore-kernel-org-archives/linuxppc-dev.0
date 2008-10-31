Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with SMTP id 5B0AADDF43
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Nov 2008 02:16:55 +1100 (EST)
From: "Stepanov, Sergej" <Sergej.Stepanov@ids.de>
To: "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>
Date: Fri, 31 Oct 2008 16:16:51 +0100
Subject: AW: mmc_spi with GPIO_MODE_3
Message-ID: <4206182445660643B9AEB8D4E55BBD0A17724C80@HERMES2>
References: <4206182445660643B9AEB8D4E55BBD0A17724C7E@HERMES2>,
	<20081031134542.GA4875@oksana.dev.rtsoft.ru>
In-Reply-To: <20081031134542.GA4875@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for answer

somewhere i have seen:
"For a while it seemed like MMC cards worked OK but not SD cards!"

Hm...
I have a SD card: Transcend, 512Mb... may it be the problem?..

Sergej.
________________________________________
Von: Anton Vorontsov [avorontsov@ru.mvista.com]
Gesendet: Freitag, 31. Oktober 2008 14:45
An: Stepanov, Sergej
Cc: linuxppc-dev@ozlabs.org
Betreff: Re: mmc_spi with GPIO_MODE_3

On Fri, Oct 31, 2008 at 01:49:31PM +0100, Stepanov, Sergej wrote:
> Hello Anton,
>
> could you say me please, would the mmc_spi-driver function with GPIO_MODE=
_3?

You mean SPI_MODE_3? Well, it should work, or even better it shouldn't
matter if it is 3 or 0. See Pierre's answer:
http://www.mail-archive.com/spi-devel-general@lists.sourceforge.net/msg0016=
0.html

But in reality MODE_0 works better.

http://www.mail-archive.com/spi-devel-general@lists.sourceforge.net/msg0015=
5.html
http://www.mail-archive.com/spi-devel-general@lists.sourceforge.net/msg0023=
1.html

IIRC nobody knows why exactly this happens, or better, nobody bothered
to investigate, since MODE_0 works OK. ;-)

> I have seen in mmc_spi_probe() this spi->mode =3D SPI_MODE_0.
> What should come back if i have CI and CP other then in SPI_MODE_0?

Something like this I suppose:

http://www.mail-archive.com/spi-devel-general@lists.sourceforge.net/msg0015=
3.html

--
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
