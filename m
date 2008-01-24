Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13759DDEAB
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 07:12:39 +1100 (EST)
Date: Thu, 24 Jan 2008 14:12:26 -0600
From: Scott Wood <scottwood@freescale.com>
To: Poonam_Aggrwal-b10812 <b10812@freescale.com>
Subject: Re: [PATCH UCC TDM 3/3 ] Modified Documentation to explain dts
	entries for TDM driver
Message-ID: <20080124201226.GA3926@loki.buserror.net>
References: <Pine.LNX.4.64.0801241022070.27491@linux121>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0801241022070.27491@linux121>
Cc: michael.barkowski@freescale.com, netdev@vger.kernel.org,
	kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	rubini@vision.unipv.it, linuxppc-dev@ozlabs.org,
	ashish.kalra@freescale.com, rich.cutler@freescale.com,
	akpm@linux-foundation.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 24, 2008 at 10:24:13AM +0530, Poonam_Aggrwal-b10812 wrote:
> +  ix) Baud Rate Generator (BRG)
> +
> +  Required properties:
> +  - compatible : shpuld be "fsl,cpm-brg"
> +  - fsl,brg-sources : define the input clock for all 16 BRGs. The input
> +    clock source could be 1 to 24 for CLK1 to CLK24. Zero means that the
> +    particular BRG will be driven by QE clock(BRGCLK).

Should also have a clock-frequency property to specify what BRGCLK is.

-Scott
