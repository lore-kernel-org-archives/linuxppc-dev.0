Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/6] powerpc: Define CPU_FTR_HAS_PPR
In-reply-to: <1351666334.32304.13.camel@hbabu-laptop>
References: <1351666334.32304.13.camel@hbabu-laptop>
Date: Fri, 23 Nov 2012 15:01:42 +1100
Message-ID: <28905.1353643302@neuling.org>
Cc: anton@au1.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Heaven Myneni <haren@linux.vnet.ibm.com> wrote:

> [PATCH 2/6] powerpc: Define CPU_FTR_HAS_PPR
> 
> CPU_FTR_HAS_PPR is defined for POWER7.
> 
> Signed-off-by: Haren Myneni <haren@us.ibm.com>
> ---
>  arch/powerpc/include/asm/cputable.h |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index 21a0687..12e3a1d 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -171,6 +171,7 @@ extern const char *powerpc_base_platform;
>  #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
>  #define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
>  #define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x2000000000000000)
> +#define	CPU_FTR_HAS_PPR			LONG_ASM_CONST(0x4000000000000000)
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -400,7 +401,8 @@ extern const char *powerpc_base_platform;
>  	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
>  	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
>  	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
> -	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY)
> +	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | \
> +	    CPU_FTR_VMX_COPY | CPU_FTR_HAS_PPR)
>  #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
>  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> @@ -422,7 +424,7 @@ extern const char *powerpc_base_platform;
>  	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
>  	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
>  	    CPU_FTRS_POWER7 | CPU_FTRS_CELL | CPU_FTRS_PA6T |		\
> -	    CPU_FTR_VSX)
> +	    CPU_FTR_VSX | CPU_FTR_HAS_PPR)

FYI, there is no need to add this to POSSIBLE, since you are adding it
to POWER7 anyway.

Mikey
