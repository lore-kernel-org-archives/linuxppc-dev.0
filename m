Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E2696DDFE0
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 16:53:53 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4V6rmPX027118
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 23:53:48 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4V6rlDa026146
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 01:53:47 -0500 (CDT)
Subject: Re: [PATCH 1/3] Let subordinate transparent bridges be transparent.
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1180462974.13106.61.camel@ld0161-tx32>
References: <1180462974.13106.61.camel@ld0161-tx32>
Content-Type: text/plain
Message-Id: <1180594395.16792.2.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 31 May 2007 14:53:15 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-30 at 02:22, Jon Loeliger wrote:
> From: York Sun <yorksun@freescale.com>
> 
> In pcibios_fixup_bus(), bridges that are subordinate
> to transparent bridges were still relocating their
> IORESOURCE_IO start and end values.
> 
> Fix this by preventing the transparent bridge from
> relocating the start and end values, thus allowing the
> subordinate non-transparent bridge full molestation rights.
> 
> Signed-off-by: York Sun <yorksun@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
