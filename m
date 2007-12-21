Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4E42ADF8F5
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 15:43:29 +1100 (EST)
Date: Thu, 20 Dec 2007 22:49:58 -0600
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] Make non-PCI build work again
Message-ID: <20071221044957.GA29801@lixom.net>
References: <20071221153707.5195fc8f.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221153707.5195fc8f.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 03:37:07PM +1100, Stephen Rothwell wrote:
> Maple and pasemi both require PCI as does CONFIG_OF_PLATFORM_PCI.
> The default setting of CONFIG_ISA_DMA_API is set to match the protection
> around the relevant routines in asm/dma.h.
> 
> I also had to remove the PMAC platform from the combined build.  The
> precis is that to build a 64 bit kernel with no PCI, you can only include
> pSeries and iSeries.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/Kconfig                  |    3 ++-
>  arch/powerpc/platforms/maple/Kconfig  |    1 +
>  arch/powerpc/platforms/pasemi/Kconfig |    1 +

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
