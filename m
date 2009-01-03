Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D927ADE039
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jan 2009 16:32:41 +1100 (EST)
Subject: Re: Status of fsl booke TLB and ATMU patches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <xyzzy@speakeasy.org>
In-Reply-To: <Pine.LNX.4.58.0901021611260.25853@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0901021611260.25853@shell2.speakeasy.net>
Content-Type: text/plain
Date: Sat, 03 Jan 2009 16:30:30 +1100
Message-Id: <1230960630.15389.102.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Gala Kumar <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-01-02 at 16:18 -0800, Trent Piepho wrote:
> 2.6.28 is out, can my existing patches be accepted?

It's all FSL stuff and thus in Kumar's hands. I think there's a pending
pull request from him tho, thus maybe they are in there already :-)

I've just officially taken over so I'll scrub patchwork and outstanding
sub maintainer pull requests if any early next week.

Cheers,
Ben.

> [2/2] POWERPC/fsl-pci: Set relaxed ordering on prefetchable ranges
> http://patchwork.ozlabs.org/patch/14546/
> 
> [1/2] POWERPC/fsl-pci: Better ATMU setup
> http://patchwork.ozlabs.org/patch/14544/
> 
> [5/5] powerpc: booke: Allow larger CAM sizes than 256 MB
> http://patchwork.ozlabs.org/patch/12885/
> 
> [4/5] powerpc: booke: Make CAM entries used for lowmem configurable
> http://patchwork.ozlabs.org/patch/12884/
> 
> [3/5] powerpc: booke: Remove code duplication in lowmem mapping
> http://patchwork.ozlabs.org/patch/12883/
> 
> [2/5] powerpc: booke: Remove num_tlbcam_entries
> http://patchwork.ozlabs.org/patch/12882/
> 
> [1/5] powerpc: booke: Don't hard-code size of struct tlbcam
> http://patchwork.ozlabs.org/patch/12881/
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
