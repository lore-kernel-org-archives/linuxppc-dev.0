Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id BD829DDEEE
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 10:39:43 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ucc_uart: add support for Freescale QUICCEngine UART
Date: Wed, 5 Dec 2007 00:39:38 +0100
References: <11967907173600-git-send-email-timur@freescale.com>
	<200712050026.07616.arnd@arndb.de> <4755E3A6.80704@freescale.com>
In-Reply-To: <4755E3A6.80704@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200712050039.39153.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 December 2007, Scott Wood wrote:
> 
> > You can argue that the QS is really a DMA device, but in that case you
> > should convert the driver to use the DMA mapping interfaces correctly,
> > which I would consider overkill.
> 
> Why is it overkill?
> 

Well, if the QE can never be used with an IOMMU anyway, you don't
lose any functionality by considering it a physical address instead of
a DMA address.

The DMA mapping API is meant for the cases where physical and dma
addresses can be different in the first place.

	Arnd <><
