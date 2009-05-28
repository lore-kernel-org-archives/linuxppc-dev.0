Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 77C00DDFA0
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 14:11:55 +1000 (EST)
Date: Thu, 28 May 2009 00:11:52 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
Message-ID: <20090528001152.6c00b238@lappy.seanm.ca>
In-Reply-To: <1243482749.3171.80.camel@pasglop>
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
	<1243160487.22770.59.camel@pasglop>
	<1243210914.24376.11.camel@pasglop>
	<200905250243.15436.arnd@arndb.de>
	<1243226023.24376.23.camel@pasglop>
	<20090527233451.2d02343d@lappy.seanm.ca>
	<1243482749.3171.80.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 28 May 2009 13:52:29 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Can't you set ISA_DMA_THRESHOLD = ~0L from your warp.c platform file ?

I actually set it in the driver proper since it is faster to test, but
it works. I am just wondering how kosher that is.

The advantage of the platform_device is I can go back to using the top
level function. And I suspect down the road the __dma* functions may
require a real device.

However, the ISA_DMA_THRESHOLD = ~0L is a less intrusive patch.

Cheers,
   Sean
