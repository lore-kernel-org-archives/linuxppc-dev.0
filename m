Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 1E02067A7F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jan 2005 05:57:54 +1100 (EST)
Date: Fri, 28 Jan 2005 11:57:31 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Colin Wernham <cwernham@Airspan.com>
Message-ID: <20050128115731.A9757@cox.net>
References: <41EF8E33.9090909@airspan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41EF8E33.9090909@airspan.com>;
	from cwernham@Airspan.com on Thu, Jan 20, 2005 at 10:55:47AM +0000
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH]PPC4XX Dma fixes, burst and sg improvements
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jan 20, 2005 at 10:55:47AM +0000, Colin Wernham wrote:
> I have DMA fixes and improvements to the following PPC4XX files [2.6.10]:
> 
> ppc4xx_dma.h
> ppc4xx_dma.c
> ppc4xx_sgdma.c
> 
> The fixes/improvements are:

<snip>

Thanks for the changes. Can you resubmit such that your mailer
does not mangle the patch? I can't apply it to a tree in the
current state. If you absolutely can't fix your mailer, then
just attach it.

-Matt
