Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3327BDDF8C
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 04:20:52 +1000 (EST)
Message-ID: <46FD45FA.3000205@freescale.com>
Date: Fri, 28 Sep 2007 13:20:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 02/18] Add Kconfig macros for Xilinx Virtex support
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181558.18608.23527.stgit@trillian.cg.shawcable.net>
In-Reply-To: <20070928181558.18608.23527.stgit@trillian.cg.shawcable.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  arch/powerpc/platforms/40x/Kconfig |   30 +++++++++++++++++-------------
>  1 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
> index c3dce3b..1aae0e6 100644
> --- a/arch/powerpc/platforms/40x/Kconfig
> +++ b/arch/powerpc/platforms/40x/Kconfig
> @@ -61,13 +61,14 @@ config WALNUT
>  	help
>  	  This option enables support for the IBM PPC405GP evaluation board.
>  
> -#config XILINX_ML300
> -#	bool "Xilinx-ML300"
> -#	depends on 40x
> -#	default y
> -#	select VIRTEX_II_PRO
> -#	help
> -#	  This option enables support for the Xilinx ML300 evaluation board.
> +config XILINX_VIRTEX_GENERIC_BOARD
> +	bool "Generic Xilinx Virtex board"
> +	depends on 40x
> +	default y
> +	select VIRTEX_II_PRO
> +	select VIRTEX_4_FX
> +	help
> +	  This option enables generic support for Xilinx Virtex based boards.

I don't think we want default y here.

-Scott
