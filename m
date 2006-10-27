Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (amanaus.varma-el.com [195.144.240.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7055067CA5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 19:56:43 +1000 (EST)
Message-ID: <4541D7D5.7090001@varma-el.com>
Date: Fri, 27 Oct 2006 13:56:37 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [POWERPC] MPC52xx is a 6xx variant, remove PPC_52xx config option
References: <11618347593934-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11618347593934-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/powerpc/Kconfig |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index f9b11c1..6bff8b7 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -126,11 +126,6 @@ config CLASSIC32
>  	  systems, 64 bit IBM RS/6000 or an Apple G5, choose 6xx.
>  	  Note that the kernel runs in 32-bit mode even on 64-bit chips.
>  
> -config PPC_52xx
> -	bool "Freescale 52xx"
> -	select 6xx
> -	select PPC_FPU
> -	
>  config PPC_82xx
>  	bool "Freescale 82xx"
>  	select 6xx
Please _don't_ do it, since mpc5200 platform drivers depend from this
option.

--
Regards
Andrey Volkov
