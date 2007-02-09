Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id E88A1DDEC5
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 10:33:14 +1100 (EST)
Message-ID: <45CD04B5.1020304@freescale.com>
Date: Fri, 09 Feb 2007 17:33:09 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Discussion about iopa()
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
	<1170969965.2620.345.camel@localhost.localdomain>
	<0640B069-F05E-4A08-A8EB-C277BEF1466E@embeddedalley.com>
	<1171058780.6578.4.camel@localhost.localdomain>
	<1EFFAE36-7396-45B5-B8F2-DD7348FBE385@kernel.crashing.org>
	<45CCFAD6.5070807@freescale.com>
	<7B89E9E3-620C-4DF5-96E7-AF05287D89DC@kernel.crashing.org>
	<45CCFF4B.7000102@freescale.com>
	<969E3C07-96EE-4AF9-BF57-B10F049684EE@kernel.crashing.org>
In-Reply-To: <969E3C07-96EE-4AF9-BF57-B10F049684EE@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> We should fix it so the driver just has to do dma_alloc_coherent, 
> dma_free_coherent, and dma_map_*/dma_unmap_*

Ok, I'm getting confused now.  The driver currently uses ioremap().  You're 
saying that it should use the dma_xxx functions instead, but not until those 
functions support MURAM?  When that happens, won't that make ioremap() obsolete?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
