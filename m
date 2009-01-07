Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94212DDFCA
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 11:57:30 +1100 (EST)
Subject: Re: [PATCH v1] Add support for getting device platform data to I2C
	device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081218174927.GA16574@oksana.dev.rtsoft.ru>
References: <1229566451-29411-1-git-send-email-Mingkai.hu@freescale.com>
	<20081218165946.GA4029@oksana.dev.rtsoft.ru>
	<494A8643.1030105@freescale.com>
	<20081218174927.GA16574@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 11:55:21 +1100
Message-Id: <1231289721.14860.47.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-12-18 at 20:49 +0300, Anton Vorontsov wrote:

> Exactly, this matters for non-embedded case. Why would I want totally
> unneeded I2C bindings built-in into my iBook kernel? ;-)
> 
> >> And the solution that everybody seem to agree with (SPI driver example):
> >> http://lkml.org/lkml/2008/10/30/393
> >
> > Hmm, that doesn't seem to allow for any binding mechanism other than  
> > internal and OF
> 
> Yeah, not without hacks (though, we can do some sort of chained pdata
> handlers, thus we can allow other bindings mechanisms). But so far we
> don't have anything other than OF and "board files"/raw bindings (I can't
> actually imagine any other option).
> 
> Both approaches have their cons, sure. The difference is: for the
> $subject approach we'll see the cons immediately, while in my approach
> the cons are theoretical.

So what's the situation with this patch ? In general, who should be
considered as "in charge" of the OF i2c stuff btw ?

Cheers,
Ben.
