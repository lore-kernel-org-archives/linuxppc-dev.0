Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A24A02BDA5
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2004 13:05:29 +1000 (EST)
In-Reply-To: <1098322108.9230.13.camel@nighteyes.localdomain>
References: <1098322108.9230.13.camel@nighteyes.localdomain>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <64CAFF3C-230E-11D9-AAA4-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 20 Oct 2004 23:07:51 -0400
To: Jeff Angielski <jangiels@speakeasy.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: SCC UART configuration - GSMR_H[RFW]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 20, 2004, at 9:28 PM, Jeff Angielski wrote:


> Was this done on purpose?

Kinda.  It was something I played with long ago when I
wrote the drivers.  I just never got back to testing the alternative
because I couldn't find a test method that would prove
one or the other was the better choice.

>   Is the documentation wrong?

I don't remember the details of the microcode anymore.  The
intention was to maximize the fifo depth and use the buffer
management controls to push the fifo to the BDs using
the max idle counter.  Maybe the SCC initialization just
thought I was stupid and set it internally anyway.

> FWIW, I noticed that u-boot sets this bit when it initializes the SCC
> for UART mode...

So, it seems either way works.  Maybe one of the Freescale
guys lurking here that was involved in the microcode development
can explain why.


	-- Dan
