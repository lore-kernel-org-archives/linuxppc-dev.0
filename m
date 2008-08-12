Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc: some vmlinux files that should be ignored 
In-reply-to: <20080811185629.11ed547f@lappy.seanm.ca> 
References: <20080811185629.11ed547f@lappy.seanm.ca>
Date: Tue, 12 Aug 2008 15:11:56 -0500
Message-ID: <28951.1218571916@neuling.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <20080811185629.11ed547f@lappy.seanm.ca> you wrote:
> A couple of vmlinux output files that should be ignored: vmlinux.strip
> and vmlinux.lds.
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> ---
> diff --git a/.gitignore b/.gitignore

This will need to goto LKML.

Mikey

> index 869e1a3..f7e924a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -32,6 +32,7 @@
>  tags
>  TAGS
>  vmlinux
> +vmlinux.strip
>  System.map
>  Module.markers
>  Module.symvers
> diff --git a/arch/powerpc/kernel/.gitignore b/arch/powerpc/kernel/.gitignore
> new file mode 100644
> index 0000000..c5f676c
> --- /dev/null
> +++ b/arch/powerpc/kernel/.gitignore
> @@ -0,0 +1 @@
> +vmlinux.lds
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
