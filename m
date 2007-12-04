Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8DA12DDDDB
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 10:32:58 +1100 (EST)
Message-ID: <4755E3A6.80704@freescale.com>
Date: Tue, 04 Dec 2007 17:32:54 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ucc_uart: add support for Freescale QUICCEngine UART
References: <11967907173600-git-send-email-timur@freescale.com>	<200712042313.58252.arnd@arndb.de>
	<4755D73D.7040204@freescale.com> <200712050026.07616.arnd@arndb.de>
In-Reply-To: <200712050026.07616.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> From a code clarity perspective, the interesting point is that dma_addr_t is
> what comes back from the functions in dma-mapping.h. If you don't use them,
> a physical address is phys_addr_t.
> 
> You can argue that the QS is really a DMA device, but in that case you
> should convert the driver to use the DMA mapping interfaces correctly,
> which I would consider overkill.

Why is it overkill?

-Scott
