Return-Path: <aris@mandriva.com>
Received: from oops.ghostprotocols.net (virtua-cwb215-93.ctb.virtua.com.br
	[200.250.215.93]) by ozlabs.org (Postfix) with ESMTP id 67BBC68789
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 00:15:17 +1100 (EST)
Date: Mon, 9 Jan 2006 10:53:39 -0200
From: Aristeu Sergio Rozanski Filho <aris@mandriva.com>
To: Kalle Pokki <kalle.pokki@iki.fi>
Message-ID: <20060109125339.GA12997@oops.ghostprotocols.net>
References: <43C25787.4010204@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43C25787.4010204@iki.fi>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Badness in dma_alloc_init
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
> I'm having some trouble with the DMA allocation using Linux 2.6.14-rc2 + 
> some platform modifications. Namely, the dma_alloc_coherent() function 
> returns bogus virtual addresses causing machine check exceptions. At 
> boot, the kernel complains there is something wrong, but I cannot figure 
> out how to fix it. CONFIG_CONSISTENT_START is at its default value, 
> 0xff100000. Any hints where to look further?
> 
> Oh, this is a custom 8xx board. Has the support for DMA in 8xx been 
> unstable at the time of pre-2.6.14?
probably your IMAP_ADDR is at 0xff000000, isn't it? if it is, please adjust
CONFIG_CONSISTENT_START to an address like 0xe0000000.

-- 
Aristeu
