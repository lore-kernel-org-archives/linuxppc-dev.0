Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ECD42DDE01
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 10:56:27 +1100 (EST)
Subject: Re: [PATCH] powerpc: Remove Kconfig support for PPC_MERGE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1224525826-17049-1-git-send-email-galak@kernel.crashing.org>
References: <1224525826-17049-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 10:56:20 +1100
Message-Id: <1224546980.7654.200.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-20 at 13:03 -0500, Kumar Gala wrote:
> There are no users of PPC_MERGE in tree so we can get rid of it.
> It was a hold over from the arch/ppc days.

That's is all good but shouldn't be in your git tree for merge.

Ben.

> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/Kconfig |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9391199..369d93e 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -19,9 +19,6 @@ config WORD_SIZE
>  	default 64 if PPC64
>  	default 32 if !PPC64
>  
> -config PPC_MERGE
> -	def_bool y
> -
>  config ARCH_PHYS_ADDR_T_64BIT
>         def_bool PPC64 || PHYS_64BIT
>  
