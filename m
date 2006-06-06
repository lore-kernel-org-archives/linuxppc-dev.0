Return-Path: <nsundar@fulcrummicro.com>
Received: from smtp.fulcrummicro.com (smtp.fulcrummicro.com [66.59.247.212])
	by ozlabs.org (Postfix) with ESMTP id 46E9A67B38
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Jun 2006 04:55:52 +1000 (EST)
Date: Tue, 6 Jun 2006 11:55:48 -0700
From: Naru Sundar <nsundar@fulcrummicro.com>
To: Liu Dave-r63238 <DaveLiu@freescale.com>
Subject: Re: ppc85xx DMA
Message-ID: <20060606185548.GB27078@fulcrummicro.com>
References: <9FCDBA58F226D911B202000BDBAD4673026FD940@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673026FD940@zch01exm40.ap.freescale.net>
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

On Tue, Jun 06, 2006 at 09:39:29AM +0800, Liu Dave-r63238 wrote:
> What is the DMA transfer mode? Is direct or chaining mode?

Direct mode.  I fixed an error with my bit ordering for the configuration
registers, and now the transfer seems to complete, but I don't see any
actual data showing up in the destination register that I am writing to.

> Did you ioremap the DMA register space?

Yes, I can write the destination address manually.  So I am thinking my addresses
are wrong.

For the source and dest address I used:

dma_map_single(NULL, ptr, len, DMA_TO_DEVICE)

(which effectively does a virt_to_bus on ppc and so should just return to me
the bus address used by the dma).

-naru
