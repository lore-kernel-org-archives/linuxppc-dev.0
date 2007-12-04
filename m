Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C3656DDF7C
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 10:47:21 +1100 (EST)
Message-ID: <4755E701.3040908@freescale.com>
Date: Tue, 04 Dec 2007 17:47:13 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ucc_uart: add support for Freescale QUICCEngine UART
References: <11967907173600-git-send-email-timur@freescale.com>
	<200712042313.58252.arnd@arndb.de> <4755D73D.7040204@freescale.com>
	<200712050026.07616.arnd@arndb.de>
In-Reply-To: <200712050026.07616.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

> You can argue that the QS is really a DMA device, but in that case you
> should convert the driver to use the DMA mapping interfaces correctly,
> which I would consider overkill.

I'm confused.  I'm already calling dma_alloc_coherent() and getting a dma_addr_t 
back.  Why do I need to use mapping functions to convert between virtual and 
physical/bus addresses?

-- 
Timur Tabi
Linux kernel developer at Freescale
