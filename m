Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35430DDEE1
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 01:38:50 +1000 (EST)
Message-Id: <9C354395-540E-4298-9DAF-FDCCC9A1C1E6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1210370792-23334-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Update defconfig for MPC8610 HPCD
Date: Mon, 12 May 2008 10:38:42 -0500
References: <1210370792-23334-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 9, 2008, at 5:06 PM, Timur Tabi wrote:

> Update the defconfig for the Freescale MPC8610 HPCD board.  Enable  
> module
> support.  Disable support for all NICs except for the on-board  
> ULI526x.
> Enable support for the Freescale DIU driver.  Increase the maximum  
> zone order
> to 12, so that the DIU driver can allocate physically-contiguous 5MB  
> buffers.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> Support for the Freescale generic DMA driver will have to wait until  
> 2.6.27
> because the current audio driver for the 8610 is incompatible with it.

I've updated the defconfig based on some patches from Anton V.  Can  
you respin this against my powerpc-next branch.

- k
