Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D2993DDE16
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:16:19 +1000 (EST)
Date: Fri, 28 Sep 2007 15:19:46 -0500
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 02/18] Add Kconfig macros for Xilinx Virtex support
Message-ID: <20070928201946.GB23749@lixom.net>
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181558.18608.23527.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070928181558.18608.23527.stgit@trillian.cg.shawcable.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 28, 2007 at 12:16:01PM -0600, Grant Likely wrote:
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

I would appreciate a bit verboser help text here, i.e. including what
boards are considered generic. Maybe something like "...including ML403,
<x>, <y>, and other 4FX/IIPro-based boards"?


-Olof
