Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20093DDF09
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 00:01:46 +1000 (EST)
In-Reply-To: <11840606624025-git-send-email-wei.zhang@freescale.com>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Date: Tue, 10 Jul 2007 16:01:19 +0200
To: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +   k) DMA
> +
> +   This sector define DMA for dma-engine driver of Freescale

It's called a "device node" or "node", not a "sector".

> +    - compatible : Should be "fsl,mpc8xxx-dma"

Should _include_, not should _be_.  And none of this xxx
business, of course.

> +    - extended : Set the DMA channel to work at extended chain mode.
> +                 If not set, the DMA channel will work at basic
> +                 chain mode.

Call it "extended-chain-mode", perhaps?

> +    - reserved : Reserve the DMA channel to device.

What does this do?  Reserve it for what device, and where?
The OS driver?


Segher
