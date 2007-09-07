Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28B49DDF04
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 00:43:41 +1000 (EST)
In-Reply-To: <1189162437484-git-send-email-wei.zhang@freescale.com>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3b29878a7d3d1b14f84b5d3b182cdb98@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5] Add Freescale DMA and DMA channel to
	Documentation/powerpc/booting-without-of.txt file.
Date: Fri, 7 Sep 2007 16:43:35 +0200
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

> +   l) Freescale DMA

> +    - compatible : Should be "fsl,dma".

Please choose some more specific name.  "fsl,mpc8540-dma" would
be a reasonable choice perhaps.

> +    - reg : Offset and length of DMA general status register.
> +    - ranges : Should be defined as specified in 1) to describe the
> +               DMA controller channels.
> +
> +  Example:
> +	dma@21000 {
> +		reg = <21300 4>;

Those don't agree.  It's probably best to describe the whole
DMA controller register block in this node.  Why do you need
subnodes for the channels at all?


Segher
