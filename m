Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A0180DDDDB
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 07:08:33 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAEK8Tsf017153
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 15:08:29 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAEK8REX1441880
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 15:08:27 -0500
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAEK8OcR021708
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 13:08:24 -0700
Date: Wed, 14 Nov 2007 14:08:23 -0600
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] pSeries: make pseries_defconfig minus PCI build
	again
Message-ID: <20071114200823.GA18745@austin.ibm.com>
References: <20071114150739.ec6a0cff.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071114150739.ec6a0cff.sfr@canb.auug.org.au>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 14, 2007 at 03:07:39PM +1100, Stephen Rothwell wrote:
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Linas Vepstas <linas@austin.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> 
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index 16e4e40..306a9d0 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -21,7 +21,7 @@ config PPC_SPLPAR
>  
>  config EEH
>  	bool "PCI Extended Error Handling (EEH)" if EMBEDDED
> -	depends on PPC_PSERIES
> +	depends on PPC_PSERIES && PCI
>  	default y if !EMBEDDED
>  
>  config SCANLOG
> -- 
> 1.5.3.5
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
