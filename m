Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13549474C2
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 05:46:20 +1100 (EST)
Message-Id: <1ABC7EC8-380C-42F3-A33A-8F05A4EC9D63@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1223657552-15008-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: document the "fsl,
	ssi-dma-channel" compatible property
Date: Fri, 10 Oct 2008 13:46:03 -0500
References: <1223657552-15008-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 10, 2008, at 11:52 AM, Timur Tabi wrote:

> The "fsl,ssi-dma-channel" compatible property is used to specify a  
> DMA channel
> on the Freescale Elo DMA controller that should be used exclusively  
> by the
> Freescale SSI audio controller.  When a property is marked as such,  
> the Elo
> DMA driver will ignore it, and so it will be available for the sound  
> drivers.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> Documentation/powerpc/dts-bindings/fsl/dma.txt |   13 +++++++++++--
> Documentation/powerpc/dts-bindings/fsl/ssi.txt |   20 +++++++++++++ 
> +------
> 2 files changed, 25 insertions(+), 8 deletions(-)

applied

- k
