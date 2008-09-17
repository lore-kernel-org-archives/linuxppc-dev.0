Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF6EADE1FA
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 06:06:12 +1000 (EST)
Message-Id: <955412E7-C218-42F6-9101-49A7F23FF39B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1218041305-5298-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc: add SSI-to-DMA properties to Freescale MPC8610
	HPCD device tree
Date: Wed, 17 Sep 2008 15:06:02 -0500
References: <1218041305-5298-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 6, 2008, at 11:48 AM, Timur Tabi wrote:

> Add the fsl,playback-dma and fsl,capture-dma properties to the  
> Freescale
> MPC8610 HPCD device tree.  These properties connect the SSI nodes to  
> the
> DMA nodes for the DMA channels that the SSI should use.  Also update  
> the
> ssi.txt documentation.
>
> These properties will be needed when the ASoC V2 version of the  
> Freescale
> MPC8610 device drivers are merged into the mainline.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> Documentation/powerpc/dts-bindings/fsl/ssi.txt |   15 +++++++++++++++
> arch/powerpc/boot/dts/mpc8610_hpcd.dts         |    8 +++++---
> 2 files changed, 20 insertions(+), 3 deletions(-)

applied.

- k
