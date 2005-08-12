Return-Path: <solca@guug.org>
Received: from guug.org (guug.galileo.edu [168.234.203.30])
	by ozlabs.org (Postfix) with ESMTP id 190BF67F9C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 13:48:38 +1000 (EST)
Received: from solca by guug.org with local (Exim 3.36 #1 (Debian))
	id 1E3QDT-0001II-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 11 Aug 2005 21:28:19 -0600
Date: Thu, 11 Aug 2005 21:28:19 -0600
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050812032819.GA4763@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Otto Solares <solca@guug.org>
Subject: Redwood-6 and 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

Redwood-6 support in 2.6 is broken.  I subscribed to this
list just to know if somebody is working on it?  2.4.30
works ok.

If nobody is working on it please just tell me what is wrong
and I would try to figure out:

---
CC      arch/ppc/syslib/ppc4xx_dma.o
arch/ppc/syslib/ppc4xx_dma.c: In function `ppc4xx_enable_burst': arch/ppc/syslib/ppc4xx_dma.c:638: error: `DMA_CTC_BTEN' undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_dma.c:638: error: (Each undeclared identifier is reported only once arch/ppc/syslib/ppc4xx_dma.c:638: error: for each function it appears in.)
arch/ppc/syslib/ppc4xx_dma.c: In function `ppc4xx_disable_burst': arch/ppc/syslib/ppc4xx_dma.c:657: error: `DMA_CTC_BTEN' undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_dma.c: In function `ppc4xx_set_burst_size': arch/ppc/syslib/ppc4xx_dma.c:682: error: `DMA_CTC_BSIZ_MSK' undeclared (first use in this function)
make[1]: *** [arch/ppc/syslib/ppc4xx_dma.o] Error 1
make: *** [arch/ppc/syslib] Error 2
---

In 2.4 'DMA_CTC_BTEN' does not exists.

Thanks.

-otto
