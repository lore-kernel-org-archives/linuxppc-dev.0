Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 10155DDE98
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 17:28:47 +1100 (EST)
Date: Wed, 18 Mar 2009 23:28:35 -0700 (PDT)
Message-Id: <20090318.232835.178183479.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] gianfar: pass the proper dev to DMA ops
From: David Miller <davem@davemloft.net>
In-Reply-To: <1237306567-32219-1-git-send-email-galak@kernel.crashing.org>
References: <1237306567-32219-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: becky.bruce@freescale.com, netdev@vger.kernel.org, afleming@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 17 Mar 2009 11:16:07 -0500

> We need to be passing the of_platform device struct into the DMA ops as
> its the one that has the archdata setup to know which low-level DMA ops we
> should be using (not the net_device one).  This isn't an issue until we
> expect the archdata to be setup correctly.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Dave,
> 
> This is for net-next.  We are working on having per device dma ops for .30 and
> expect the struct device archdata to be setup properly but in .29 we still
> default to a direct DMA ops on ppc32 so this "bug" will never show up.

Applied to net-next-2.6, thanks.
