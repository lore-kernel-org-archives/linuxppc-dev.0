Return-Path: <vwool@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A577667CF6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 08:17:02 +1100 (EST)
Subject: Re: [PATCH] adding ROM chips to device tree: respin
From: Vitaly Wool <vwool@ru.mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <4550A5E6.50409@ru.mvista.com>
References: <20061107141923.16b2d2f1.vwool@ru.mvista.com>
	<4550A5E6.50409@ru.mvista.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 00:17:01 +0300
Message-Id: <1162934221.2680.2.camel@barja>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > +     - memory_space : Offset and length of the register set for the device.
> 
>     NAK. There's no need to define an extra property where "reg" should be used.

The register set is actually not there and depends on flash chip type.
So using regs here is misleading.

> > +
> > +	/*
> > +	 * We care only about physmap devices now as there's no
> > +	 * description defined for other ROM types yet
> > +	 */
> 
>     Not true. The description only says that it's *most probably* compatible 
> with "physmap", that's all. I don't see why we have to limit ourselves here.

Effectively we care about NOR chips and similar which are
memory-mapped. 

Vitaly
