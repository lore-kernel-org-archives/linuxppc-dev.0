Return-Path: <kernel@andred.net>
Received: from andred.net (sushi.andred.net [217.160.180.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF648679F8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 05:48:52 +1000 (EST)
Message-ID: <443AB696.7080205@andred.net>
Date: Mon, 10 Apr 2006 21:48:38 +0200
From: Andre Draszik <kernel@andred.net>
MIME-Version: 1.0
To: Andre Draszik <kernel@andred.net>, linuxppc-embedded@ozlabs.org
Subject: Re: Slab errors on 4xx (STB04)
References: <44398BD4.60904@andred.net>
	<20060410071457.GA16898@gate.ebshome.net>
In-Reply-To: <20060410071457.GA16898@gate.ebshome.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene Surovegin wrote:
> On Mon, Apr 10, 2006 at 12:33:56AM +0200, Andre Draszik wrote:
>> Since it _seems_ to work nevertheless - is CONFIG_DEBUG_SLAB known to be
>> broken on this platform?
> 
> Yes, it's very likely that CONFIG_DEBUG_SLAB is the culprit here. This 
> [...]

Thanks Roland and Eugene for the advice.

> You can try changing __dma_sync() to do flush_dcache_range() even for 
> DMA_FROM_DEVICE case. However, do this only to check this theory, not 
> as a permanent solution :).

OK, I will play with the cache later today... I wanted DEBUG_SLAB turned
on for some other unrelated problem, so just for debugging, this hack
would be fine if it worked :)


Greetings,
Andre'
