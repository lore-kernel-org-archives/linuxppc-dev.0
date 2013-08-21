Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2C6362C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 08:43:30 +1000 (EST)
Message-ID: <5215402E.70007@wwwdotorg.org>
Date: Wed, 21 Aug 2013 16:33:18 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: hongbo.zhang@freescale.com
Subject: Re: [PATCH v7 1/3] DMA: Freescale: revise device tree binding document
References: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
 <1375094944-3343-2-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1375094944-3343-2-git-send-email-hongbo.zhang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree@vger.kernel.org, vinod.koul@intel.com,
 linux-kernel@vger.kernel.org, djbw@fb.com, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2013 04:49 AM, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
> 
> This patch updates the discription of each type of DMA controller and its
> channels, it is preparation for adding another new DMA controller binding, it
> also fixes some defects of indent for text alignment at the same time.

> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt

> -- compatible        : compatible list, contains 2 entries, first is
> -		 "fsl,CHIP-dma", where CHIP is the processor
> -		 (mpc8349, mpc8360, etc.) and the second is
> -		 "fsl,elo-dma"
> +- compatible        : must include "fsl,elo-dma"

Why remove the list of supported compatible values. Lately it seems that
we're moving towards listing more/all the values rather than removing
their documentation...

> -- ranges		: Should be defined as specified in 1) to describe the
> -		  DMA controller channels.
> +- ranges            : describes the mapping between the address space of the
> +                      DMA channels and the address space of the DMA controller

What is "the address space of the DMA controller". Perhaps this should
say "the CPU-visible address space" instead?
