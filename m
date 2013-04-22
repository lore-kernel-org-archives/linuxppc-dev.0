Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH] powerpc/fsl-pci: fix setup_pci_atmu() parameter issue
In-reply-to: <1366397734-1416-1-git-send-email-tie-fei.zang@freescale.com>
References: <1366397734-1416-1-git-send-email-tie-fei.zang@freescale.com>
Date: Mon, 22 Apr 2013 16:56:29 +1000
Message-ID: <4009.1366613789@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This was already posted about a week back.  Kumar can you please take
it?

http://patchwork.ozlabs.org/patch/236494/

Mikey

Roy Zang <tie-fei.zang@freescale.com> wrote:

> setup_pci_atmu() only has one parameter and remove the extra one, or
> build will fail due to un-match.
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 40ffe29..f823304 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -978,7 +978,7 @@ static int fsl_pci_resume(struct device *dev)
>  		return -ENODEV;
>  	}
>  
> -	setup_pci_atmu(hose, &pci_rsrc);
> +	setup_pci_atmu(hose);
>  
>  	return 0;
>  }
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
