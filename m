Return-Path: <liml@rtr.ca>
Received: from mail.rtr.ca (ottawa-hs-64-26-128-89.s-ip.magma.ca
	[64.26.128.89]) by ozlabs.org (Postfix) with ESMTP id C7429DDF23
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 23:40:52 +1000 (EST)
Message-ID: <461E36E5.1000909@rtr.ca>
Date: Thu, 12 Apr 2007 09:40:53 -0400
From: Mark Lord <liml@rtr.ca>
MIME-Version: 1.0
To: Michael <michaelzwrk@gmail.com>
Subject: Re: IDE driver in polling mode
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>	
	<461B9D04.2000109@ru.mvista.com>	
	<20070410171125.3aeed29d@the-village.bc.nu>	
	<461BB8C7.9050900@garzik.org>	
	<20070410172942.7f63d49c@the-village.bc.nu>	
	<1ea6be8e0704110139i140b40b3qb8408fec2e4ff2a7@mail.gmail.com>	
	<20070411094702.74774d25@the-village.bc.nu>
	<1ea6be8e0704110810l205f5dc7gb831603455a883e2@mail.gmail.com>
	<461E3677.6030104@rtr.ca>
In-Reply-To: <461E3677.6030104@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mark Lord wrote:
> Michael,
> 
> Here is a patch to have drivers/ide use polling
> for all operations, in addition to IRQs.

s/in addition to/instead of/

If you need IRQs + polling, then just un-ifdef
the request_irq() and free_irq() lines.

Cheers
