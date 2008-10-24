Return-Path: <weo@reccoware.de>
Received: from bes.recconet.de (bes.recconet.de [87.106.167.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C60CBDDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 08:41:32 +1100 (EST)
Subject: Re: [PATCH] Added gpios property for SPI slaves
From: Wolfgang Ocker <weo@reccoware.de>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081024211056.GA7309@oksana.dev.rtsoft.ru>
References: <1224878939.4039.22.camel@galileo.recco.de>
	<20081024211056.GA7309@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Fri, 24 Oct 2008 23:41:27 +0200
Message-Id: <1224884487.4039.31.camel@galileo.recco.de>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-10-25 at 01:10 +0400, Anton Vorontsov wrote: 
> On Fri, Oct 24, 2008 at 10:08:59PM +0200, Wolfgang Ocker wrote:
> > SPI slave devices require the specification of a chip select address.
> > This patch allows that specification using the gpios property. The reg
> > property remains supported.
> 
> Close, but no cigar. Sorry. ;-) The bindings are fine as is, you don't
> need to change them.

Oh, what a steep learning curve! Anyway, thank you for your guidance and
patience!

Looks like I have to adjust the SPI driver.

Wolfgang
