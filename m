Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B0A72DDDF0
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Nov 2008 00:45:45 +1100 (EST)
Date: Fri, 31 Oct 2008 16:45:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: "Stepanov, Sergej" <Sergej.Stepanov@ids.de>
Subject: Re: mmc_spi with GPIO_MODE_3
Message-ID: <20081031134542.GA4875@oksana.dev.rtsoft.ru>
References: <4206182445660643B9AEB8D4E55BBD0A17724C7E@HERMES2>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <4206182445660643B9AEB8D4E55BBD0A17724C7E@HERMES2>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 31, 2008 at 01:49:31PM +0100, Stepanov, Sergej wrote:
> Hello Anton,
> 
> could you say me please, would the mmc_spi-driver function with GPIO_MODE_3?

You mean SPI_MODE_3? Well, it should work, or even better it shouldn't
matter if it is 3 or 0. See Pierre's answer:
http://www.mail-archive.com/spi-devel-general@lists.sourceforge.net/msg00160.html

But in reality MODE_0 works better.

http://www.mail-archive.com/spi-devel-general@lists.sourceforge.net/msg00155.html
http://www.mail-archive.com/spi-devel-general@lists.sourceforge.net/msg00231.html

IIRC nobody knows why exactly this happens, or better, nobody bothered
to investigate, since MODE_0 works OK. ;-)

> I have seen in mmc_spi_probe() this spi->mode = SPI_MODE_0.
> What should come back if i have CI and CP other then in SPI_MODE_0?

Something like this I suppose:

http://www.mail-archive.com/spi-devel-general@lists.sourceforge.net/msg00153.html

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
