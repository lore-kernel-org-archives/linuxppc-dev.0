Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DAE6047528
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 05:46:19 +1100 (EST)
Message-Id: <7DF24CEF-F010-4005-8D9F-D62C733E6458@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1223657552-15008-2-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: reserve two DMA channels for audio in MPC8610
	HPCD device tree
Date: Fri, 10 Oct 2008 13:46:09 -0500
References: <1223657552-15008-1-git-send-email-timur@freescale.com>
	<1223657552-15008-2-git-send-email-timur@freescale.com>
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

> The Freescale Elo DMA driver binds to all DMA channels in the device  
> tree that
> are compatible with "fsl,eloplus-dma-channel".  This conflicts with  
> the sound
> drivers for the MPC8610 HPCD.  On this board, the SSI uses two DMA  
> channels and
> therefore those channels are not available for general purpose use.   
> We
> change the compatible properties for these channels "fsl,ssi-dma- 
> channel".
> This works because the sound drivers don't actually check the  
> compatible
> property when it grabs channels.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8610_hpcd.dts |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied

- k
