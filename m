Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: PPC_CELL_NATIVE should select PCI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0904011141550.13419@vixen.sonytel.be>
References: <alpine.LRH.2.00.0904011141550.13419@vixen.sonytel.be>
Content-Type: text/plain
Date: Wed, 01 Apr 2009 20:54:12 +1100
Message-Id: <1238579652.17330.124.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-04-01 at 11:42 +0200, Geert Uytterhoeven wrote:
> PPC_CELL_NATIVE selects PPC_OF_PLATFORM_PCI, but not the underlying PCI,
> causing build failures if PCI is not set.

Maybe it should only select it if PCI is enabled ? Is qpace using PCI ?

Cheers,
Ben.

> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  arch/powerpc/platforms/cell/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
> index 40e24c3..33f534f 100644
> --- a/arch/powerpc/platforms/cell/Kconfig
> +++ b/arch/powerpc/platforms/cell/Kconfig
> @@ -14,6 +14,7 @@ config PPC_CELL_NATIVE
>  	bool
>  	select PPC_CELL_COMMON
>  	select PPC_OF_PLATFORM_PCI
> +	select PCI
>  	select MPIC
>  	select IBM_NEW_EMAC_EMAC4
>  	select IBM_NEW_EMAC_RGMII
