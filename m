Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Correct FSCR bit definitions
In-reply-to: <20130905060116.GA24607@drongo>
References: <20130905060116.GA24607@drongo>
Date: Thu, 05 Sep 2013 16:09:40 +1000
Message-ID: <600.1378361380@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> wrote:

> Commit 74e400cee6 ("powerpc: Rework setting up H/FSCR bit definitions")
> ended up with incorrect bit numbers for FSCR_PM_LG and FSCR_BHRB_LG.
> This fixes them.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Michael Neuling <mikey@neuling.org>

Sorry about that screw up.

Mikey

> ---
>  arch/powerpc/include/asm/reg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index dc10bf5..10d1ef0 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -258,8 +258,8 @@
>  #define FSCR_TAR_LG	8	/* Enable Target Address Register */
>  #define FSCR_EBB_LG	7	/* Enable Event Based Branching */
>  #define FSCR_TM_LG	5	/* Enable Transactional Memory */
> -#define FSCR_PM_LG	4	/* Enable prob/priv access to PMU SPRs */
> -#define FSCR_BHRB_LG	3	/* Enable Branch History Rolling Buffer*/
> +#define FSCR_BHRB_LG	4	/* Enable Branch History Rolling Buffer*/
> +#define FSCR_PM_LG	3	/* Enable prob/priv access to PMU SPRs */
>  #define FSCR_DSCR_LG	2	/* Enable Data Stream Control Register */
>  #define FSCR_VECVSX_LG	1	/* Enable VMX/VSX  */
>  #define FSCR_FP_LG	0	/* Enable Floating Point */
> -- 
> 1.8.4.rc3
> 
