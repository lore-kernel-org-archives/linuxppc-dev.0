Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep18-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id DF798DDDEC
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 08:54:28 +1100 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/40x: Don't enable HCU4 board by default
Date: Fri, 24 Oct 2008 23:54:24 +0200
References: <20081024143158.GA13766@yoda.jdub.homelinux.org>
In-Reply-To: <20081024143158.GA13766@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810242354.24984.niklaus.giger@member.fsf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Freitag 24 Oktober 2008 16.31:58 schrieb Josh Boyer:
> Fix the HCU4 Kconfig option to 'default n'.  We don't want the
> board to always be enabled for other board defconfigs.
Sorry, for this silly mistake. Thanks for your fix.

My board compiles and runs fine using Linus 2.6.28-rc1.

>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
> ---
>
> diff --git a/arch/powerpc/platforms/40x/Kconfig
> b/arch/powerpc/platforms/40x/Kconfig index 6573027..14e027f 100644
> --- a/arch/powerpc/platforms/40x/Kconfig
> +++ b/arch/powerpc/platforms/40x/Kconfig
> @@ -35,7 +35,7 @@ config EP405
>  config HCU4
>  	bool "Hcu4"
>  	depends on 40x
> -	default y
> +	default n
>  	select 405GPR
>  	help
>  	  This option enables support for the Nestal Maschinen HCU4 board.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
Best regards

Niklaus
