Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93593B7D20
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 00:54:29 +1000 (EST)
Date: Tue, 4 May 2010 15:54:30 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/8610: add probing for individual DMA
	channels, not just DMA controllers
Message-ID: <20100504145430.GC3651@opensource.wolfsonmicro.com>
References: <1272923655-31807-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272923655-31807-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 03, 2010 at 04:54:15PM -0500, Timur Tabi wrote:

>  	{ .compatible = "simple-bus", },
> -	{ .compatible = "gianfar", },
> +	/* So that the DMA channel nodes can be probed individually: */
> +	{ .compatible = "fsl,eloplus-dma", },
>  	{}

The removal of gianfar looks a bit surprising here - if it's not a
mistake a note in the changelog would be useful.
